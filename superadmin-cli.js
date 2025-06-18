const fs = require('fs');
const db = JSON.parse(fs.readFileSync('./db.json'));
console.log("SuperAdmin CLI");
console.log("Users:");
db.users.forEach(u => {
  console.log(`👤 ${u.username} - 💵 ${u.wallet}`);
});
