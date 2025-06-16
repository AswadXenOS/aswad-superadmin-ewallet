#!/data/data/com.termux/files/usr/bin/bash

clear echo "🚀 Memulakan Full Auto-Setup: SuperAdmin eWallet"

1. Update Termux & Pasang keperluan

pkg update -y && pkg upgrade -y pkg install -y git nodejs wget curl openssh

2. Clone Repo

cd ~ rm -rf aswad-superadmin-ewallet git clone https://github.com/AswadXenOS/aswad-superadmin-ewallet.git cd aswad-superadmin-ewallet

3. Buat fail .env untuk backend

cat > backend/.env <<EOF PORT=3000 JWT_SECRET=superadminsecret EOF

4. Setup Telegram Bot ENV

cat > telegram-bot/.env <<EOF BOT_TOKEN=7731637512:AAG6MnAuHWkSQjvIQ3XQpKuS_k5fy8vAgt8 CHAT_ID=7970381824 EOF

5. Setup GPT CLI ENV

cat > gpt-cli/.env <<EOF OPENAI_API_KEY=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 EOF

6. Pasang dependencies backend, frontend, bot

cd backend && npm install && cd .. cd frontend && npm install && cd .. cd telegram-bot && npm install && cd .. cd gpt-cli && npm install && cd ..

7. Auto register Webhook (optional logic can be enhanced)

echo "Webhook registered (dummy placeholder)"

8. Autostart script (backend + bot + frontend)

cat > start-all.sh <<EOF #!/data/data/com.termux/files/usr/bin/bash cd ~/aswad-superadmin-ewallet/backend && nohup node index.js & cd ~/aswad-superadmin-ewallet/telegram-bot && nohup node bot.js & cd ~/aswad-superadmin-ewallet/frontend && nohup npm run dev & echo "✅ Semua servis dimulakan." EOF chmod +x start-all.sh

9. Auto-start crontab semasa Termux boot

mkdir -p ~/.termux/boot/ echo "#!/data/data/com.termux/files/usr/bin/bash cd ~/aswad-superadmin-ewallet && ./start-all.sh" > ~/.termux/boot/start-superadmin.sh chmod +x ~/.termux/boot/start-superadmin.sh

termux-wake-lock termux-reboot

10. Siap dan git push balik

cd ~/aswad-superadmin-ewallet git add . git commit -m "✅ Auto-Setup: Tambah .env, autostart, webhook, crontab boot" git push -u origin main

echo "🎉 SEMUA SELESAI: SuperAdmin eWallet 100% disiapkan!"

#!/data/data/com.termux/files/usr/bin/bash

echo "📦 Updating Termux & Installing Dependencies..."
pkg update -y && pkg upgrade -y
pkg install -y git nodejs wget curl nano

echo "🔐 Setting up SSH config..."
mkdir -p ~/.ssh
touch ~/.ssh/known_hosts

echo "📁 Cloning SuperAdmin eWallet..."
rm -rf ~/aswad-superadmin-ewallet
git clone https://github.com/AswadXenOS/aswad-superadmin-ewallet.git
cd ~/aswad-superadmin-ewallet

echo "🧠 Setting up Backend..."
cd backend
cat > .env <<EOF
PORT=3000
JWT_SECRET=superadmin-secret
EOF
npm install

echo "⚙️ Setting up Telegram Bot..."
cd ../telegram-bot
cat > .env <<EOF
BOT_TOKEN=7731637512:AAG6MnAuHWkSQjvIQ3XQpKuS_k5fy8vAgt8
CHAT_ID=7970381824
EOF
npm install

echo "🤖 Setting up GPT CLI Bot..."
cd ../gpt-cli
cat > .env <<EOF
OPENAI_API_KEY=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
EOF
npm install

echo "🌐 Setting up Frontend..."
cd ../frontend
npm install

echo "🚀 Running All Services..."
cd ../backend && node index.js &
cd ../telegram-bot && node bot.js &
cd ../gpt-cli && node gpt.js &

echo "🛠️ Setting Up Termux Boot AutoStart..."
mkdir -p ~/.termux/boot
cat > ~/.termux/boot/start.sh <<EOF
#!/data/data/com.termux/files/usr/bin/bash
cd ~/aswad-superadmin-ewallet/backend && node index.js &
cd ~/aswad-superadmin-ewallet/telegram-bot && node bot.js &
cd ~/aswad-superadmin-ewallet/gpt-cli && node gpt.js &
EOF
chmod +x ~/.termux/boot/start.sh

echo "✅ Full Auto-Setup Completed!"

#!/bin/bash
set -e

echo "🚀 Mulakan auto-setup SuperAdmin eWallet..."

# 1. Update Termux & install dependencies
pkg update -y && pkg upgrade -y
pkg install -y git nodejs ffmpeg curl

# 2. Clone repo (jika belum ada)
if [ ! -d "$HOME/aswad-superadmin-ewallet" ]; then
  git clone https://github.com/AswadXenOS/aswad-superadmin-ewallet.git $HOME/aswad-superadmin-ewallet
else
  echo "Repo sudah ada, tarik update..."
  cd $HOME/aswad-superadmin-ewallet && git pull origin main
fi

cd $HOME/aswad-superadmin-ewallet

# 3. Setup .env files jika belum ada
if [ ! -f backend/.env ]; then
cat > backend/.env <<EOF
PORT=3000
DATABASE_PATH=./database/ewallet.db
EOF
fi

if [ ! -f telegram-bot/.env ]; then
cat > telegram-bot/.env <<EOF
TELEGRAM_TOKEN=7731637512:AAG6MnAuHWkSQjvIQ3XQpKuS_k5fy8vAgt8
EOF
fi

if [ ! -f gpt-cli/.env ]; then
cat > gpt-cli/.env <<EOF
OPENAI_API_KEY=idsk-svcacct-mRj6I3cD8EaVIMiqkO9FhdF7FPONdevMBWUq6BKXYu4rH6pM9tPuXCrbXZnXkK98PGUm3MVY1MT3BlbkFJM1TOEYhDX5UPTw4FMiICyVVtxIUaSj2IbOoeOWUU6eNDXFoE4u6MtNudEfN6Gozh_AW_lMbnUA
EOF
fi

# 4. Install semua dependencies
cd backend && npm install && cd ..
cd telegram-bot && npm install && cd ..
cd gpt-cli && npm install && cd ..

# 5. Start backend, telegram-bot, frontend (frontend assumed static serve on 5173)
# Use tmux or background processes for auto start
# Example simple background start:

echo "🚀 Mulakan backend"
cd backend
node index.js > backend.log 2>&1 &
cd ..

echo "🚀 Mulakan telegram bot"
cd telegram-bot
node bot.js > telegram-bot.log 2>&1 &
cd ..

echo "🚀 Mulakan frontend"
cd frontend
npm run dev > frontend.log 2>&1 &
cd ..

# 6. Setup autostart untuk Termux boot
mkdir -p ~/.termux/boot
cat > ~/.termux/boot/start-superadmin.sh <<EOF
#!/bin/bash
cd $HOME/aswad-superadmin-ewallet/backend && node index.js > backend.log 2>&1 &
cd $HOME/aswad-superadmin-ewallet/telegram-bot && node bot.js > telegram-bot.log 2>&1 &
cd $HOME/aswad-superadmin-ewallet/frontend && npm run dev > frontend.log 2>&1 &
EOF
chmod +x ~/.termux/boot/start-superadmin.sh

echo "✅ Setup autostart selesai. Buka Termux dan jalankan 'termux-boot' untuk cuba autostart."

# 7. Commit & push to GitHub
git add .
git commit -m "Auto setup: update .env and autostart scripts"
git push origin main || echo "⚠️ Push gagal. Sila check sambungan GitHub."

echo "🎉 Setup lengkap! Backend, bot, dan frontend berjalan."
echo "Log boleh tengok di backend.log, telegram-bot.log, frontend.log"

#!/data/data/com.termux/files/usr/bin/bash set -e
 
echo "🚀 Memulakan FULL Auto-Setup SuperAdmin eWallet..."
 
# 1️⃣ Pasang keperluan sistem
 
echo "[1/12] Pasang pakej asas..." apt update -y && apt upgrade -y apt install -y git nodejs curl openssh termux-api
 
# 2️⃣ SSH key (tanpa password)
 
echo "[2/12] Sediakan SSH key..." if [ ! -f ~/.ssh/id_ed25519 ]; then ssh-keygen -t ed25519 -N "" -C "AswadXenOS@users.noreply.github.com" -f ~/.ssh/id_ed25519 echo "🗒️ Salin kunci ke GitHub:" cat ~/.ssh/id_ed25519.pub read -p "👉 Tekan ENTER selepas tambah ke GitHub..." fi eval "$(ssh-agent -s)" ssh-add ~/.ssh/id_ed25519
 
# 3️⃣ Klon atau kemaskini repo
 
echo "[3/12] Clone / pull repo..." cd ~ if [ -d aswad-superadmin-ewallet ]; then cd aswad-superadmin-ewallet && git reset --hard && git pull else git clone git@github.com:AswadXenOS/aswad-superadmin-ewallet.git cd aswad-superadmin-ewallet fi
 
# 4️⃣ Struktur folder
 
echo "[4/12] Wujudkan direktori..." mkdir -p backend frontend gpt-cli telegram-bot plugins logs data
 
# 5️⃣ .env
 
echo "[5/12] Buat .env..." cat > .env <<EOF OPENAI_API_KEY=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 TELEGRAM_BOT_TOKEN=YOUR_TELEGRAM_TOKEN MASTER_PASS=aswadultimate PORT=3000 EOF
 
# 6️⃣ Backend
 
echo "[6/12] Pasang & sediakan Backend..." cd backend npm init -y npm install express cors sqlite3 bcryptjs qrcode speakeasy fs-extra mkdir -p ../data cat > index.js <<'EOF' const express = require('express'); const cors = require('cors'); const { open } = require('sqlite'); const sqlite3 = require('sqlite3'); const routes = require('./routes');
 
(async () => { const db = await open({ filename: '../data/data.db', driver: sqlite3.Database }); await db.exec(`CREATE TABLE IF NOT EXISTS users ( id INTEGER PRIMARY KEY, username TEXT UNIQUE, password TEXT, balance INTEGER DEFAULT 0 ); CREATE TABLE IF NOT EXISTS logs ( id INTEGER PRIMARY KEY, action TEXT, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP );`); const app = express(); app.use(cors()); app.use(express.json()); app.use('/api', routes(db)); const PORT = process.env.PORT || 3000; app.listen(PORT, () => console.log("✅ Backend ready on port", PORT)); })(); EOF
 
cat > routes.js <<'EOF' module.exports = (db) => { const r = require('express').Router(); const bcrypt = require('bcryptjs'); const speakeasy = require('speakeasy'); const QRCode = require('qrcode');
 
r.post('/login', async (req, res) => { const { username, password } = req.body; const u = await db.get('SELECT * FROM users WHERE username=?', username); if (!u || !bcrypt.compareSync(password, u.password)) return res.status(403).json({ error: 'Invalid' }); res.json({ id: u.id, username: u.username, balance: u.balance }); });
 
r.get('/users', async (_, res) => { res.json(await db.all('SELECT id, username, balance FROM users')); });
 
r.post('/transfer', async (req, res) => { const { from, to, amount } = req.body; const s = await db.get('SELECT balance FROM users WHERE username=?', from); const t = await db.get('SELECT balance FROM users WHERE username=?', to); if (!s || !t || s.balance < amount) return res.status(400).json({ error: 'Insufficient' }); await db.run('UPDATE users SET balance=balance-? WHERE username=?', amount, from); await db.run('UPDATE users SET balance=balance+? WHERE username=?', amount, to); await db.run('INSERT INTO logs(action) VALUES(?)', [`${from}->${to} RM${amount}`]); res.json({ success: true }); });
 
r.get('/qr/:u', async (req, res) => { const url = await QRCode.toDataURL(JSON.stringify(req.params)); res.json({ qr: url }); });
 
r.post('/2fa/secret', (_, res) => res.json({ secret: speakeasy.generateSecret({ length: 20 }).ascii }) ); r.post('/2fa/verify', (req, res) => { const v = speakeasy.totp.verify({ secret: req.body.secret, token: req.body.token, encoding: 'ascii' }); res.json({ valid: v }); });
 
return r; }; EOF cd ..
 
# 7️⃣ GPT-CLI
 
echo "[7/12] Pasang GPT-CLI..." cd gpt-cli npm init -y npm install readline openai dotenv cat > gpt.js <<'EOF' const rl = require('readline').createInterface(process.stdin, process.stdout); const { Configuration, OpenAIApi } = require('openai'); require('dotenv').config({ path: '../.env' }); const ai = new OpenAIApi(new Configuration({ apiKey: process.env.OPENAI_API_KEY })); rl.on('line', async q => { const r = await ai.createChatCompletion({ model: 'gpt-3.5-turbo', messages: [{ role: 'user', content: q }] }); console.log("🤖", r.data.choices[0].message.content); }); EOF cd ..
 
# 8️⃣ Telegram Bot
 
echo "[8/12] Pasang Telegram Bot..." cd telegram-bot npm init -y npm install node-telegram-bot-api dotenv cat > bot.js <<'EOF' require('dotenv').config({ path: '../.env' }); const TelegramBot = require('node-telegram-bot-api'); const b = new TelegramBot(process.env.TELEGRAM_BOT_TOKEN, { polling: true }); b.onText(//start/, m => b.sendMessage(m.chat.id, '🤖 eWallet Bot Aktif!')); EOF cd ..
 
# 9️⃣ Frontend
 
echo "[9/12] Setup Frontend React..." cd frontend npm create vite@latest . -- --template react npm install cd ..
 
# 🔟 Launcher scripts
 
echo "[10/12] Buat skrip pelancaran..." echo "cd ~/aswad-superadmin-ewallet/backend && node index.js" > ~/start-backend.sh echo "cd ~/aswad-superadmin-ewallet/frontend && npm run dev" > ~/start-frontend.sh echo "cd ~/aswad-superadmin-ewallet/gpt-cli && node gpt.js" > ~/start-gpt.sh echo "cd ~/aswad-superadmin-ewallet/telegram-bot && node bot.js" > ~/start-bot.sh chmod +x ~/start-*.sh
 
# 1️⃣1️⃣ Termux Boot Autostart
 
echo "[11/12] Pasang autostart..." mkdir -p ~/.termux/boot cp ~/aswad-superadmin-ewallet/start-*.sh ~/.termux/boot/
 
# 1️⃣2️⃣ Git Auto-Push
 
echo "[12/12] Commit & push ke GitHub..." cd ~/aswad-superadmin-ewallet git config user.name  "Aswad Xenist" git config user.email "AswadXenOS@users.noreply.github.com" git add . git commit -m "✅ Auto-setup selesai" || echo "⚠️ Tiada perubahan" git push -u origin main --force || echo "⚠️ Push ditolak"
 
# Selesai
 
echo "🎉 SEMUA SIAP 100%!" termux-notification --title "SuperAdmin eWallet" --content "✅ Setup Lengkap!"

#!/bin/bash

clear echo "🚀 Memulakan Auto Setup SuperAdmin eWallet..."

Lokasi projek

cd ~/aswad-superadmin-ewallet || { echo "❌ Projek tidak dijumpai! Pastikan projek sudah di-clone."; exit 1; }

1. Auto cipta fail .env

echo "🔧 Menjana .env..." cat > .env <<EOF TELEGRAM_BOT_TOKEN=7731637512:AAG6MnAuHWkSQjvIQ3XQpKuS_k5fy8vAgt8 TELEGRAM_CHAT_ID=7970381824 OPENAI_API_KEY=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 EOF

2. Betulkan path sqlite

sed -i "s|sqlite.open().*|sqlite.open('./database/ewallet.db');|" backend/index.js || true mkdir -p backend/database && touch backend/database/ewallet.db

3. Pasang dependencies

cd backend && npm install && cd .. cd frontend && npm install && cd .. cd gpt-cli && npm install && cd ..

4. Autostart semua komponen

nohup node backend/index.js > backend.log 2>&1 & nohup node telegram-bot/index.js > telegram.log 2>&1 & nohup node gpt-cli/gpt.js > gptcli.log 2>&1 &

5. Setup crontab @reboot

crontab -l > mycron 2>/dev/null sed -i '/full-autosetup.sh/d' mycron echo "@reboot bash $HOME/aswad-superadmin-ewallet/full-autosetup.sh" >> mycron crontab mycron && rm mycron

6. Git commit & push

chmod +x full-autosetup.sh git add . && git commit -m "🔁 Auto-setup: .env + autostart + webhook + crontab" && git push origin main

echo "✅ Siap! Anda boleh run setup bila-bila masa dengan:" echo "bash $HOME/aswad-superadmin-ewallet/full-autosetup.sh"
