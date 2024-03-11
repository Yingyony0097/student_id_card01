const mysql = require('mysql2/promise');

const connectMySQL = async () => {
  try {
    const conn = await mysql.createConnection({
      host: 'localhost',
      user: 'root',
      password: '',
      database: 'e_student',
      port: '3306'
    });

    console.log('Connected to MySQL database');
    return conn;
  } catch (error) {
    console.error('Error connecting to MySQL database:', error.message);
    throw error; // โยน error ออกไปเพื่อให้ middleware หรือ controller จัดการ
  }
}

const getAllStudents = async () => {
  try {
    const conn = await connectMySQL();
    const [rows] = await conn.query('SELECT * FROM student');
    return rows;
  } catch (error) {
    console.error('Error fetching students:', error.message);
    throw error; // โยน error ออกไปเพื่อให้ middleware หรือ controller จัดการ
  }
};

const createStudent = async (data) => {
  try {
    const conn = await connectMySQL();
    const [result] = await conn.query('INSERT INTO student (sdCardID, fname_la, lname_la, fname_en, lname_en, date_of_birth, date_start, date_end, images, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', [data.sdCardID, data.fname_la, data.lname_la, data.fname_en, data.lname_en, data.date_of_birth, data.date_start, data.date_end, data.images, data.password]);
    return result;
  } catch (error) {
    console.error('Error creating student:', error.message);
    throw error; // โยน error ออกไปเพื่อให้ middleware หรือ controller จัดการ
  }
};

// เพิ่มฟังก์ชันอื่น ๆ ตามความต้องการ เช่น การอัปเดตข้อมูล การลบข้อมูล เป็นต้น

module.exports = {
  getAllStudents,
  createStudent,
  // เพิ่มฟังก์ชันอื่น ๆ ที่เกี่ยวข้องกับการจัดการข้อมูลของนักเรียนตามความเหมาะสม
};
