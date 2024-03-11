const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const db = require('../models/adminModel');

// ฟังก์ชันสำหรับสร้างผู้ดูแลระบบใหม่
const createAdmin = async (req, res) => {
  const { username, password } = req.body;

  try {
    // เข้ารหัสรหัสผ่าน
    const hashedPassword = await bcrypt.hash(password, 10); // 10 คือ saltRounds

    // เพิ่มผู้ดูแลระบบใหม่ลงในฐานข้อมูล
    const result = await db.createAdmin(username, hashedPassword);
    const adminId = result.insertId;

    res.status(201).json({ message: 'Admin created successfully', adminId });
  } catch (error) {
    console.error('Error creating admin:', error.message);
    res.status(500).json({ error: 'Error creating admin' });
  }
};

// เพิ่มฟังก์ชันอื่น ๆ ตามความต้องการ เช่น การล็อกอิน การอัปเดตข้อมูลผู้ดูแลระบบ เป็นต้น

module.exports = {
  createAdmin,
  // เพิ่มฟังก์ชันอื่น ๆ ที่เกี่ยวข้องกับการจัดการข้อมูลของผู้ดูแลระบบตามความเหมาะสม
};
