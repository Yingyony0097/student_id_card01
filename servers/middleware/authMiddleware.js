const jwt = require('jsonwebtoken');
const secret = 'FullstackLogin';

// Middleware สำหรับตรวจสอบ token และสิทธิ์การเข้าถึง
const verifyToken = (req, res, next) => {
  try {
    // ตรวจสอบว่ามีส่วนของ Authorization ใน header หรือไม่
    if (!req.headers.authorization) {
      return res.status(401).json({ error: 'Authorization header is missing' });
    }
    
    // แยกส่วนของ token ออกมาจาก header
    const parts = req.headers.authorization.split(' ');
    if (parts.length !== 2 || parts[0].toLowerCase() !== 'bearer') {
      return res.status(401).json({ error: 'Authorization header is in the incorrect format' });
    }
    
    const token = parts[1];
    
    // ตรวจสอบ token JWT
    const decoded = jwt.verify(token, secret);
    
    // แนบ payload ที่ถูก decode เข้ากับ request object
    req.decoded = decoded;
    
    // ไปยัง middleware ถัดไป
    next();
  } catch (error) {
    // หากเกิด error ในระหว่างการตรวจสอบ token
    res.status(401).json({ error: 'Invalid token' });
  }
};

module.exports = verifyToken;
