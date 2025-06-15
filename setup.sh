#!/usr/bin/env bash set -e

🌐 Update & Install Basic Packages

echo "[1/5] Installing system dependencies..." pkg install -y nodejs git curl || apt install -y nodejs npm git curl

🧼 Cleanup old

rm -rf aswad-superadmin-ewallet

🧪 Clone Fresh Copy

echo "[2/5] Cloning latest source code..." git clone https://github.com/AswadXenOS/aswad-superadmin-ewallet.git cd aswad-superadmin-ewallet

📦 Install Dependencies

echo "[3/5] Installing backend dependencies..." cd backend && npm install && cd .. echo "[3/5] Installing frontend dependencies..." cd frontend && npm install && cd .. echo "[3/5] Installing telegram-bot dependencies..." cd telegram-bot && npm install && cd .. echo "[3/5] Installing cli dependencies..." cd cli && npm install && cd ..

🧠 Init DB & Create Default SuperAdmin

node -e "require('./backend/db').initDB().then(async()=>{const db=require('./backend/db').getDB();const b=require('bcryptjs');const pw=await b.hash('admin123',10);await db.run('INSERT OR IGNORE INTO users (username,password,balance,role) VALUES (?,?,?,?)',['superadmin',pw,0,'superadmin']);console.log('✅ SuperAdmin: superadmin / admin123');process.exit(0)})"

🚀 Run All in Parallel (backend, frontend, bot)

echo "[5/5] Starting all services..." npx concurrently "cd backend && node index.js" "cd frontend && npm run dev -- --host" "cd telegram-bot && node bot.js"


