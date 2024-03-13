require ('dotenv').config();
const express = require('express')
const app = express()
const bodyParser = require('body-parser')
const mysql = require('mysql2/promise')
const { body, param, validationResult } = require('express-validator');
const bcrypt = require('bcrypt');
var jwt = require('jsonwebtoken');
const secret = 'FullstackLogin';


app.use(bodyParser.json())
const port = process.env.APP_PORT

const pnv = process.env
// let conn = null
console.log(pnv)
// function connectMySQL
const connectMySQL = async () => {
  try {
    conn = await mysql.createConnection({
      host: pnv.DB_HOST,
      user: pnv.DB_USER,
      password: pnv.DB_PASSOWRD,
      database: pnv.DB_NAME,
      port: process.env.DB_PORT
    });

    console.log('Connected to MySQL database');
  } catch (error) {
    console.error('Error connecting to MySQL database:', error.message);
  }
}

connectMySQL();
//verifyToken


const verifyToken = (req, res, next) => {
  try {
    console.log(req.headers)
    // Check if Authorization header exists
    if (!req.headers.authorization) {
      return res.status(401).json({ error: 'Authorization header is missing' });
      
    }
    
    // Split the Authorization header to extract the token
    const parts = req.headers.authorization.split(' ');
    if (parts.length !== 2 || parts[0].toLowerCase() !== 'bearer') {
      return res.status(401).json({ error: 'Authorization header is in the incorrect format' });
    }
    
    const token = parts[1];
    
    // Verify the JWT token
    const decoded = jwt.verify(token, secret);
    
    // Attach the decoded payload to the request object
    req.decoded = decoded;
    
    // Call next middleware
    next();
  } catch (error) {
    // If any error occurs during token verification
    res.status(401).json({ error: 'Invalid token' });
  }
};



const isAdmin = (req, res, next) => {
  // Check if req.admin exists and has the role 'admin'
  if (!req.admin || req.admin.role !== 'admin') {
    return res.status(403).json({ error: 'Access denied. Only admins are allowed to access this resource.' });
  }
  next(); // Allow the request to proceed
};




//get

app.get('/student',verifyToken, async (req, res) => {
  try {
    let results = await conn.query('SELECT * FROM student')
    res.json(results[0])
  } catch (error) {
    console.error('Error fetching student:', error.message)
    res.status(500).json({ error: 'Error fetching student' })
  }
})

//post

app.post('/student',verifyToken,isAdmin, async (req, res) => {
  const data = req.body;

  try {
    // Hash the password
    const hashedPassword = await bcrypt.hash(data.password, 10); // 10 is the saltRounds

    // Insert the hashed password into the database
    const result = await conn.query('INSERT INTO student (sdCardID, fname_la, lname_la, fname_en, lname_en, date_of_birth, date_start, date_end, images, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', [data.sdCardID, data.fname_la, data.lname_la, data.fname_en, data.lname_en, data.date_of_birth, data.date_start, data.date_end, data.images, hashedPassword]);
    
    const studentId = result.insertId;
    res.status(201).json({ message: 'student created successfully', studentId });
  } catch (error) {
    console.error('Error creating student:', error.message);
    res.status(500).json({ error: 'Error creating student' });
  }
});



app.post('/admin', verifyToken, async (req, res) => {
  const data = req.body;

  try {
    // Hash the password
  const hashedPassword = await bcrypt.hash(data.Password, 10); // 10 is the saltRounds

  // Insert the hashed password into the database
  const result = await conn.query('INSERT INTO admin (username, Password) VALUES (?, ?)', [data.username, hashedPassword]);
  
  const adminId = result.insertId;
  res.status(201).json({ message: 'Admin created successfully', adminId });
  } catch (error) {
    console.error('Error creating admin:', error.message);
    res.status(500).json({ error: 'Error creating admin' });
  }
});


app.post('/admin/login', async (req, res) => {
  const { username, password } = req.body;
  try {
    const [adminResult] = await conn.query('SELECT * FROM admin WHERE username = ?', [username]);

    if (adminResult.length === 0) {
      return res.status(401).json({ error: 'Invalid username' });
    }

    const admin = adminResult[0];

    if (!admin || !admin.password) {
      return res.status(401).json({ error: 'Invalid username or password' });
    }

    const isPasswordMatch = await bcrypt.compare(password, admin.password);

    if (isPasswordMatch) {
      const token = jwt.sign({ UserName: admin.username }, secret, { expiresIn: '1h' });
      return res.status(200).json({ message: 'Login successful', token });
    } else {
      return res.status(401).json({ error: 'Invalid username or password' });
    }
  } catch (error) {
    console.error('Error logging in admin:', error.message);
    return res.status(500).json({ error: 'Error logging in admin' });
  }
});












app.post('/login', async (req, res) => {
  const { sdCardID, password }= req.body;

  try {
    const result = await conn.query('SELECT * FROM student WHERE sdCardID = ?', [sdCardID]);
    console.log('Result:', result); // Log the result array

    const student = result[0][0];
    if (!student) {
      return res.status(401).json({ error: 'Invalid username ' });
    }

    const hashedPasswordFromDB = student.password;
    const isPasswordMatch = await bcrypt.compare(password, hashedPasswordFromDB);

    if (isPasswordMatch) {
      var token = jwt.sign({ sdCardID: student.sdCardID }, secret, { expiresIn: '1h' });
      res.status(200).json({ message: 'Login successful', token }); // Use res.status().json()
    } else {
      res.status(401).json({ error: 'Invalid  password' });
    }
  } catch (error) {
    console.error('Error logging in:', error.message);
    res.status(500).json({ error: 'Error logging in' });
  }
});


app.post('/login', async (req, res) => {
  const { UserName, password }= req.body;

  // try {
    
  // } catch (error) {
  //   console.error('Error logging in:', error.message);
  //   res.status(500).json({ error: 'Error logging in' });
  // }

  const result = await conn.query('SELECT * FROM admin WHERE UserName = ?', [UserName]);
    console.log('Result:', result); // Log the result array

    const admin = result[0][0]; // Change 'student' to 'admin'
    if (!admin) {
      return res.status(401).json({ error: 'Invalid username or password' });
    }

    const hashedPasswordFromDB = admin.password;
    const isPasswordMatch = await bcrypt.compare(password, hashedPasswordFromDB);

    if (isPasswordMatch) {
      var token = jwt.sign({ UserName: admin.UserName }, secret, { expiresIn: '1h' });
      res.status(200).json({ message: 'Login successful', token }); // Use res.status().json()
    } else {
      res.status(401).json({ error: 'Invalid username or password' });
    }
});


//getid


app.get('/student/:id', async (req, res) => {
  const id = req.params.id;

  // Validate sdCardID to ensure it's a number
  if (isNaN(id)) {
    return res.status(400).json({ error: 'Invalid id' });
  }

  try {
    // Using parameterized query to prevent SQL injection
    let [results] = await conn.query('SELECT * FROM student WHERE id = ?', [id]);
    if (results.length === 0) {
      return res.status(404).json({ error: 'Student not found' });
    }
    res.json(results[0]);
  } catch (error) {
    console.error('Error fetching student:', error.message);
    res.status(500).json({ error: 'Error fetching student' });
  }
});


//put




app.put('/student/:id', isAdmin,async (req, res) => {
  const id = req.params.id; // เปลี่ยนชื่อตัวแปรจาก sdCardID เป็น id
  const data = req.body;

  // Validate data (assuming data validation is needed)
  if (!data || typeof data !== 'object' || Object.keys(data).length === 0) {
    return res.status(400).json({ error: 'Invalid data' });
  }

  try {
    // Check if student with id exists
    const [existingStudent] = await conn.query('SELECT * FROM student WHERE id = ?', [id]); // เปลี่ยนชื่อของฟิลด์จาก sdCardID เป็น id
    if (existingStudent.length === 0) {
      return res.status(404).json({ error: 'Student not found' });
    }

    // Prepare fields and values for update
    const updateFields = Object.keys(data).map(key => `\`${key}\` = ?`).join(', ');
    const updateValues = Object.values(data);

    // Update student data
    const sql = `UPDATE student SET ${updateFields} WHERE id = ?`; // เปลี่ยนชื่อฟิลด์จาก sdCardID เป็น id
    const values = [...updateValues, id];
    const result = await conn.query(sql, values);
    if (result[0].affectedRows === 0) {
      return res.status(500).json({ error: 'Failed to update student' });
    }
    
    res.json({ message: 'Student updated successfully', id }); // เปลี่ยนชื่อตัวแปร sdCardID เป็น id
  } catch (error) {
    console.error('Error updating student:', error.message);
    res.status(500).json({ error: 'Error updating student' });
  }
});





//delete

app.delete('/student/:id',isAdmin, [
  param('id').isInt().withMessage('ID must be an integer').toInt(),
], async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  const id = req.params.id;

  try {
    const result = await conn.query('DELETE FROM student WHERE id = ?', [id]);
    if (result[0].affectedRows === 0) {
      return res.status(404).json({ error: 'Student not found' });
    }
    res.json({ message: 'Student deleted successfully', id });
  } catch (error) {
    console.error('Error deleting student:', error.message);
    res.status(500).json({ error: 'Error deleting student' });
  }
});





 
app.listen(port, async () => {
  // เรียกใช้ connectMySQL ตอน start server
  await connectMySQL()
  console.log(`Server started on port ${port}`)
})