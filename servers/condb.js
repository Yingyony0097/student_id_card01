// const express = require('express')
// const app = express()
// const bodyParser = require('body-parser')
// const mysql = require('mysql2/promise')

// // Route handler for getting all users
// app.get('/users', (req, res) => {
//   mysql.createConnection({
//     host: 'localhost',
//     user: 'root',
//     password: '',
//     database: 'e_student'
//   }).then((conn) => {
//     // สิ่งนี้เราเรียกกันว่า promise
//     conn
//     .query('SELECT * FROM student')
//     .then((results) => {
//       res.json(results[0])
//     })
//     .catch((error) => {
//       console.error('Error fetching users:', error.message)
//       res.status(500).json({ error: 'Error fetching users' })
//     })
//   })
// })