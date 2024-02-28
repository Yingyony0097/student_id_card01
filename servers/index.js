const express = require('express')
const app = express()
const bodyParser = require('body-parser')
const mysql = require('mysql2/promise')
const { body, param, validationResult } = require('express-validator');
const bcrypt = require('bcrypt');

app.use(bodyParser.json())

let conn = null

// function connectMySQL
const connectMySQL = async () => {
  try {
    conn = await mysql.createConnection({
      host: 'localhost',
      user: 'root',
      password: '',
      database: 'e_student',
      port: '3306'
    });

    console.log('Connected to MySQL database');
  } catch (error) {
    console.error('Error connecting to MySQL database:', error.message);
  }
}

connectMySQL();


//get

app.get('/student', async (req, res) => {
  try {
    let results = await conn.query('SELECT * FROM student')
    res.json(results[0])
  } catch (error) {
    console.error('Error fetching student:', error.message)
    res.status(500).json({ error: 'Error fetching student' })
  }
})

//post



app.post('/student', async (req, res) => {
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




app.put('/student/:id', async (req, res) => {
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

app.delete('/student/:id', [
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

 
app.listen(8000, async () => {
  // เรียกใช้ connectMySQL ตอน start server
  await connectMySQL()
  console.log('Server started on port 8000')
})