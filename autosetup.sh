#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "🔧 [1/9] Kemas kini Termux..."
pkg update -y && pkg upgrade -y
pkg install -y git nodejs curl

echo "📦 [2/9] Clone repo penuh..."
rm -rf aswad-superadmin-ewallet-temp
git clone https://github.com/AswadXenOS/aswad-superadmin-ewallet.git aswad-superadmin-ewallet-temp
cd aswad-superadmin-ewallet-temp

echo "📁 [3/9] Setup backend..."
cd backend && npm install && cd ..

echo "💻 [4/9] Setup frontend..."
cd frontend && npm install && cd ..

echo "🤖 [5/9] Setup telegram bot..."
cd telegram-bot && npm install && cd ..

echo "🧠 [6/9] Setup CLI..."
cd cli && npm install && cd ..

echo "🚀 [7/9] Mula backend..."
cd backend && nohup node index.js > backend.log 2>&1 & cd ..

echo "🌐 [8/9] Mula frontend..."
cd frontend && nohup npm run dev > frontend.log 2>&1 & cd ..

echo "📡 [9/9] Mula Telegram bot..."
cd telegram-bot && nohup node bot.js > bot.log 2>&1 & cd ..

echo "✅ SELESAI: Semua sistem telah diaktifkan!"
