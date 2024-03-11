const express = require('express');
const router = express.Router();
const { body, validationResult } = require('express-validator');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { createAdmin } = require('../models/adminModel');

// เส้นทางสำหรับเข้าสู่ระบบผู้ดูแลระบบ
router.post('/login', async (req, res) => {
  const { username, password } = req.body;

  try {
    // ค้นหาข้อมูลผู้ดูแลระบบจากฐานข้อมูล
    const [adminResult] = await conn.query('SELECT * FROM admin WHERE username = ?', [username]);

    // ถ้าไม่พบผู้ดูแลระบบ
    if (adminResult.length === 0) {
      return res.status(401).json({ error: 'Invalid username' });
    }

    const admin = adminResult[0];

    // ตรวจสอบรหัสผ่าน
    const isPasswordMatch = await bcrypt.compare(password, admin.password);

    if (isPasswordMatch) {
      // สร้าง token
      const token = jwt.sign({ username: admin.username }, secret, { expiresIn: '1h' });
      return res.status(200).json({ message: 'Login successful', token });
    } else {
      return res.status(401).json({ error: 'Invalid password' });
    }
  } catch (error) {
    console.error('Error logging in:', error.message);
    res.status(500).json({ error: 'Error logging in' });
  }
});

module.exports = router;
