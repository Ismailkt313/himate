import sys

def fix_file():
    with open('/Users/yogesh/himate-backend/controllers/voiceVerificationController.js', 'r') as f:
        lines = f.readlines()
    
    # We know the bug occurred around line 349 where the res.status(500) was deleted
    # Let's find the exact line where `console.error('Retry verification error:', error);` is
    
    idx = 0
    for i, line in enumerate(lines):
        if "console.error('Retry verification error:', error);" in line:
            idx = i
            break
            
    if idx == 0:
        print("Could not find the hook line.")
        return
        
    # The file currently has from idx+1:
    #         res.status(500).json({
    #             success: false,
    #     const safetyResults = transcript.content_safety_labels?.results || [];
    
    # We want to replace everything from idx to the function analyzeContentSafety
    
    end_idx = 0
    for i in range(idx, len(lines)):
        if "const safetyResults = transcript.content_safety_labels?.results || [];" in lines[i]:
            end_idx = i
            break
            
    if end_idx == 0:
        print("Could not find end hook line.")
        return
        
    new_content = """        console.error('Retry verification error:', error);
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
"""
    lines[idx:end_idx] = [new_content]
    
    with open('/Users/yogesh/himate-backend/controllers/voiceVerificationController.js', 'w') as f:
        f.writelines(lines)
    print("Fixed file.")

fix_file()
