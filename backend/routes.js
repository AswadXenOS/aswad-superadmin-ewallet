module.exports = (db) => {
  const router = require('express').Router();
  const bcrypt = require('bcryptjs');
  const speakeasy = require('speakeasy');
  const QRCode = require('qrcode');

  router.post('/login', async (req, res) => {
    const { username, password } = req.body;
    const user = await db.get('SELECT * FROM users WHERE username = ?', username);
    if (!user || !bcrypt.compareSync(password, user.password)) {
      return res.status(403).json({ error: 'Invalid credentials' });
    }
    res.json({ id: user.id, username: user.username, balance: user.balance });
  });

  router.get('/users', async (_, res) => {
    res.json(await db.all('SELECT id, username, balance FROM users'));
  });

  router.post('/transfer', async (req, res) => {
    const { from, to, amount } = req.body;
    const src = await db.get('SELECT balance FROM users WHERE username = ?', from);
    const dst = await db.get('SELECT balance FROM users WHERE username = ?', to);
    if (!src || !dst || src.balance < amount) {
      return res.status(400).json({ error: 'Transfer failed' });
    }
    await db.run('UPDATE users SET balance = balance - ? WHERE username = ?', amount, from);
    await db.run('UPDATE users SET balance = balance + ? WHERE username = ?', amount, to);
    await db.run('INSERT INTO logs(action) VALUES(?)', [`${from}->${to} RM${amount}`]);
    res.json({ success: true });
  });

  router.get('/qr/:user', async (req, res) => {
    const url = await QRCode.toDataURL(JSON.stringify(req.params));
    res.json({ qr: url });
  });

  router.post('/2fa/secret', (_, res) => {
    res.json({ secret: speakeasy.generateSecret({ length: 20 }).ascii });
  });

  router.post('/2fa/verify', (req, res) => {
    const { secret, token } = req.body;
    res.json({ valid: speakeasy.totp.verify({ secret, encoding: 'ascii', token }) });
  });

  return router;
};
