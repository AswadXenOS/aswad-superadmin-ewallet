#!/data/data/com.termux/files/usr/bin/bash

echo "==========================================="
echo "🚀 SUPERADMIN E-WALLET - FULL AUTO SETUP"
echo "==========================================="

# ====== 1. Install Dependencies ======
echo "[1/8] 📦 Installing system packages..."
pkg update -y && pkg install -y git nodejs curl nano

# ====== 2. Clone Repo Fresh ======
echo "[2/8] 🔄 Cloning repo..."
cd ~
rm -rf aswad-superadmin-ewallet
git clone https://github.com/AswadXenOS/aswad-superadmin-ewallet.git
cd aswad-superadmin-ewallet

# ====== 3. Create Required Backend Files ======
echo "[3/8] 🧠 Creating required backend files..."
mkdir -p backend/data
echo '{}' > backend/data/db.json
touch backend/data/audit.log
echo "PORT=3001" > backend/.env

# ====== 4. Install Backend (JS-only sqlite + bcryptjs) ======
echo "[4/8] ⚙️ Installing backend dependencies..."
cd backend
rm -rf node_modules package-lock.json
npm install express bcryptjs sqlite dotenv

# ====== 5. Install Frontend ======
echo "[5/8] 💻 Installing frontend..."
cd ../frontend
rm -rf node_modules package-lock.json
npm install

# ====== 6. Setup GPT CLI Bot ======
echo "[6/8] 🤖 Setting up GPT CLI bot..."
cd ../gpt-cli
rm -rf node_modules package-lock.json
npm install

# ====== 7. GitHub Auto Auth & Push ======
echo "[7/8] 🔐 Configuring GitHub push with PAT..."
cd ..
git config --global user.name "AswadXenOS"
git config --global user.email "aswad@example.com"
git remote set-url origin https://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@github.com/AswadXenOS/aswad-superadmin-ewallet.git
git add .
git commit -m "✅ Auto setup and push"
git push -u origin main

# ====== 8. Done ======
echo "✅ SETUP COMPLETE 100%! You can now run the system."

#!/data/data/com.termux/files/usr/bin/bash

echo "==========================================="
echo "🚀 SUPERADMIN E-WALLET - FULL AUTO SETUP"
echo "==========================================="

# ====== 1. Install Keperluan ======
echo "[1/9] 📦 Installing system packages..."
pkg update -y && pkg install -y git nodejs curl nano

# ====== 2. Clone Repo atau Update Jika Wujud ======
echo "[2/9] 🔁 Cloning or updating repo..."
cd ~
if [ -d "aswad-superadmin-ewallet" ]; then
  cd aswad-superadmin-ewallet
  git reset --hard
  git pull
else
  git clone https://github.com/AswadXenOS/aswad-superadmin-ewallet.git
  cd aswad-superadmin-ewallet
fi

# ====== 3. Auto Cipta Fail Penting ======
echo "[3/9] 🧠 Creating required backend files..."
mkdir -p backend/data
[ ! -f backend/data/db.json ] && echo '{}' > backend/data/db.json
[ ! -f backend/data/audit.log ] && touch backend/data/audit.log
[ ! -f backend/.env ] && echo "PORT=3001" > backend/.env

# ====== 4. Install Backend ======
echo "[4/9] ⚙️ Installing backend dependencies..."
cd backend
rm -rf node_modules package-lock.json
npm install express bcryptjs sqlite dotenv

# ====== 5. Install Frontend ======
echo "[5/9] 💻 Installing frontend..."
cd ../frontend
rm -rf node_modules package-lock.json
npm install

# ====== 6. Setup GPT CLI Bot ======
echo "[6/9] 🤖 Setting up GPT CLI bot..."
cd ../gpt-cli
rm -rf node_modules package-lock.json
npm install

# ====== 7. Auto Generate & Save Start Script ======
echo "[7/9] 🧬 Generating start script..."
cd ~
cat > start-superadmin.sh <<EOF
#!/data/data/com.termux/files/usr/bin/bash
cd ~/aswad-superadmin-ewallet/backend && nohup node index.js &
cd ~/aswad-superadmin-ewallet/frontend && nohup npm run dev &
cd ~/aswad-superadmin-ewallet/gpt-cli && nohup node gpt.js &
EOF
chmod +x start-superadmin.sh

# ====== 8. GitHub Push Dengan Token ======
echo "[8/9] 🔐 GitHub push..."
cd ~/aswad-superadmin-ewallet
git config --global user.name "AswadXenOS"
git config --global user.email "aswad@example.com"
git remote set-url origin https://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@github.com/AswadXenOS/aswad-superadmin-ewallet.git
git add .
git commit -m "✅ Auto setup update"
git push -u origin main

# ====== 9. Siap! ======
echo "==========================================="
echo "✅ SYSTEM READY 100%!"
echo "👉 Untuk run: bash ~/start-superadmin.sh"
echo "==========================================="
