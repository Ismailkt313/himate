'use strict';

const OTP    = require('../models/otpModel');
const User   = require('../models/userModel');
const joi    = require('joi');
const { generateToken, generateRefreshToken } = require('../middleware/auth');
const { sendOTP, verifyOTP } = require('../utils/smsService');

// ─────────────────────────────────────────────────────────────────────────────
// POST /auth/send-otp
// Body: { mobileNumber: "9500574746" }
// ─────────────────────────────────────────────────────────────────────────────
exports.sendOTP = async (req, res) => {
  try {
    if (req.body.mobileNumber) {
      req.body.mobileNumber = String(req.body.mobileNumber).replace(/[\s\-\+]/g, '');
    }

    const schema = joi.object({
      mobileNumber: joi.string().pattern(/^[0-9]{10,15}$/).required(),
    });

    const { error } = schema.validate(req.body);
    if (error) {
      return res.status(400).json({ success: false, message: error.details[0].message });
    }

    const { mobileNumber } = req.body;

    // Trigger Message Central VerifyNow — they generate + deliver the OTP
    const { verificationId } = await sendOTP(mobileNumber);

    // Persist verificationId so we can validate it on the next step
    await OTP.deleteMany({ mobileNumber });
    await OTP.create({ mobileNumber, otp: verificationId });

    console.log(`[AUTH] OTP sent to ${mobileNumber}, verificationId: ${verificationId}`);

    return res.status(200).json({
      success: true,
      message: 'OTP sent successfully to your mobile number',
    });
  } catch (err) {
    console.error('[AUTH] sendOTP error:', err.response?.data || err.message);
    return res.status(500).json({
      success: false,
      message: 'Failed to send OTP. Please try again.',
      error: err.message,
    });
  }
};

// ─────────────────────────────────────────────────────────────────────────────
// POST /auth/verify-otp
// Body: { mobileNumber: "9500574746", otp: "1234" }
// ─────────────────────────────────────────────────────────────────────────────
exports.verifyOTP = async (req, res) => {
  try {
    if (req.body.mobileNumber) {
      req.body.mobileNumber = String(req.body.mobileNumber).replace(/[\s\-\+]/g, '');
    }

    const schema = joi.object({
      mobileNumber: joi.string().pattern(/^[0-9]{10,15}$/).required(),
      otp:          joi.string().length(4).required(),
    });

    const { error } = schema.validate(req.body);
    if (error) {
      return res.status(400).json({ success: false, message: error.details[0].message });
    }

    const { mobileNumber, otp } = req.body;

    // Fetch the stored verificationId
    const record = await OTP.findOne({ mobileNumber });
    if (!record) {
      return res.status(400).json({ success: false, message: 'OTP not found or already used. Please request a new OTP.' });
    }

    // Check expiry (5 minutes)
    const ageMs = Date.now() - record.createdAt.getTime();
    if (ageMs > 5 * 60 * 1000) {
      await OTP.deleteOne({ _id: record._id });
      return res.status(400).json({ success: false, message: 'OTP has expired. Please request a new one.' });
    }

    // Validate with Message Central
    const isValid = await verifyOTP(record.otp, otp);
    if (!isValid) {
      return res.status(400).json({ success: false, message: 'Invalid OTP. Please try again.' });
    }

    // Clean up used OTP record
    await OTP.deleteOne({ _id: record._id });

    // Find or create the user — track whether this is a brand-new registration
    let user = await User.findOne({ mobileNumber });
    const isNewUser = !user;
    if (!user) {
      user = await User.create({ mobileNumber });
    }

    const token = generateToken(user._id);
    const refreshToken = generateRefreshToken(user._id);

    return res.status(200).json({
      success: true,
      message: 'OTP verified successfully',
      token,
      refreshToken,
      isNewUser,        // true  → new registration, route to onboarding
                        // false → returning user, route to home
      user: {
        id:                user._id,
        mobileNumber:      user.mobileNumber,
        username:          user.username,
        gender:            user.gender,
        isProfileComplete: user.profileCompletion ? user.profileCompletion.isComplete : false,
      },
    });
  } catch (err) {
    console.error('[AUTH] verifyOTP error:', err.response?.data || err.message);
    return res.status(500).json({
      success: false,
      message: 'Error verifying OTP. Please try again.',
      error: err.message,
    });
  }
};

// ─────────────────────────────────────────────────────────────────────────────
// GET /auth/users  (admin utility)
// ─────────────────────────────────────────────────────────────────────────────
exports.GetUsers = async (req, res) => {
  try {
    const users = await User.find().select('-__v');
    if (!users || users.length === 0) {
      return res.status(404).json({ success: false, message: 'No users found' });
    }
    return res.status(200).json({ success: true, data: users, message: 'Users retrieved successfully' });
  } catch (err) {
    console.error('[AUTH] GetUsers error:', err);
    return res.status(500).json({ success: false, message: 'Internal server error' });
  }
};

// ─────────────────────────────────────────────────────────────────────────────
// POST /auth/refresh
// Body: { refreshToken: "<jwt>" }
// ─────────────────────────────────────────────────────────────────────────────
exports.refreshToken = async (req, res) => {
  try {
    const { refreshToken } = req.body;
    if (!refreshToken) {
      return res.status(400).json({ success: false, message: 'Refresh token is required' });
    }

    const jwt = require('jsonwebtoken');
    const decoded = jwt.verify(refreshToken, process.env.JWT_SECRET);

    if (decoded.type !== 'refresh') {
      return res.status(400).json({ success: false, message: 'Invalid token type' });
    }

    const user = await User.findById(decoded.userId);
    if (!user) {
      return res.status(401).json({ success: false, message: 'User not found' });
    }

    const newAccessToken = generateToken(user._id);
    const newRefreshToken = generateRefreshToken(user._id);

    return res.status(200).json({
      success: true,
      accessToken: newAccessToken,
      refreshToken: newRefreshToken,
    });
  } catch (err) {
    console.error('[AUTH] refreshToken error:', err.message);
    return res.status(401).json({ success: false, message: 'Invalid or expired refresh token' });
  }
};