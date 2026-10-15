// const multer = require('multer');
// const path = require('path');

// // Multer setup
// const storage = multer.diskStorage({
//   destination: (req, file, cb) => {
//     cb(null, 'uploads/');
//   },
//   filename: (req, file, cb) => {
//     cb(null, `${Date.now()}-${file.originalname}`);
//   },
// });

// const upload = multer({ storage });
// exports.uploadAudio = upload.single('audio');

// // Process voice test
// exports.processVoice = async (req, res) => {
//   try {
//     const audioFile = req.file;
//     if (!audioFile) return res.status(400).json({ message: 'No audio file uploaded' });

//     // Placeholder for actual gender detection logic
//     const isFemaleVoice = Math.random() > 0.5; // Mock logic: Replace with actual model/API

//     if (isFemaleVoice) {
//       res.status(200).json({ message: 'Voice recognized as female', status: 'Passed' });
//     } else {
//       res.status(200).json({ message: 'Voice not recognized as female', status: 'Failed' });
//     }
//   } catch (err) {
//     res.status(500).json({ message: 'Error processing voice', error: err.message });
//   }
// };























// const Audio = require('../models/audioModel');

// // Upload and process voice test
// exports.processVoice = async (req, res) => {
//   try {
//     const { audio } = req.body;
//     if (!audio) return res.status(400).json({ message: 'No audio data provided' });

//     // Save audio directly to MongoDB
//     const audioDoc = await Audio.create({
//       audioData: Buffer.from(audio, 'base64'),
//       contentType: 'audio/mpeg',
//     });

//     // Placeholder for actual gender detection logic
//     const isFemaleVoice = Math.random() > 0.5; // Mock logic: Replace with actual model/API

//     if (isFemaleVoice) {
//       res.status(200).json({ message: 'Voice recognized as female', status: 'Passed', audioId: audioDoc._id });
//     } else {
//       res.status(200).json({ message: 'Voice not recognized as female', status: 'Failed', audioId: audioDoc._id });
//     }
//   } catch (err) {
//     res.status(500).json({ message: 'Error processing voice', error: err.message });
//   }
// };

























// const Audio = require('../models/audioModel');
// const multer = require('multer');

// // Multer setup for audio uploads
// const storage = multer.memoryStorage();
// const upload = multer({ storage });
// exports.uploadAudio = upload.single('audio');

// // Process voice recognition
// exports.processVoice = async (req, res) => {
//   try {
//     const { buffer, mimetype, originalname } = req.file;
//     if (!req.file) return res.status(400).json({ message: 'No audio file provided' });

//     // Save audio to MongoDB
//     const audioDoc = await Audio.create({
//       filename: originalname,
//       contentType: mimetype,
//       audioData: buffer,
//     });

//     // Placeholder for actual voice gender detection logic
//     const isFemaleVoice = Math.random() > 0.5; // Replace this mock logic with real implementation

//     if (isFemaleVoice) {
//       res.status(200).json({ message: 'Voice recognized as female', status: 'Passed', audioId: audioDoc._id });
//     } else {
//       res.status(200).json({ message: 'Voice not recognized as female', status: 'Failed', audioId: audioDoc._id });
//     }
//   } catch (err) {
//     res.status(500).json({ message: 'Error processing voice', error: err.message });
//   }
// };



// const multer = require('multer');
// const Audio = require('../models/audioModel');

// // Multer setup for audio uploads
// const storage = multer.memoryStorage();
// const upload = multer({ storage });

// // Middleware for handling file uploads
// exports.uploadAudio = upload.single('audio');

// // Process voice recognition
// exports.processVoice = async (req, res) => {
//   try {
//     if (!req.file) {
//       return res.status(400).json({ message: 'No audio file provided' });
//     }

//     const { buffer, mimetype, originalname } = req.file;

//     // Save audio to MongoDB
//     const audioDoc = await Audio.create({
//       filename: originalname,
//       contentType: mimetype,
//       audioData: buffer,
//     });

//     // Placeholder for voice recognition
//     const isFemaleVoice = Math.random() > 0.5; // Replace with real implementation

//     res.status(200).json({
//       message: isFemaleVoice ? 'Voice recognized as female' : 'Voice not recognized as female',
//       status: isFemaleVoice ? 'Passed' : 'Failed',
//       audioId: audioDoc._id,
//     });
//   } catch (err) {
//     res.status(500).json({ message: 'Error processing voice', error: err.message });
//   }
// };








const axios = require('axios');
const Audio = require('../models/audioModel');

// Multer setup for audio uploads
const multer = require('multer');
const storage = multer.memoryStorage();
const upload = multer({ storage });
exports.uploadAudio = upload.single('audio');

// Process voice recognition
exports.processVoice = async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ message: 'No audio file provided' });
    }

    const { buffer, mimetype, originalname } = req.file;

    // Save audio to MongoDB
    const audioDoc = await Audio.create({
      filename: originalname,
      contentType: mimetype,
      audioData: buffer,
    });

    // Step 1: Upload the audio to AssemblyAI
    const apiKey = process.env.ASSEMBLYAI_API_KEY;
    if (!apiKey) throw new Error('ASSEMBLYAI_API_KEY not set in environment');
    const uploadResponse = await axios.post('https://api.assemblyai.com/v2/upload', buffer, {
      headers: {
        authorization: apiKey,
        'Content-Type': mimetype,
      },
    });

    // Step 2: Send the uploaded audio for transcription with content_safety
    const audioUrl = uploadResponse.data.upload_url;
    const transcribeRes = await axios.post(
      'https://api.assemblyai.com/v2/transcript',
      { audio_url: audioUrl, speaker_labels: true },
      { headers: { authorization: apiKey } }
    );

    // Poll for completion
    let transcript;
    while (true) {
      await new Promise(r => setTimeout(r, 2000));
      const pollRes = await axios.get(`https://api.assemblyai.com/v2/transcript/${transcribeRes.data.id}`, {
        headers: { authorization: apiKey },
      });
      transcript = pollRes.data;
      if (transcript.status === 'completed' || transcript.status === 'error') break;
    }

    if (transcript.status === 'error') {
      throw new Error(`AssemblyAI error: ${transcript.error}`);
    }

    // Step 3: Check for speech content
    const isFemaleVoice = transcript.text && transcript.text.length > 0;

    res.status(200).json({
      message: isFemaleVoice ? 'Voice recognized as female' : 'Voice not recognized as female',
      status: isFemaleVoice ? 'Passed' : 'Failed',
      audioId: audioDoc._id,
      analysis: analysisResponse.data, // Include full analysis for debugging
    });
  } catch (err) {
    res.status(500).json({ message: 'Error processing voice', error: err.message });
  }
};
