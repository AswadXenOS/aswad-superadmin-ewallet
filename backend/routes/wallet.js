const express = require('express');
const router = express.Router();
const { transfer } = require('../controllers/wallet');

router.post('/transfer', transfer);

module.exports = router;
