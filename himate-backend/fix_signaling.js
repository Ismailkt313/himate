const fs = require('fs');

const path = '/Users/yogesh/himate-backend/controllers/signalingController.js';
let content = fs.readFileSync(path, 'utf8');

// 1. Remove activeUserStore.addUser from initializeSignaling
content = content.replace(
    /const currentUserId = socket\.id;\s*activeUserStore\.addUser\(socket\.id, currentUserId\);/,
    `// currentUserId is determined dynamically per event`
);

// 2. Replace all instances of `currentUserId` with `socket.userId`
content = content.replace(/currentUserId/g, 'socket.userId');

fs.writeFileSync(path, content, 'utf8');
console.log("Fixed signalingController.js");
