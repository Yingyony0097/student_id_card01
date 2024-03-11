const express = require('express');
const bodyParser = require('body-parser');
const studentRoutes = require('./routes/studentRoutes');
const adminRoutes = require('./routes/adminRoutes');
const authRoutes = require('./routes/authRoutes');

const app = express();

// ใช้ body-parser เพื่อแปลงข้อมูลที่ส่งมาในรูปแบบ JSON ให้เป็น JavaScript object
app.use(bodyParser.json());

// เรียกใช้งานเส้นทางสำหรับการจัดการข้อมูลนักเรียน
app.use('/student', studentRoutes);

// เรียกใช้งานเส้นทางสำหรับการจัดการข้อมูลผู้ดูแลระบบ
app.use('/admin', adminRoutes);

// เรียกใช้งานเส้นทางสำหรับการยืนยันตัวตนและสร้าง token
app.use('/auth', authRoutes);

const PORT = process.env.PORT || 8000;

app.listen(PORT, () => {
  console.log(`Server started on port ${PORT}`);
});
