const TelegramBot = require('node-telegram-bot-api');
const fs = require('fs');
const { token, adminId } = require('./config');
const bot = new TelegramBot(token, { polling: true });

bot.onText(/\/start/, (msg) => {
  if (msg.from.id.toString() !== adminId) return;
  bot.sendMessage(msg.chat.id, "Welcome SuperAdmin 👑. Gunakan /wallet, /transfer");
});

bot.onText(/\/wallet/, (msg) => {
  const db = JSON.parse(fs.readFileSync('../db.json'));
  const user = db.users.find(u => u.username === 'superadmin');
  bot.sendMessage(msg.chat.id, `💼 Wallet Balance: RM ${user.wallet}`);
});
