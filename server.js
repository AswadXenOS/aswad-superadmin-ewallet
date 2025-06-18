const express = require('express');
const fs = require('fs');
const app = express();
app.use(express.json());

const loadDB = () => JSON.parse(fs.readFileSync('./db.json'));
const saveDB = (db) => fs.writeFileSync('./db.json', JSON.stringify(db, null, 2));

app.get('/users', (req, res) => res.json(loadDB().users));
app.post('/transfer', (req, res) => {
  const { from, to, amount } = req.body;
  let db = loadDB();
  const userFrom = db.users.find(u => u.username === from);
  const userTo = db.users.find(u => u.username === to);
  if (!userFrom || !userTo) return res.status(404).send("User not found");
  if (userFrom.wallet < amount) return res.status(400).send("Insufficient balance");
  userFrom.wallet -= amount;
  userTo.wallet += amount;
  db.transactions.push({ from, to, amount, at: Date.now() });
  saveDB(db);
  res.send("Transfer complete");
});
app.listen(3000, () => console.log('💰 Backend running at http://localhost:3000'));
