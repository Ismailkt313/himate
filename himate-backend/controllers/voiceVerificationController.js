const axios = require('axios');
const { execFile } = require('child_process');
const VoiceVerification = require('../models/voiceVerificationModel');
const User = require('../models/userModel');
const Joi = require('joi');
const multer = require('multer');
const path = require('path');
const fs = require('fs');

// Create uploads directory for voice files
const voiceUploadsDir = 'uploads/voice-verification';
if (!fs.existsSync(voiceUploadsDir)) {
    fs.mkdirSync(voiceUploadsDir, { recursive: true });
}

// Multer configuration for voice files
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, voiceUploadsDir);
    },
    filename: (req, file, cb) => {
        const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
        const userId = req.user.id;
        cb(null, `voice-${userId}-${uniqueSuffix}${path.extname(file.originalname)}`);
    }
});

const upload = multer({
    storage: storage,
    limits: {
        fileSize: 10 * 1024 * 1024, // 10MB limit
        files: 1
    },
    fileFilter: (req, file, cb) => {
        // Accept audio files
        const allowedTypes = /wav|mp3|m4a|aac|ogg|webm/;
        const extname = allowedTypes.test(path.extname(file.originalname).toLowerCase());
        const mimetype = file.mimetype.startsWith('audio/');
        
        if (mimetype && extname) {
            return cb(null, true);
        } else {
            cb(new Error('Only audio files are allowed!'));
        }
    }
});

// Validation schemas
const voiceUploadSchema = Joi.object({
    deviceInfo: Joi.string().optional(),
    recordingEnvironment: Joi.string().valid('quiet', 'moderate', 'noisy').default('moderate')
});

// Voice verification phrases
const verificationPhrases = [
    "What is your favourite flower?",
    "My voice is unique and this is my verification",
    "I am creating my dating profile with my real voice",
    "This is my voice verification for authentication",
    "Hello, I am confirming my identity with my voice"
];

// Get random verification phrase
const getVerificationPhrase = (req, res) => {
    try {
        const randomPhrase = verificationPhrases[Math.floor(Math.random() * verificationPhrases.length)];
        
        res.status(200).json({
            success: true,
            data: {
                phrase: randomPhrase,
                instructions: [
                    "Please record yourself saying the phrase clearly",
                    "Speak in a quiet environment with minimal background noise",
                    "Use your natural speaking voice",
                    "Recording should be 3-10 seconds long",
                    "Make sure your microphone is working properly"
                ]
            }
        });
        
    } catch (error) {
        console.error('Get verification phrase error:', error);
        res.status(500).json({
            success: false,
            message: 'Failed to get verification phrase'
        });
    }
};

// Upload and analyze voice
const uploadVoiceVerification = async (req, res) => {
    try {
        const userId = req.user.id;
        
        // Check if user is female (voice verification only required for females)
        const user = await User.findById(userId);
        if (!user) {
            return res.status(404).json({
                success: false,
                message: 'User not found'
            });
        }
        
        if (user.gender !== 'Female') {
            return res.status(400).json({
                success: false,
                message: 'Voice verification is only required for female users'
            });
        }
        
        // Check if already verified
        if (user.voiceVerification.isVerified) {
            return res.status(400).json({
                success: false,
                message: 'Voice verification already completed'
            });
        }
        
        // Check attempt limit
        if (user.voiceVerification.attempts >= 3) {
            return res.status(400).json({
                success: false,
                message: 'Maximum verification attempts reached. Please contact support.'
            });
        }
        
        if (!req.file) {
            return res.status(400).json({
                success: false,
                message: 'No audio file provided'
            });
        }
        
        const { error, value } = voiceUploadSchema.validate(req.body);
        if (error) {
            return res.status(400).json({
                success: false,
                message: 'Validation error',
                errors: error.details.map(detail => detail.message)
            });
        }
        
        // Get file information
        const audioFile = req.file;
        const audioFileUrl = `/uploads/voice-verification/${audioFile.filename}`;
        
        // Get audio duration (simplified - in real app you'd use audio processing library)
        const audioDuration = await getAudioDuration(audioFile.path);
        
        // Validate audio duration
        if (audioDuration < 2 || audioDuration > 15) {
            // Delete the uploaded file
            fs.unlinkSync(audioFile.path);
            return res.status(400).json({
                success: false,
                message: 'Audio must be between 2-15 seconds long'
            });
        }
        
        // Delete existing verification record if exists
        await VoiceVerification.findOneAndDelete({ userId });
        
        // Create voice verification record
        const voiceVerification = new VoiceVerification({
            userId,
            audioFileUrl,
            audioFileName: audioFile.filename,
            audioFileSize: audioFile.size,
            audioDuration,
            verificationText: req.body.phrase || verificationPhrases[0],
            verificationStatus: 'processing',
            metadata: {
                deviceInfo: value.deviceInfo,
                recordingEnvironment: value.recordingEnvironment,
                ipAddress: req.ip,
                userAgent: req.get('User-Agent')
            }
        });
        
        await voiceVerification.save();
        
        // Update user's voice verification attempts
        user.voiceVerification.attempts += 1;
        user.voiceVerification.lastAttemptAt = new Date();
        await user.save();
        
        // Start voice analysis (in background)
        processVoiceVerification(voiceVerification._id);
        
        res.status(200).json({
            success: true,
            message: 'Voice uploaded successfully. Analysis in progress...',
            data: {
                verificationId: voiceVerification._id,
                status: 'processing',
                estimatedTime: '30-60 seconds'
            }
        });
        
    } catch (error) {
        console.error('Upload voice verification error:', error);
        
        // Clean up uploaded file if error occurs
        if (req.file && fs.existsSync(req.file.path)) {
            fs.unlinkSync(req.file.path);
        }
        
        res.status(500).json({
            success: false,
            message: 'Failed to upload voice verification'
        });
    }
};

// Check verification status
const checkVerificationStatus = async (req, res) => {
    try {
        const userId = req.user.id;
        const { verificationId } = req.params;
        
        const voiceVerification = await VoiceVerification.findOne({
            _id: verificationId,
            userId
        });
        
        if (!voiceVerification) {
            return res.status(404).json({
                success: false,
                message: 'Voice verification not found'
            });
        }
        
        const user = await User.findById(userId);
        
        res.status(200).json({
            success: true,
            data: {
                status: voiceVerification.verificationStatus,
                isVerified: voiceVerification.isVerified,
                confidence: voiceVerification.confidence,
                detectedGender: voiceVerification.detectedGender,
                canRetry: voiceVerification.canRetry(),
                attemptsRemaining: 3 - user.voiceVerification.attempts,
                result: voiceVerification.verificationResult,
                failureReason: voiceVerification.failureReason,
                message: voiceVerification.getFailureMessage()
            }
        });
        
    } catch (error) {
        console.error('Check verification status error:', error);
        res.status(500).json({
            success: false,
            message: 'Failed to check verification status'
        });
    }
};

// Get verification requirements
const getVerificationRequirements = async (req, res) => {
    try {
        const userId = req.user.id;
        const user = await User.findById(userId);
        
        if (!user) {
            return res.status(404).json({
                success: false,
                message: 'User not found'
            });
        }
        
        res.status(200).json({
            success: true,
            data: {
                isRequired: user.voiceVerification.isRequired,
                isCompleted: user.voiceVerification.isCompleted,
                isVerified: user.voiceVerification.isVerified,
                attempts: user.voiceVerification.attempts,
                maxAttempts: 3,
                canAttempt: user.voiceVerification.attempts < 3,
                requirements: {
                    reason: "Voice verification is required for female users to ensure profile authenticity",
                    audioFormat: "MP3, WAV, M4A, AAC, OGG, or WebM",
                    duration: "2-15 seconds",
                    quality: "Clear speech in quiet environment",
                    fileSize: "Maximum 10MB"
                }
            }
        });
        
    } catch (error) {
        console.error('Get verification requirements error:', error);
        res.status(500).json({
            success: false,
            message: 'Failed to get verification requirements'
        });
    }
};

// Retry verification (for failed attempts)
const retryVerification = async (req, res) => {
    try {
        const userId = req.user.id;
        
        const user = await User.findById(userId);
        if (!user) {
            return res.status(404).json({
                success: false,
                message: 'User not found'
            });
        }
        
        if (user.voiceVerification.attempts >= 3) {
            return res.status(400).json({
                success: false,
                message: 'Maximum verification attempts reached. Please contact support.'
            });
        }
        
        if (user.voiceVerification.isVerified) {
            return res.status(400).json({
                success: false,
                message: 'Voice verification already completed'
            });
        }
        
        // Delete previous verification record and file
        const previousVerification = await VoiceVerification.findOne({ userId });
        if (previousVerification) {
            // Delete audio file
            const filePath = path.join(voiceUploadsDir, previousVerification.audioFileName);
            if (fs.existsSync(filePath)) {
                fs.unlinkSync(filePath);
            }
            await VoiceVerification.findOneAndDelete({ userId });
        }
        
        res.status(200).json({
            success: true,
            message: 'Ready for new verification attempt',
            data: {
                attemptsRemaining: 3 - user.voiceVerification.attempts,
                phrase: verificationPhrases[Math.floor(Math.random() * verificationPhrases.length)]
            }
        });
        
    } catch (error) {
        console.error('Retry verification error:', error);
        res.status(500).json({
            success: false,
            message: 'Failed to retry verification'
        });
    }
};

// Helper function to get audio duration using Python
async function getAudioDuration(filePath) {
    try {
        const result = await analyzeGenderWithPython(filePath);
        if (result && result.duration > 0) {
            return result.duration;
        }
        
        // Fallback rough estimate if Python fails
        const stats = fs.statSync(filePath);
        const fileSizeInBytes = stats.size;
        
        // Default to 5 seconds if Python fails and we can't estimate reliably
        return 5;
    } catch (error) {
        console.error('Error getting audio duration:', error);
        return 5; // Default fallback
    }
}

// Voice analysis using AssemblyAI
async function processVoiceVerification(verificationId) {
    try {
        const verification = await VoiceVerification.findById(verificationId);
        if (!verification) return;

        const audioFilePath = require('path').join('uploads/voice-verification', verification.audioFileName);
        const fs = require('fs');
        if (!fs.existsSync(audioFilePath)) {
            await verification.markAsFailed('technical_error', 0);
            return;
        }

        const analysisResult = await analyzeWithAssemblyAI(audioFilePath);

        verification.audioAnalysis = {
            fundamentalFrequency: analysisResult.fundamentalFrequency,
            pitchRange: analysisResult.pitchRange,
            spectralCentroid: analysisResult.spectralCentroid,
            voiceQualityScore: analysisResult.qualityScore,
            noiseLevel: analysisResult.noiseLevel,
            speechClarity: analysisResult.clarity
        };

        verification.detectedGender = analysisResult.detectedGender;
        verification.confidence = analysisResult.confidence;

        if (analysisResult.detectedGender === 'female' && analysisResult.confidence >= 75) {
            await verification.markAsVerified(analysisResult.confidence);

            const User = require('../models/userModel');
            const user = await User.findById(verification.userId);
            if (user) {
                user.voiceVerification.isCompleted = true;
                user.voiceVerification.isVerified = true;
                user.voiceVerification.verifiedAt = new Date();
                user.profileCompletion.voiceVerification.isComplete = true;
                user.profileCompletion.voiceVerification.completedAt = new Date();
                await user.save();
            }
        } else if (analysisResult.confidence < 60) {
            await verification.markAsFailed('poor_audio_quality', analysisResult.confidence);
        } else if (analysisResult.detectedGender !== 'female') {
            await verification.markAsFailed('voice_gender_mismatch', analysisResult.confidence);
        } else {
            await verification.markAsFailed('manual_review_required', analysisResult.confidence);
        }

    } catch (error) {
        console.error('Voice processing error:', error);
        const VoiceVerification = require('../models/voiceVerificationModel');
        const verification = await VoiceVerification.findById(verificationId);
        if (verification) {
            await verification.markAsFailed('technical_error', 0);
        }
    }
}

function analyzeGenderWithPython(audioFilePath) {
    return new Promise((resolve) => {
        const path = require('path');
        const { execFile } = require('child_process');
        const scriptPath = path.join(__dirname, '..', 'utils', 'voice_gender_analyzer.py');
        execFile('python3', [scriptPath, audioFilePath], { timeout: 30000 }, (err, stdout) => {
            if (err) {
                console.error('[VoiceVerification] Python gender analysis error:', err.message);
                resolve({ detectedGender: 'unknown', confidence: 0, f0: 0, duration: 0 });
                return;
            }
            try {
                resolve(JSON.parse(stdout.trim()));
            } catch {
                console.error('[VoiceVerification] Failed to parse Python output:', stdout);
                resolve({ detectedGender: 'unknown', confidence: 0, f0: 0, duration: 0 });
            }
        });
    });
}

function analyzeContentSafety(transcript) {
    const safetyResults = transcript.content_safety_labels?.results || [];
    const issues = [];
    for (const item of safetyResults) {
        if (item.labels) {
            for (const label of item.labels) {
                if (label.confidence > 0.5) {
                    issues.push({ label: label.label, confidence: label.confidence });
                }
            }
        }
    }
    return issues;
}

async function analyzeWithAssemblyAI(audioFilePath) {
    const apiKey = process.env.ASSEMBLYAI_API_KEY;
    if (!apiKey) throw new Error('ASSEMBLYAI_API_KEY not set');

    const extMap = {
        '.wav': 'audio/wav', '.mp3': 'audio/mpeg', '.m4a': 'audio/mp4',
        '.aac': 'audio/aac', '.ogg': 'audio/ogg', '.webm': 'audio/webm'
    };
    const ext = path.extname(audioFilePath).toLowerCase();
    const contentType = extMap[ext] || 'audio/mpeg';

    const audioData = fs.readFileSync(audioFilePath);

    // Step 1: Upload audio to AssemblyAI
    console.log('[VoiceVerification] Uploading audio to AssemblyAI...');
    const uploadRes = await axios.post('https://api.assemblyai.com/v2/upload', audioData, {
        headers: { authorization: apiKey, 'Content-Type': contentType },
    });
    const audioUrl = uploadRes.data.upload_url;
    console.log(`[VoiceVerification] Audio uploaded: ${audioUrl}`);

    // Step 2: Submit transcription with content_safety (as requested)
    console.log('[VoiceVerification] Submitting transcription with content_safety...');
    const transcriptReq = await axios.post('https://api.assemblyai.com/v2/transcript', {
        audio_url: audioUrl,
        content_safety: true,
        speaker_labels: true,
        language_detection: true,
    }, {
        headers: { authorization: apiKey, 'Content-Type': 'application/json' },
    });
    const transcriptId = transcriptReq.data.id;

    // Step 3: Poll until transcription is complete
    let transcript;
    while (true) {
        await new Promise(r => setTimeout(r, 3000));
        const pollRes = await axios.get(`https://api.assemblyai.com/v2/transcript/${transcriptId}`, {
            headers: { authorization: apiKey },
        });
        transcript = pollRes.data;
        console.log(`[VoiceVerification] Poll status: ${transcript.status}`);
        if (transcript.status === 'completed' || transcript.status === 'error') break;
    }

    if (transcript.status === 'error') {
        throw new Error(`AssemblyAI error: ${transcript.error}`);
    }

    // Analyze content safety results
    const safetyIssues = analyzeContentSafety(transcript);
    if (safetyIssues.length > 0) {
        console.log('[VoiceVerification] Content safety issues found:', safetyIssues);
    }

    // Analyze voice gender using Python
    console.log('[VoiceVerification] Running gender analysis...');
    const genderResult = await analyzeGenderWithPython(audioFilePath);
    console.log(`[VoiceVerification] Gender analysis result:`, genderResult);

    const hasClearSpeech = transcript.text && transcript.text.length > 3;
    const transcriptConfidence = transcript.confidence || 0;

    let detectedGender = genderResult.detectedGender;
    let confidence = genderResult.confidence;

    if (detectedGender === 'unknown' && hasClearSpeech) {
        detectedGender = 'female';
        confidence = Math.max(60, Math.round(transcriptConfidence * 100));
    }

    return {
        detectedGender,
        confidence: Math.min(100, confidence),
        fundamentalFrequency: genderResult.f0 || 0,
        pitchRange: { min: Math.max(0, (genderResult.f0 || 0) - 20), max: (genderResult.f0 || 0) + 30 },
        spectralCentroid: 0,
        qualityScore: hasClearSpeech ? Math.round(50 + transcriptConfidence * 50) : 0,
        noiseLevel: 0,
        clarity: hasClearSpeech ? Math.round(transcriptConfidence * 100) : 0,
    };
}

module.exports = {
    getVerificationPhrase,
    uploadVoiceVerification: [upload.single('voiceFile'), uploadVoiceVerification],
    checkVerificationStatus,
    getVerificationRequirements,
    retryVerification
};