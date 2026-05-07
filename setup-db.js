const mysql = require('mysql');
const fs = require('fs');
const path = require('path');

console.log('🚀 Database Setup Script');
console.log('========================\n');

// MySQL connection (without database selected yet)
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    multipleStatements: true
});

connection.connect((err) => {
    if (err) {
        console.error('❌ ERROR: Cannot connect to MySQL server');
        console.error('Make sure MySQL Server is running on localhost:3306');
        console.error('\nTo start MySQL:');
        console.error('1. Open Services (services.msc)');
        console.error('2. Find MySQL service');
        console.error('3. Right-click → Start\n');
        console.error('Error details:', err.message);
        process.exit(1);
    }

    console.log('✅ Connected to MySQL Server\n');

    // Step 1: Create database
    console.log('📁 Creating database "crowd_funding"...');
    connection.query('CREATE DATABASE IF NOT EXISTS crowd_funding', (err) => {
        if (err) {
            console.error('❌ Error creating database:', err.message);
            process.exit(1);
        }
        console.log('✅ Database created\n');

        // Step 2: Select database
        connection.changeUser({database: 'crowd_funding'}, (err) => {
            if (err) {
                console.error('❌ Error selecting database:', err.message);
                process.exit(1);
            }
            console.log('✅ Database selected\n');

            // Step 3: Read and execute SQL file
            const sqlFile = path.join(__dirname, 'crowd_funding.sql');
            console.log('📄 Reading SQL file from: ' + sqlFile);
            
            fs.readFile(sqlFile, 'utf8', (err, data) => {
                if (err) {
                    console.error('❌ Error reading SQL file:', err.message);
                    connection.end();
                    process.exit(1);
                }

                console.log('✅ SQL file read successfully\n');
                console.log('⏳ Importing database schema and data...');

                connection.query(data, (err) => {
                    if (err) {
                        console.error('❌ Error importing SQL:', err.message);
                        connection.end();
                        process.exit(1);
                    }

                    console.log('✅ Database imported successfully!\n');
                    console.log('📊 Verifying tables...');

                    connection.query('SHOW TABLES', (err, results) => {
                        if (err) {
                            console.error('❌ Error:', err.message);
                        } else {
                            console.log('✅ Tables in database:');
                            results.forEach(row => {
                                const tableName = Object.values(row)[0];
                                console.log('   - ' + tableName);
                            });
                        }

                        console.log('\n🎉 Database setup complete!\n');
                        console.log('You can now start your application:\n');
                        console.log('Terminal 1 - Backend:');
                        console.log('  cd api-node');
                        console.log('  npm install');
                        console.log('  node app.js\n');
                        console.log('Terminal 2 - Frontend:');
                        console.log('  cd crowd-funding-angular');
                        console.log('  npm install');
                        console.log('  npm start\n');

                        connection.end();
                    });
                });
            });
        });
    });
});
