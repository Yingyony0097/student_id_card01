const express = require('express')
const app = express()
const bodyParser = require('body-parser')
const mysql = require('mysql2/promise')

app.use(bodyParser.json())

let conn = null

// function connectMySQL
const connectMySQL = async () => {
  conn = await mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'e_student'
  })
}


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
  const data = req.body

  try {
    const result = await conn.query('INSERT INTO student SET ?', data)
    const studentId = result[0].insertId
    res.status(201).json({ message: 'student created successfully', studentId })
  } catch (error) {
    console.error('Error creating student:', error.message)
    res.status(500).json({ error: 'Error creating student' })
  }
})


//getid

app.get('/student/:sdCardID', async (req, res) => {
  const sdCardID = req.params.sdCardID

  try {
    let [results] = await conn.query('SELECT * FROM student WHERE sdCardID = ?', [sdCardID])
    if (results.length === 0) {
      return res.status(404).json({ error: 'student not found' })
    }
    res.json(results[0])
  } catch (error) {
    console.error('Error fetching student:', error.message)
    res.status(500).json({ error: 'Error fetching student' })
  }
})

//put

app.put('/student/:sdCardID', async (req, res) => {
  const sdCardID = req.params.sdCardID
  const data = req.body

  try {
    const result = await conn.query('UPDATE student SET ? WHERE sdCardID = ?', [data, sdCardID])
    if (result[0].affectedRows === 0) {
      return res.status(404).json({ error: 'student not found' })
    }
    res.json({ message: 'student updated successfully', studentId: sdCardID })
  } catch (error) {
    console.error('Error updating student:', error.message)
    res.status(500).json({ error: 'Error updating student' })
  }
})

//delete
app.delete('/student/:sdCardID', async (req, res) => {
  const sdCardID = req.params.sdCardID

  try {
    const result = await conn.query('DELETE FROM student WHERE sdCardID = ?', [sdCardID])
    if (result[0].affectedRows === 0) {
      return res.status(404).json({ error: 'student not found' })
    }
    res.json({ message: 'student deleted successfully', studentId: sdCardID })
  } catch (error) {
    console.error('Error deleting student:', error.message)
    res.status(500).json({ error: 'Error deleting student' })
  }
})

 
app.listen(8000, async () => {
  // เรียกใช้ connectMySQL ตอน start server
  await connectMySQL()
  console.log('Server started on port 8000')
})