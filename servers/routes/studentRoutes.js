const express = require('express');
const router = express.Router();
const { body, validationResult } = require('express-validator');
const verifyToken = require('../middleware/authMiddleware');
const isAdmin = require('../middleware/adminMiddleware');
const { getAllStudents, createStudent } = require('../models/studentModel');

// เส้นทางสำหรับดึงข้อมูลนักเรียนทั้งหมด
router.get('/', verifyToken, isAdmin, async (req, res) => {
  try {
    const students = await getAllStudents();
    res.json(students);
  } catch (error) {
    console.error('Error fetching students:', error.message);
    res.status(500).json({ error: 'Error fetching students' });
  }
});

// เส้นทางสำหรับสร้างข้อมูลนักเรียนใหม่
router.post('/', [
  body('sdCardID').notEmpty().withMessage('sdCardID is required'),
  // เพิ่มการตรวจสอบสิ่งที่จำเป็นสำหรับข้อมูลอื่น ๆ ตามความเหมาะสม
], verifyToken, isAdmin, async (req, res) => {
  // ตรวจสอบว่ามีข้อผิดพลาดจาก express-validator หรือไม่
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  // สร้างข้อมูลนักเรียนใหม่
  try {
    const result = await createStudent(req.body);
    const studentId = result.insertId;
    res.status(201).json({ message: 'Student created successfully', studentId });
  } catch (error) {
    console.error('Error creating student:', error.message);
    res.status(500).json({ error: 'Error creating student' });
  }
});

module.exports = router;
