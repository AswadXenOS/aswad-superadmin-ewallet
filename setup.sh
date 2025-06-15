#!/data/data/com.termux/files/usr/bin/bash

echo "[1/5] Installing Node.js & SQLite..."
pkg update -y && pkg install -y nodejs sqlite

echo "[2/5] Cloning latest SuperAdmin eWallet repo..."
rm -rf ~/aswad-superadmin-ewallet
git clone https://github.com/AswadXenOS/aswad-superadmin-ewallet.git ~/aswad-superadmin-ewallet

echo "[3/5] Installing dependencies..."
cd ~/aswad-superadmin-ewallet/backend
npm install

echo "[4/5] Creating default .env file..."
cat > .env <<EOF
PORT=3000
JWT_SECRET=supersecretkey
EOF

echo "[5/5] Starting backend server..."
nohup node server.js > server.log 2>&1 &
echo "✅ Server running in background! Log: backend/server.log"
