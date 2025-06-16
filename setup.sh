#!/data/data/com.termux/files/usr/bin/bash
set -e

echo "==========================================="
echo "🚀 [SUPERADMIN E-WALLET] FULL AUTO SETUP"
echo "==========================================="

echo "[1/7] 📦 Installing dependencies..."
pkg update -y && pkg install -y git nodejs curl nano

echo "[2/7] 📁 Cloning project..."
cd ~
rm -rf aswad-superadmin-ewallet
git clone https://github.com/AswadXenOS/aswad-superadmin-ewallet.git
cd aswad-superadmin-ewallet

echo "[3/7] 🧠 Creating necessary files..."
mkdir -p backend/db
cat > backend/db/index.js <<EOF
const sqlite = require('sqlite');
const sqlite3 = require('sqlite3');
module.exports = sqlite.open({ filename: './data.db', driver: sqlite3.Database });
EOF

cat > backend/server.js <<EOF
const express = require('express');
const cors = require('cors');
const QRCode = require('qrcode');
const initDB = require('./db');

(async () => {
  const db = await initDB();
  const app = express();
  app.use(cors());
  app.use(express.json());

  app.get('/api/users', async (_, res) => {
    const users = await db.all('SELECT * FROM users');
    res.json(users);
  });

  app.get('/api/logs', async (_, res) => {
    const logs = await db.all('SELECT * FROM logs ORDER BY timestamp DESC');
    res.json(logs);
  });

  app.post('/api/transfer', async (req, res) => {
    const { from, to, amount } = req.body;
    const userFrom = await db.get('SELECT * FROM users WHERE username = ?', [from]);
    const userTo = await db.get('SELECT * FROM users WHERE username = ?', [to]);
    if (!userFrom || !userTo || userFrom.balance < amount) {
      await db.run('INSERT INTO logs (action) VALUES (?)', ['❌ Transfer failed']);
      return res.status(400).json({ error: 'Transfer failed' });
    }
    await db.run('UPDATE users SET balance = balance - ? WHERE username = ?', [amount, from]);
    await db.run('UPDATE users SET balance = balance + ? WHERE username = ?', [amount, to]);
    await db.run('INSERT INTO logs (action) VALUES (?)', ['💸 Transfer success']);
    res.json({ success: true });
  });

  app.get('/api/qr/:username', async (req, res) => {
    const qrData = await QRCode.toDataURL(JSON.stringify({ user: req.params.username }));
    res.json({ qr: qrData });
  });

  app.listen(3000, () => console.log("✅ Backend running on http://localhost:3000"));
})();
EOF

cat > backend/package.json <<EOF
{
  "name": "backend",
  "main": "server.js",
  "dependencies": {
    "express": "^4.18.2",
    "cors": "^2.8.5",
    "sqlite": "^4.0.23",
    "sqlite3": "^5.1.2",
    "qrcode": "^1.5.1"
  }
}
EOF

echo "[4/7] 💻 Writing frontend files..."
mkdir -p frontend/src
cat > frontend/index.html <<EOF
<!DOCTYPE html>
<html>
  <head><title>SuperAdmin</title></head>
  <body><div id="root"></div><script type="module" src="/src/main.jsx"></script></body>
</html>
EOF

cat > frontend/src/main.jsx <<EOF
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
ReactDOM.createRoot(document.getElementById('root')).render(<App />);
EOF

cat > frontend/src/App.jsx <<EOF
import React, { useEffect, useState } from 'react';
export default function App() {
  const [users, setUsers] = useState([]);
  useEffect(() => {
    fetch('/api/users').then(r => r.json()).then(setUsers);
  }, []);
  return (
    <div>
      <h1>Dashboard</h1>
      <ul>{users.map(u => <li key={u.id}>{u.username} - RM{u.balance}</li>)}</ul>
    </div>
  );
}
EOF

cat > frontend/package.json <<EOF
{
  "name": "frontend",
  "scripts": { "dev": "vite --port 5173" },
  "dependencies": { "react": "^18.2.0", "react-dom": "^18.2.0" },
  "devDependencies": { "vite": "^4.0.0", "@vitejs/plugin-react": "^3.0.0" }
}
EOF

cat > frontend/vite.config.js <<EOF
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
export default defineConfig({
  plugins: [react()],
  server: {
    proxy: { '/api': 'http://localhost:3000' }
  }
});
EOF

echo "[5/7] 🧠 Creating CLI and bot files..."
mkdir -p cli telegram-bot
echo 'console.log("🧠 SuperAdmin CLI Ready")' > cli/superadmin-cli.js
echo '{}' > cli/package.json
echo 'console.log("🤖 Telegram Bot Online")' > telegram-bot/bot.js
echo '{}' > telegram-bot/package.json

echo "[6/7] 🧩 Installing dependencies..."
npm install --prefix backend
npm install --prefix frontend
npm install --prefix cli
npm install --prefix telegram-bot

echo "[7/7] 🚀 Launching backend & frontend..."
nohup node backend/server.js > backend.log 2>&1 &
cd frontend && nohup npm run dev > ../frontend.log 2>&1 &

echo "✅ SETUP COMPLETE!"
echo "🌐 Frontend: http://localhost:5173"
echo "🛠️  Backend: http://localhost:3000"
echo "💬 CLI: node cli/superadmin-cli.js"
echo "🤖 Bot: node telegram-bot/bot.js"
