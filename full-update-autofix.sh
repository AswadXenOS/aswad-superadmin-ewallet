#!/bin/bash

echo "🔄 Memulakan proses auto-update & auto-fix SuperAdmin eWallet..."

cd ~/aswad-superadmin-ewallet || { echo "❌ Folder tidak wujud."; exit 1; }

git stash save "🛠️ Auto stash sebelum update"
git pull --rebase origin main || {
  echo "❌ Gagal rebase, cuba reset sebagai alternatif..."
  git rebase --abort
  git reset --hard origin/main
  git clean -fd
  git pull origin main
}
git stash pop || true

FOLDER_LIST=("backend" "frontend" "gpt-cli" "telegram-bot")

for folder in "${FOLDER_LIST[@]}"; do
  echo "📦 Memasang dependencies dalam $folder..."
  cd "$folder" || continue
  npm install || echo "⚠️ Gagal pasang di $folder"
  cd ..
done

if [ ! -f backend/.env ]; then
  echo "PORT=3001" > backend/.env
  echo "TELEGRAM_BOT_TOKEN=7731637512:AAG6MnAuHWkSQjvIQ3XQpKuS_k5fy8vAgt8" >> backend/.env
  echo "TELEGRAM_CHAT_ID=7970381824" >> backend/.env
  echo "✅ .env backend dicipta semula."
fi

mkdir -p backend/data
[ ! -f backend/data/database.db ] && echo "# db" > backend/data/database.db

echo "✅ Semua komponen dikemaskini."
echo "👉 Untuk mula server: ./start-server.sh"
echo "👉 Untuk GPT CLI: ./start-gpt.sh"
