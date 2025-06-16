#!/bin/bash

echo "🚀 Mulakan AutoStart SuperAdmin eWallet..."

cd ~/aswad-superadmin-ewallet || exit 1

# ✅ Start Backend
echo "🟢 Mulakan backend..."
cd backend || exit 1
nohup node index.js > backend.log 2>&1 &
cd ..

# ✅ Start Frontend
echo "🟢 Mulakan frontend..."
cd frontend || exit 1
nohup npm run dev > frontend.log 2>&1 &
cd ..

# ✅ Start Telegram Bot
echo "🟢 Mulakan Telegram Bot..."
cd telegram-bot || exit 1
nohup node bot.js > bot.log 2>&1 &
cd ..

# ✅ Register Webhook jika perlu (masukkan token & webhook URL sebenar)
# curl -s -X POST "https://api.telegram.org/bot<YOUR_BOT_TOKEN>/setWebhook?url=https://yourdomain.com/telegram-webhook"

# ✅ Auto CLI SuperAdmin ready
echo 'node superadmin-cli.js' > ~/start-superadmin.sh
chmod +x ~/start-superadmin.sh

echo "✅ Siap! Semua servis sudah dimulakan."

#!/bin/bash

echo "🚀 Mulakan AutoStart SuperAdmin eWallet..."

cd ~/aswad-superadmin-ewallet || exit 1

# ✅ Start Backend
echo "🟢 Mulakan backend..."
cd backend || exit 1
nohup node index.js > backend.log 2>&1 &
cd ..

# ✅ Start Frontend
echo "🟢 Mulakan frontend..."
cd frontend || exit 1
nohup npm run dev > frontend.log 2>&1 &
cd ..

# ✅ Start Telegram Bot
echo "🟢 Mulakan Telegram Bot..."
cd telegram-bot || exit 1
nohup node bot.js > bot.log 2>&1 &
cd ..

# ✅ Register Telegram Webhook
echo "🔗 Register Telegram Webhook..."
BOT_TOKEN="7731637512:AAG6MnAuHWkSQjvIQ3XQpKuS_k5fy8vAgt8"
WEBHOOK_URL="https://aswadxen-api.vercel.app/api/telegram-webhook"

curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/setWebhook?url=$WEBHOOK_URL" > /dev/null
echo "✅ Webhook didaftarkan: $WEBHOOK_URL"

# ✅ Sediakan CLI SuperAdmin
echo 'cd ~/aswad-superadmin-ewallet && node superadmin-cli.js' > ~/start-superadmin.sh
chmod +x ~/start-superadmin.sh

echo "✅ Semua servis dimulakan & webhook didaftarkan!"
