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

const createAdmin = async (username, hashedPassword) => {
  try {
    const conn = await connectMySQL();
    const [result] = await conn.query('INSERT INTO admin (username, password) VALUES (?, ?)', [username, hashedPassword]);
    return result;
  } catch (error) {
    console.error('Error creating admin:', error.message);
    throw error; // โยน error ออกไปเพื่อให้ middleware หรือ controller จัดการ
  }
};

// เพิ่มฟังก์ชันอื่น ๆ ตามความต้องการ เช่น การอัปเดตข้อมูล การลบข้อมูล เป็นต้น

module.exports = {
  createAdmin,
  // เพิ่มฟังก์ชันอื่น ๆ ที่เกี่ยวข้องกับการจัดการข้อมูลของผู้ดูแลระบบตามความเหมาะสม
};
