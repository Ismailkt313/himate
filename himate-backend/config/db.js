const mongoose = require('mongoose');

const connectDB = async () => {
  try {
    const dbUri = process.env.MONGODB_URI || "mongodb+srv://sajidalhijas:sKY2WXFmVKov5Mi1@datingapp.6rixc.mongodb.net/?retryWrites=true&w=majority&appName=DatingApp";
    await mongoose.connect(dbUri);
    console.log('MongoDB Connected...');
  } catch (err) {
    console.error('MongoDB connection error:', err.message);
  }
};

module.exports = connectDB; 
