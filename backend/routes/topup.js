const express = require("express");
const fs = require("fs");
const router = express.Router();
const DB_FILE = "./data/topups.json";

if (!fs.existsSync(DB_FILE)) fs.writeFileSync(DB_FILE, "[]");

router.post("/request", (req, res) => {
  const { name, email, amount } = req.body;
  const topups = JSON.parse(fs.readFileSync(DB_FILE));
  topups.push({ id: Date.now(), name, email, amount, status: "pending" });
  fs.writeFileSync(DB_FILE, JSON.stringify(topups, null, 2));
  res.json({ success: true });
});

router.get("/list", (req, res) => {
  const topups = JSON.parse(fs.readFileSync(DB_FILE));
  res.json(topups);
});

router.post("/approve/:id", (req, res) => {
  const topups = JSON.parse(fs.readFileSync(DB_FILE));
  const idx = topups.findIndex(t => t.id == req.params.id);
  if (idx >= 0) {
    topups[idx].status = "approved";
    fs.writeFileSync(DB_FILE, JSON.stringify(topups, null, 2));
    res.json({ success: true });
  } else {
    res.status(404).json({ success: false, message: "Topup not found" });
  }
});

module.exports = router;
