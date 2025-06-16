#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "🔧 [1/9] Update Termux packages..."
pkg update -y && pkg upgrade -y
pkg install -y git nodejs curl

echo "📦 [2/9] Cloning eWallet system..."
rm -rf aswad-superadmin-ewallet-temp
git clone https://github.com/AswadXenOS/aswad-superadmin-ewallet.git aswad-superadmin-ewallet-temp
cd aswad-superadmin-ewallet-temp

echo "🛠 [3/9] Installing backend dependencies..."
cd backend
npm install
cd ..

echo "🛠 [4/9] Installing frontend dependencies..."
cd frontend
npm install
cd ..

echo "🤖 [5/9] Installing bot dependencies..."
cd telegram-bot
npm install
cd ..

echo "💻 [6/9] Installing CLI dependencies..."
cd cli
npm install
cd ..

echo "🚀 [7/9] Starting backend server..."
cd backend
nohup node index.js > backend.log 2>&1 &
cd ..

echo "📱 [8/9] Starting frontend..."
cd frontend
nohup npm run dev > frontend.log 2>&1 &
cd ..

echo "🤖 [9/9] Starting Telegram Bot..."
cd telegram-bot
nohup node bot.js > bot.log 2>&1 &
cd ..

echo "✅ SIAP! Sistem SuperAdmin eWallet sudah aktif sepenuhnya."
