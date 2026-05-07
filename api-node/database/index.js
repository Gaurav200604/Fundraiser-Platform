const mysql = require('mysql2');

// Create connection
const db = mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'crowd_funding'
});

// Connect 
db.connect((err) => {
    if (err) {
        throw err;
    }
    console.log('MySql Connected...');
});

module.exports = db;