const db = require('../db');

exports.transfer = (req, res) => {
  const { to, amount } = req.body;
  const amt = parseFloat(amount);

  if (!to || isNaN(amt)) return res.status(400).json({ error: 'Maklumat tidak lengkap' });

  const user = db.prepare('SELECT * FROM users WHERE username = ?').get(to);
  if (!user) return res.status(404).json({ error: 'Pengguna tidak dijumpai' });

  db.prepare('UPDATE users SET balance = balance + ? WHERE username = ?').run(amt, to);
  db.prepare('INSERT INTO transactions (from_user, to_user, amount) VALUES (?, ?, ?)').run('superadmin', to, amt);

  res.json({ message: `Transfer RM${amt} kepada ${to} berjaya.` });
};
