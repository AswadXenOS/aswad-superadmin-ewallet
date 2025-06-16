const TelegramBot = require('node-telegram-bot-api');
require('dotenv').config({ path: '../.env' });

const bot = new TelegramBot(process.env.TELEGRAM_BOT_TOKEN, { polling: true });

bot.on('message', async (msg) => {
  if (msg.text === '/start') {
    bot.sendMessage(msg.chat.id, "🤖 SuperAdmin eWallet Bot aktif.");
  }
});
