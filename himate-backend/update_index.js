const fs = require('fs');

const path = '/Users/yogesh/himate-backend/index.js';
let content = fs.readFileSync(path, 'utf8');

// 1. Add import
if (!content.includes('const activeUserStore = require("./models/activeUserStore");')) {
    content = content.replace(
        'const { initializeSignaling } = require("./controllers/signalingController");',
        'const { initializeSignaling } = require("./controllers/signalingController");\nconst activeUserStore = require("./models/activeUserStore");'
    );
}

// 2. Remove const activeUsers = new Map();
content = content.replace('const activeUsers = new Map();', '// Using activeUserStore instead of local Map');

// 3. Update authenticate
content = content.replace(
    /activeUsers\.set\(userId, {[\s\S]*?}\);/g,
    `activeUserStore.addUser(socket.id, userId, {
            username,
            isOnline: true,
            lastSeen: new Date()
        });`
);

// 4. Update get
content = content.replace(/activeUsers\.get\((.*?)\)/g, 'activeUserStore.findUser($1)');

// 5. Update send-message
content = content.replace(
    /const receiverSocket = Array\.from\(activeUsers\.entries\(\)\)\s*\.find\(\(\[userId, userData\]\) => userId === receiverId\);/g,
    `const receiverSocket = activeUserStore.findUser(receiverId);`
);

// Update receive-message io.to() which used receiverSocket[1].socketId
content = content.replace(
    /if \(receiverSocket\) {\s*io\.to\(receiverSocket\[1\]\.socketId\)/g,
    `if (receiverSocket) {
            io.to(receiverSocket.socketId)`
);

// 6. Update typing indicator
content = content.replace(
    /if \(receiverSocket\) {\s*io\.to\(receiverSocket\[1\]\.socketId\)/g, // already replaced above but maybe this catches the other one
    `if (receiverSocket) {
            io.to(receiverSocket.socketId)`
);

// 7. Update match-notification
content = content.replace(
    /const userSocket = Array\.from\(activeUsers\.entries\(\)\)\s*\.find\(\(\[id, userData\]\) => id === userId\);/g,
    `const userSocket = activeUserStore.findUser(userId);`
);
content = content.replace(
    /if \(userSocket\) {\s*io\.to\(userSocket\[1\]\.socketId\)/g,
    `if (userSocket) {
            io.to(userSocket.socketId)`
);

// 8. Update disconnect
content = content.replace(
    /if \(socket\.userId\) {\s*const userData = activeUserStore\.findUser\(socket\.userId\);\s*if \(userData\) {\s*userData\.isOnline = false;\s*userData\.lastSeen = new Date\(\);\s*activeUserStore\.addUser\(socket\.userId, userData\);\s*}\s*}/g,
    `activeUserStore.removeUser(socket.id);`
);
// Above regex might fail because it was activeUsers.get. Let's do it manually for disconnect block:
content = content.replace(
    /if \(socket\.userId\) {\s*const userData = activeUsers\.get\(socket\.userId\);\s*if \(userData\) {\s*userData\.isOnline = false;\s*userData\.lastSeen = new Date\(\);\s*activeUsers\.set\(socket\.userId, userData\);\s*}\s*}/g,
    `activeUserStore.removeUser(socket.id);`
);
content = content.replace(
    /if \(socket\.userId\) {\s*const userData = activeUserStore\.findUser\(socket\.userId\);\s*if \(userData\) {\s*userData\.isOnline = false;\s*userData\.lastSeen = new Date\(\);\s*activeUserStore\.addUser\(socket\.id, socket\.userId, userData\);\s*}\s*}/g,
    `activeUserStore.removeUser(socket.id);`
);

fs.writeFileSync(path, content, 'utf8');
console.log("Updated index.js");
