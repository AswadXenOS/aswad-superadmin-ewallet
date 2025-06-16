#!/data/data/com.termux/files/usr/bin/bash

echo "==========================================="
echo "🚀 [SUPERADMIN E-WALLET] AUTO SETUP (TERMUX)"
echo "==========================================="

echo "[1/7] 📦 Installing Termux dependencies..."
pkg update -y && pkg install -y git nodejs curl nano

echo "[2/7] 📁 Cloning latest repo from GitHub..."
cd ~
rm -rf aswad-superadmin-ewallet
git clone https://github.com/AswadXenOS/aswad-superadmin-ewallet.git
cd aswad-superadmin-ewallet

echo "[3/7] 🧠 Creating required backend files..."
mkdir -p backend/data
touch backend/data/db.json
touch backend/data/audit.log

echo "[4/7] ⚙️ Installing backend dependencies (pure JS)..."
cd backend
rm -rf node_modules package-lock.json
npm install express dotenv sqlite bcryptjs

echo "[5/7] 💻 Installing frontend dependencies..."
cd ../frontend
rm -rf node_modules package-lock.json
npm install

echo "[6/7] 🤖 Installing GPT CLI bot dependencies..."
cd ../gpt-cli
rm -rf node_modules package-lock.json
npm install

echo "[7/7] 🚀 Pushing updates to GitHub..."
cd ..
git add .
git commit -m "✅ Add auto-setup-termux.sh script for full Termux setup"
git push -u origin main

echo "✅ SETUP COMPLETE 100%! You can now run the system."
