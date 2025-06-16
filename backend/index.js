const express = require('express');
const cors = require('cors');
const sqlite = require('sqlite');
const sqlite3 = require('sqlite/sqlite3');
const routes = require('./routes');

(async () => {
  const db = await sqlite.open({ filename: './data.db', driver: sqlite3.Database });
  await db.run("CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY, username TEXT UNIQUE, password TEXT, balance INTEGER DEFAULT 0)");
  await db.run("CREATE TABLE IF NOT EXISTS logs (id INTEGER PRIMARY KEY, action TEXT, timestamp DATETIME DEFAULT CURRENT_TIMESTAMP)");

  const app = express();
  app.use(cors());
  app.use(express.json());
  app.use('/api', routes(db));

  const PORT = process.env.PORT || 3000;
  app.listen(PORT, () => console.log(`✅ Backend running on port ${PORT}`));
})();
