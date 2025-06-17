#!/data/data/com.termux/files/usr/bin/bash

echo "🔄 Memulakan proses auto-update & auto-push SuperAdmin eWallet..."

cd ~/aswad-superadmin-ewallet || { echo "❌ Folder tidak wujud."; exit 1; }

# Stash perubahan jika ada
git stash save "🛠️ Auto stash sebelum update" > /dev/null

# Pull & rebase dari repo utama
git pull --rebase origin main || {
  echo "❌ Rebase gagal. Membatalkan dan kembali ke keadaan asal..."
  git rebase --abort
}

# Kembalikan semula perubahan
git stash pop || true

# Senarai folder dengan projek npm
FOLDER_LIST=("backend" "frontend" "gpt-cli" "telegram-bot")

# Loop untuk npm install
for folder in "${FOLDER_LIST[@]}"; do
  echo "📦 Memasang dependencies dalam $folder..."
  cd "$folder" || { echo "❌ Folder $folder tidak wujud."; cd ..; continue; }
  npm install > /dev/null
  cd ..
done

# Auto cipta fail .env jika tiada
if [ ! -f backend/.env ]; then
  echo "🔐 Mencipta fail backend/.env..."
  cat > backend/.env <<EOF
PORT=3001
TELEGRAM_BOT_TOKEN=YOUR_TELEGRAM_TOKEN_HERE
TELEGRAM_CHAT_ID=YOUR_CHAT_ID_HERE
EOF
fi

# Commit & Push perubahan
echo "📤 Git commit & push semua perubahan..."
git add .
git commit -m "🆕 AutoUpdate: Semua folder & dependensi dikemaskini ✅" || echo "⚠️ Tiada perubahan untuk commit."
git push origin main

echo "✅ Semua update selesai & dipush ke GitHub."
echo "👉 Untuk mula server: ./start-server.sh"
echo "👉 Untuk GPT CLI: ./start-gpt.sh"
