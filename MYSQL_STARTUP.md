# MySQL Server Setup - Windows Services Method

## Option 1: Start MySQL using Windows Services (RECOMMENDED)

### Step 1: Open Services Application
- Press: `Windows Key + R`
- Type: `services.msc`
- Press: `Enter`

### Step 2: Find and Start MySQL
- Look for a service named "MySQL*" (like "MySQL80" or "MySQL97")
- Right-click on it
- Click **"Start"**
- Wait for status to change to "Running"

### Step 3: Verify MySQL is Running
Open PowerShell and run:
```bash
$env:Path += ";C:\Program Files\MySQL\MySQL Workbench 8.0"
mysql -u root -e "SHOW DATABASES;"
```

You should see output without errors.

### Step 4: Run Database Setup Script
```bash
cd C:\Users\gaurv\OneDrive\Desktop\Crowdfunding\crowdfunding-platform
node setup-db.js
```

This will:
- Create the `crowd_funding` database
- Import all tables and data
- Verify everything is set up

---

## Option 2: Use MySQL Shell (Alternative)

If you have MySQL Shell installed:
1. Press `Windows Key + R`
2. Type: `mysqlsh`
3. Run:
```sql
\connect root@localhost
CREATE DATABASE crowd_funding;
\use crowd_funding
\source crowd_funding.sql
\exit
```

---

## If MySQL Service Doesn't Exist

Run this in PowerShell (as Administrator):
```bash
"C:\Program Files\MySQL\MySQL Server 9.7\bin\mysqld.exe" --install MySQL97
net start MySQL97
```

Then follow Steps 3-4 above.

---

## Troubleshooting

**Error: MySQL service not found in Services**
- Go to: `C:\Program Files\MySQL`
- Check which folder is there (MySQL Server 8.0, 9.7, etc.)
- Use that version name

**Error: Can't connect to localhost:3306**
- Verify service is "Running" (not stopped)
- Wait 10 seconds after starting service
- Try again

**Error: Permission denied**
- Open PowerShell as Administrator
- Run commands again

---

After MySQL is running, run:
```bash
node setup-db.js
```

Then proceed with starting your application!
