const mongoose = require('mongoose');

const CallLogSchema = new mongoose.Schema({
  caller: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  callee: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  duration: {
    type: String,
    default: '0.00 minutes'
  },
  callType: {
    type: String,
    enum: ['audio', 'video'],
    default: 'audio'
  }
}, {
  timestamps: true
});

module.exports = mongoose.model('CallLog', CallLogSchema);
