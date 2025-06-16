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


#!/bin/bash
set -e

PROJECT=aswad-superadmin-ewallet
mkdir -p $PROJECT && cd $PROJECT

echo "📁 [1/9] Cipta struktur folder..."
mkdir -p backend frontend cli telegram-bot

########################################
# 1. BACKEND SETUP
########################################
echo "🧠 [2/9] Setup backend..."
cat > backend/index.js <<EOF
const express = require('express');
const app = express();
app.use(express.json());

app.get('/', (req, res) => res.send('Backend Aktif'));
app.listen(3000, () => console.log('✅ Backend running on port 3000'));
EOF

cat > backend/package.json <<EOF
{
  "name": "backend",
  "main": "index.js",
  "dependencies": {
    "express": "^4.18.2"
  }
}
EOF

########################################
# 2. FRONTEND SETUP
########################################
echo "🌐 [3/9] Setup frontend..."
cat > frontend/index.html <<EOF
<!DOCTYPE html>
<html>
  <head><title>SuperAdmin UI</title></head>
  <body><h1>Selamat datang ke UI SuperAdmin</h1></body>
</html>
EOF

########################################
# 3. TELEGRAM BOT SETUP
########################################
echo "🤖 [4/9] Setup telegram-bot..."
cat > telegram-bot/bot.js <<EOF
console.log('Bot Telegram aktif (simulasi)');
EOF

cat > telegram-bot/package.json <<EOF
{
  "name": "telegram-bot",
  "main": "bot.js"
}
EOF

########################################
# 4. CLI SUPERADMIN
########################################
echo "💻 [5/9] Setup CLI..."
cat > cli/superadmin-cli.js <<EOF
console.log('CLI SuperAdmin Siap');
EOF

########################################
# 5. AUTOSETUP SH FILE
########################################
echo "🔧 [6/9] Setup autosetup.sh..."
cat > autosetup.sh <<'EOS'
#!/bin/bash
set -e

echo "📦 Install backend..."
cd backend && npm install && node index.js &
cd ..

echo "📦 Sedia frontend..."
echo "Buka frontend/index.html di browser"

cd telegram-bot && echo "▶ Mula bot telegram..." && node bot.js &
cd ..

echo "💻 CLI: node cli/superadmin-cli.js"
echo "✅ SEMUA SELESAI"
EOS
chmod +x autosetup.sh

########################################
# 6. AKHIRI
########################################
echo "🚀 [7/9] Siap! Anda boleh jalankan:"
echo "cd $PROJECT && bash autosetup.sh"
