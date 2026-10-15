'use strict';

const axios = require('axios');
require('dotenv').config();

// ─────────────────────────────────────────────────────────────────────────────
// Config — mirrors the working xobi/backend/server.js pattern exactly
// ─────────────────────────────────────────────────────────────────────────────
const BASE_URL = (process.env.MESSAGE_CENTRAL_URL || 'https://cpaas.messagecentral.com').replace(/\/$/, '');
const CUSTOMER_ID = process.env.MESSAGE_CENTRAL_CUSTOMER_ID;
const AUTH_TOKEN  = process.env.MESSAGE_CENTRAL_PASSWORD; // Pre-generated JWT stored in env
const SENDER_ID   = process.env.MESSAGE_CENTRAL_SENDER_ID || 'SMSIND'; // Required by MC

// ─────────────────────────────────────────────────────────────────────────────
// Auth Token — use the static JWT from env directly (same as xobi)
// ─────────────────────────────────────────────────────────────────────────────
const getAuthToken = () => {
  if (!AUTH_TOKEN) {
    throw new Error('MESSAGE_CENTRAL_PASSWORD (auth token) is not set in environment variables.');
  }
  return AUTH_TOKEN;
};

// ─────────────────────────────────────────────────────────────────────────────
// parsePhoneNumber — strips country code, returns { countryCode, mobileNumber }
// ─────────────────────────────────────────────────────────────────────────────
const parsePhoneNumber = (rawNumber, defaultCC = '91') => {
  let cleaned = String(rawNumber).replace(/[\s\-\+]/g, '');

  if (cleaned.startsWith('91') && cleaned.length === 12) {
    return { countryCode: '91', mobileNumber: cleaned.slice(2) };
  }
  if (cleaned.length === 10) {
    return { countryCode: defaultCC, mobileNumber: cleaned };
  }
  if (cleaned.length > 10) {
    return {
      countryCode: cleaned.slice(0, cleaned.length - 10),
      mobileNumber: cleaned.slice(-10),
    };
  }
  return { countryCode: defaultCC, mobileNumber: cleaned };
};

// ─────────────────────────────────────────────────────────────────────────────
// sendOTP
// Mirrors xobi exactly:
//   POST /verification/v3/send?countryCode=91&flowType=SMS&mobileNumber=XXXXXXXXXX
//                              &senderId=SMSIND&type=OTP&otpLength=4
// Header: authToken: <jwt>
// Returns { success: true, verificationId }
// ─────────────────────────────────────────────────────────────────────────────
const sendOTP = async (rawMobileNumber) => {
  const { countryCode, mobileNumber } = parsePhoneNumber(rawMobileNumber);
  const token = getAuthToken();

  const sendUrl = `${BASE_URL}/verification/v3/send?countryCode=${countryCode}&flowType=SMS&mobileNumber=${mobileNumber}&senderId=${SENDER_ID}&type=OTP&otpLength=4`;

  console.log(`[OTP] Sending OTP to +${countryCode}${mobileNumber} | URL: ${sendUrl}`);

  const response = await axios.post(sendUrl, null, {
    headers: { authToken: token },
  });

  const result = response.data;
  console.log(`[OTP] Message Central /send response:`, JSON.stringify(result));

  if (result.responseCode === 200 && result.data && result.data.verificationId) {
    return { success: true, verificationId: result.data.verificationId };
  }

  throw new Error(result.message || `Message Central send failed: ${JSON.stringify(result)}`);
};

// ─────────────────────────────────────────────────────────────────────────────
// verifyOTP
// Mirrors xobi exactly:
//   GET /verification/v3/validateOtp?verificationId=XXX&code=YYYY
// Header: authToken: <jwt>
// Returns true if verified, false otherwise
// ─────────────────────────────────────────────────────────────────────────────
const verifyOTP = async (verificationId, code) => {
  if (!verificationId || !code) return false;

  const token = getAuthToken();
  const validateUrl = `${BASE_URL}/verification/v3/validateOtp?verificationId=${verificationId}&code=${code}`;

  const response = await axios.get(validateUrl, {
    headers: { authToken: token },
  });

  const result = response.data;
  console.log(`[OTP] Message Central /validateOtp response:`, JSON.stringify(result));

  // Mirror xobi's success check
  const isSuccess =
    String(result.responseCode) === '200' &&
    (result.message === 'SUCCESS' ||
      (result.data && (result.data.status === 'VERIFIED' || result.data.status === 'SUCCESS')));

  return isSuccess;
};

module.exports = { sendOTP, verifyOTP, parsePhoneNumber };