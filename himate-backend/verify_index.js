const fs = require('fs');
const content = fs.readFileSync('/Users/yogesh/himate-backend/index.js', 'utf8');

const realDisconnect = content.lastIndexOf('socket.on("disconnect"');
console.log(content.substring(realDisconnect, realDisconnect + 500));

