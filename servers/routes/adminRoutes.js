const express = require('express');
const router = express.Router();
const { body, validationResult } = require('express-validator');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { createAdmin } = require('../models/adminModel');

// เส้นทางสำหรับสร้างข้อมูลผู้ดูแลระบบใหม่
router.post('/', [
  body('username').notEmpty().withMessage('Username is required'),
  body('password').notEmpty().withMessage('Password is required'),
], async (req, res) => {
  // ตรวจสอบว่ามีข้อผิดพลาดจาก express-validator หรือไม่
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  const { username, password } = req.body;

  try {
    // สร้าง hashed password
    const hashedPassword = await bcrypt.hash(password, 10);

    // สร้างข้อมูลผู้ดูแลระบบใหม่
    const result = await createAdmin(username, hashedPassword);
    const adminId = result.insertId;

    // สร้าง token
    const token = jwt.sign({ username: username }, secret, { expiresIn: '1h' });

    res.status(201).json({ message: 'Admin created successfully', adminId, token });
  } catch (error) {
    console.error('Error creating admin:', error.message);
    res.status(500).json({ error: 'Error creating admin' });
  }
});

module.exports = router;
    