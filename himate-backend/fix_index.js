const fs = require('fs');

const content = fs.readFileSync('/Users/yogesh/himate-backend/index.js', 'utf8');

// Find the match-notification block
const matchNotifStart = content.indexOf('socket.on("match-notification"');
if (matchNotifStart === -1) {
    console.log("Could not find match-notification");
    process.exit(1);
}
 
// Keep everything up to the match-notification block
let fixed = content.substring(0, matchNotifStart);

// Reconstruct the match-notification, disconnect, and initialization
fixed += `socket.on("match-notification", (data) => {
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

`;

// Append the rest of the file (Global error handler)
const globalErrorStart = content.indexOf('// Global error handler');
if (globalErrorStart === -1) {
    console.log("Could not find Global error handler");
    process.exit(1);
}

fixed += content.substring(globalErrorStart);

fs.writeFileSync('/Users/yogesh/himate-backend/index.js', fixed, 'utf8');
console.log("Fixed index.js");
