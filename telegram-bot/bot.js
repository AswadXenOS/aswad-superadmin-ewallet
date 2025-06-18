const TelegramBot = require('node-telegram-bot-api');
const { BOT_TOKEN, SUPERADMIN_ID } = require('./config');
const axios = require('axios');

const bot = new TelegramBot(BOT_TOKEN, { polling: true });
let pendingTransfer = null;

bot.onText(/\/start/, (msg) => {
  if (msg.chat.id === SUPERADMIN_ID) {
    bot.sendMessage(msg.chat.id, "🛡️ SuperAdmin Bot Aktif. Guna /transfer <user> <jumlah>");
  }
});

bot.onText(/\/transfer (\w+) (\d+)/, (msg, match) => {
  if (msg.chat.id !== SUPERADMIN_ID) return;

  const targetUser = match[1];
  const amount = parseFloat(match[2]);

  pendingTransfer = { targetUser, amount };
  bot.sendMessage(msg.chat.id, `💸 Sahkan transfer RM${amount} kepada ${targetUser}? Balas: ✅YA`);
});

bot.onText(/✅YA/, async (msg) => {
  if (msg.chat.id !== SUPERADMIN_ID || !pendingTransfer) return;

  try {
    const res = await axios.post('http://localhost:3000/api/transfer', {
      to: pendingTransfer.targetUser,
      amount: pendingTransfer.amount
    });

    bot.sendMessage(msg.chat.id, `✅ Berjaya transfer RM${pendingTransfer.amount} kepada ${pendingTransfer.targetUser}`);
  } catch (e) {
    bot.sendMessage(msg.chat.id, "❌ Gagal transfer. " + (e.response?.data?.error || e.message));
  }

  pendingTransfer = null;
});
