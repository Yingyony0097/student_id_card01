const mysql = require('mysql2/promise');

const dbConfig = {
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'e_student',
  port: '3306'
};

const pool = mysql.createPool(dbConfig);

module.exports = pool;




