const express = require('express');
const router = express.Router();

router.post('/bank/transfer', (req, res) => {
  res.json({ status: 'success', message: 'Transfer berjaya (mock)' });
});

router.post('/whatsapp/send', (req, res) => {
  res.json({ status: 'sent', message: 'WhatsApp dihantar (mock)' });
});

module.exports = router;
