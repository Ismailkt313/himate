require("dotenv").config();
const express = require("express");
const http = require("http");
const cors = require("cors");
const helmet = require("helmet");
const rateLimit = require("express-rate-limit");
const { Server } = require("socket.io");
const { initializeSignaling } = require("./controllers/signalingController");
const activeUserStore = require("./models/activeUserStore");
const connectDB = require("./config/db");
const fs = require("fs");

const authRoutes = require("./routes/authRoutes");
const languageRoutes = require("./routes/languageRoutes");
const profileRoutes = require("./routes/profileRoutes");
const voiceRoutes = require("./routes/voiceRoutes");
const kycRoutes = require("./routes/kycRoutes");
const MessageRoutes = require("./routes/MessageRoutes");
const matchRoutes = require("./routes/matchRoutes");
const paymentRoutes = require("./routes/paymentRoutes");
const gameRoutes = require("./routes/gameRoutes");
const groupCallRoutes = require("./routes/groupCallRoutes");
const groupRoutes = require("./routes/groupRoutes");
const voiceVerificationRoutes = require("./routes/voiceVerificationRoutes");
const avatarRoutes = require("./routes/avatarRoutes");
const walletRoutes = require("./routes/walletRoutes");


// Express App Setup
const app = express();
const server = http.createServer(app);
connectDB();

// Ensure required upload directories exist
['uploads', 'uploads/kyc-documents', 'uploads/voice-verification', 'uploads/profile-photos'].forEach(dir => {
    if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, { recursive: true });
        console.log(`📁 Created directory: ${dir}`);
    }
});

// Security middleware
app.use(helmet({
    crossOriginEmbedderPolicy: false,
    contentSecurityPolicy: {
        directives: {
            defaultSrc: ["'self'"],
            styleSrc: ["'self'", "'unsafe-inline'"],
            imgSrc: ["'self'", "data:", "https:"],
            scriptSrc: ["'self'"]
        }
    },
    hsts: {
        maxAge: 31536000,
        includeSubDomains: true,
        preload: true
    },
    noSniff: true,
    xssFilter: true,
    hidePoweredBy: true
}));

// XSS Protection
app.use((req, res, next) => {
    res.setHeader('X-XSS-Protection', '1; mode=block');
    next();
});

// Rate limiting
const limiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 minutes
    max: 100, // limit each IP to 100 requests per windowMs
    message: {
        error: "Too many requests from this IP, please try again later."
    },
    standardHeaders: true,
    legacyHeaders: false
});
app.use('/api/', limiter);

// CORS — allow all origins including mobile apps (no Origin header)
app.use(cors({
    origin: (origin, callback) => {
        // Allow requests with no origin (mobile apps, curl, etc)
        if (!origin) return callback(null, true);
        // In production, restrict to your frontend domain
        const allowedOrigins = process.env.FRONTEND_URL 
            ? [process.env.FRONTEND_URL, 'http://localhost:3000', "https://himate-nteg.onrender.com"]
            : ['http://localhost:3000',"https://himate-nteg.onrender.com"];
        if (allowedOrigins.includes(origin) || process.env.NODE_ENV === 'development') {
            return callback(null, true);
        }
        callback(new Error('Not allowed by CORS'));
    },
    methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization'],
    credentials: true,
    maxAge: 86400
}));

// Stricter rate limiting for auth endpoints (relaxed in dev)
const authLimiter = rateLimit({
    windowMs: 15 * 60 * 1000,
    max: process.env.NODE_ENV === 'production' ? 10 : 100,
    message: {
        error: "Too many authentication attempts, please try again later."
    }
});

app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// Serve uploaded files
app.use('/uploads', express.static('uploads'));

// Routes
app.use("/api/auth", authLimiter, authRoutes);
app.use("/api/language", languageRoutes);
app.use("/api/profile", profileRoutes);
app.use("/api/voice-test", voiceRoutes);
app.use("/api/kyc", kycRoutes);
app.use("/api/messages", MessageRoutes);
app.use("/api/matches", matchRoutes);
app.use("/api/payment", paymentRoutes);
app.use("/api/games", gameRoutes);
app.use("/api/group-calls", groupCallRoutes);
app.use("/api/groups", groupRoutes);
app.use("/api/voice-verification", voiceVerificationRoutes);
app.use("/api/avatars", avatarRoutes);
app.use("/api/wallet", walletRoutes);

// Health check endpoint
app.get("/", (req, res) => {
    res.json({
        success: true,
        message: "HiMate Dating App Backend + Signaling Server is running",
        version: "1.0.0",
        timestamp: new Date().toISOString()
    });
});

// API status endpoint
app.get("/api/status", (req, res) => {
    res.json({
        success: true,
        services: {
            database: "connected",
            socketio: "active",
            webrtc: "active"
        },
        uptime: process.uptime(),
        timestamp: new Date().toISOString()
    });
});

// Socket.IO Setup with enhanced configuration
const io = new Server(server, {
    cors: {
        origin: process.env.FRONTEND_URL || "*",
        methods: ["GET", "POST"],
        credentials: true
    },
    pingTimeout: 60000,
    pingInterval: 25000
});

// Store active users
// Using activeUserStore instead of local Map

// Socket.IO Events
io.on("connection", (socket) => {
    console.log("User connected:", socket.id);

    // User authentication for socket
    socket.on("authenticate", (data) => {
        const { userId, username } = data;
        activeUserStore.addUser(socket.id, userId, {
            username,
            isOnline: true,
            lastSeen: new Date()
        });
        socket.userId = userId;
        console.log(`User ${username} (${userId}) authenticated`);
    });

    // Chat functionality
    socket.on("join-room", (roomId) => {
        socket.join(roomId);
        console.log(`Socket ${socket.id} joined room ${roomId}`);
    });

    // Group chat functionality
    socket.on("join-group", async (data) => {
        const { groupId, userId } = data;
        socket.join(`group_${groupId}`);
        socket.groupId = groupId;
        socket.userId = userId;
        
        // Notify other group members
        socket.to(`group_${groupId}`).emit("user-joined-group", {
            userId,
            username: activeUserStore.findUser(userId)?.username || 'User',
            timestamp: new Date()
        });
        
        console.log(`User ${userId} joined group ${groupId}`);
    });

    socket.on("leave-group", (data) => {
        const { groupId, userId } = data;
        socket.leave(`group_${groupId}`);
        
        // Notify other group members
        socket.to(`group_${groupId}`).emit("user-left-group", {
            userId,
            timestamp: new Date()
        });
        
        console.log(`User ${userId} left group ${groupId}`);
    });

    socket.on("group-message", async (data) => {
        const { groupId, message, messageType = 'text', replyTo, mentionedUsers } = data;
        
        // Broadcast message to all group members
        io.to(`group_${groupId}`).emit("group-message-received", {
            messageId: Date.now(), // In real app, this would be the database ID
            groupId,
            sender: {
                id: socket.userId,
                username: activeUserStore.findUser(socket.userId)?.username || 'User'
            },
            message,
            messageType,
            replyTo,
            mentionedUsers,
            timestamp: new Date()
        });
        
        // Send push notifications to mentioned users (if offline)
        if (mentionedUsers && mentionedUsers.length > 0) {
            mentionedUsers.forEach(userId => {
                const user = activeUserStore.findUser(userId);
                if (!user || !user.isOnline) {
                    // Here you would integrate with push notification service
                    console.log(`Send push notification to user ${userId} for group mention`);
                }
            });
        }
    });

    socket.on("group-typing", (data) => {
        const { groupId, isTyping } = data;
        socket.to(`group_${groupId}`).emit("group-user-typing", {
            userId: socket.userId,
            username: activeUserStore.findUser(socket.userId)?.username || 'User',
            isTyping,
            timestamp: new Date()
        });
    });

    socket.on("group-message-reaction", (data) => {
        const { groupId, messageId, emoji, action } = data; // action: 'add' or 'remove'
        
        io.to(`group_${groupId}`).emit("group-message-reaction-updated", {
            messageId,
            userId: socket.userId,
            emoji,
            action,
            timestamp: new Date()
        });
    });

    socket.on("group-game-invite", (data) => {
        const { groupId, gameType, maxPlayers = 2 } = data;
        
        io.to(`group_${groupId}`).emit("group-game-invite-received", {
            gameId: Date.now(),
            groupId,
            gameType,
            maxPlayers,
            creator: {
                id: socket.userId,
                username: activeUserStore.findUser(socket.userId)?.username || 'User'
            },
            timestamp: new Date()
        });
    });

    socket.on("group-call-invite", (data) => {
        const { groupId, callType = 'audio' } = data; // 'audio' or 'video'
        
        io.to(`group_${groupId}`).emit("group-call-invite-received", {
            callId: Date.now(),
            groupId,
            callType,
            creator: {
                id: socket.userId,
                username: activeUserStore.findUser(socket.userId)?.username || 'User'
            },
            timestamp: new Date()
        });
    });

    // Direct message functionality
    socket.on("send-message", (data) => {
        const { receiverId, message, messageType = 'text' } = data;
        const receiverSocket = activeUserStore.findUser(receiverId);
        
        if (receiverSocket) {
            io.to(receiverSocket.socketId).emit("receive-message", {
                senderId: socket.userId,
                message,
                messageType,
                timestamp: new Date()
            });
        }
    });

    // Typing indicators
    socket.on("typing", (data) => {
        const { receiverId, isTyping } = data;
        const receiverSocket = activeUserStore.findUser(receiverId);
        
        if (receiverSocket) {
            io.to(receiverSocket.socketId).emit("user-typing", {
                senderId: socket.userId,
                isTyping
            });
        }
    });

    // Game events
    socket.on("join-game", (roomId) => {
        socket.join(`game-${roomId}`);
        socket.to(`game-${roomId}`).emit("player-joined", {
            playerId: socket.userId,
            socketId: socket.id
        });
    });

    socket.on("game-move", (data) => {
        const { roomId, move, gameState } = data;
        socket.to(`game-${roomId}`).emit("game-move", {
            playerId: socket.userId,
            move,
            gameState
        });
    });

    socket.on("game-ended", (data) => {
        const { roomId, winner, gameState } = data;
        io.to(`game-${roomId}`).emit("game-ended", {
            winner,
            gameState
        });
    });

    // Match notifications
    socket.on("match-notification", (data) => {
        const { userId, matchData } = data;
        const userSocket = activeUserStore.findUser(userId);
        
        if (userSocket) {
            io.to(userSocket.socketId).emit("new-match", matchData);
        }
    });

    // User disconnection
    socket.on("disconnect", () => {
        console.log("User disconnected:", socket.id);
        
        if (socket.userId) {
            activeUserStore.removeUser(socket.id);
        }
    });

    // Signaling functionality for WebRTC
    initializeSignaling(io, socket);
});

// Global error handler
app.use((err, req, res, next) => {
    console.error('Global error:', err);
    
    if (err.type === 'entity.too.large') {
        return res.status(413).json({
            success: false,
            message: 'File too large'
        });
    }
    
    res.status(500).json({
        success: false,
        message: 'Internal server error',
        ...(process.env.NODE_ENV === 'development' && { error: err.message })
    });
});

// Handle 404 routes
app.use('*', (req, res) => {
    res.status(404).json({
        success: false,
        message: 'Route not found'
    });
});

// Start Server
const PORT = process.env.PORT || 5001;
server.listen(PORT, () => {
    console.log(`🚀 Server is running on port ${PORT}`);
    console.log(`📱 Dating App Backend + Signaling Server started successfully`);
    console.log(`🌐 Environment: ${process.env.NODE_ENV || 'development'}`);
    console.log(`⏰ Started at: ${new Date().toISOString()}`);
});
