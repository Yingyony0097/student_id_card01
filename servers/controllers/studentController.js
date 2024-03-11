const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const db = require('../models/studentModel');

// เรียกใช้งานฟังก์ชันเพื่อดึงข้อมูลนักเรียนทั้งหมด
const getAllStudents = async (req, res) => {
  try {
    const students = await db.getAllStudents(); // สมมติว่าฟังก์ชันใน studentModel.js ชื่อ getAllStudents()
    res.json(students);
  } catch (error) {
    console.error('Error fetching students:', error.message);
    res.status(500).json({ error: 'Error fetching students' });
  }
};

// เพิ่มฟังก์ชันอื่น ๆ ตามความต้องการ เช่น การเพิ่มนักเรียน การอัปเดตนักเรียน การลบนักเรียน เป็นต้น

module.exports = {
  getAllStudents,
  // เพิ่มฟังก์ชันอื่น ๆ ที่เกี่ยวข้องกับการจัดการข้อมูลของนักเรียนตามความเหมาะสม
};
