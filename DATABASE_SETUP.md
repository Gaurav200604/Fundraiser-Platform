# Database Setup Instructions for Crowdfunding Platform

## Quick Database Setup (2-3 minutes)

### Option 1: Using MySQL Command Line (Recommended)

**Step 1: Open Command Prompt/PowerShell**
- Press `Win + R`
- Type `cmd` and press Enter

**Step 2: Connect to MySQL**
```bash
mysql -u root -p
```
- When prompted for password, press `Enter` (assuming default empty password)

**Step 3: Create Database**
```sql
CREATE DATABASE crowd_funding;
```

**Step 4: Exit MySQL**
```sql
exit
```

**Step 5: Import Database Dump**
In Command Prompt, navigate to the crowdfunding-platform folder:
```bash
cd C:\Users\gaurv\OneDrive\Desktop\Crowdfunding\crowdfunding-platform
mysql -u root -p crowd_funding < crowd_funding.sql
```
- Press `Enter` at password prompt

**Step 6: Verify**
```bash
mysql -u root -p -e "USE crowd_funding; SHOW TABLES;"
```
- Press `Enter` at password prompt
- You should see a list of tables like: campaigns, users, donations, etc.

---

### Option 2: Using MySQL Workbench (GUI)

**Step 1: Open MySQL Workbench**

**Step 2: Connect to Local Instance**
- Double-click on your local MySQL connection

**Step 3: Create Database**
- Right-click on empty area → Create Schema
- Name: `crowd_funding`
- Click Apply

**Step 4: Import SQL File**
- File → Open SQL Script
- Select `crowd_funding.sql`
- Execute (or press Ctrl+Shift+Enter)

---

### Option 3: Using Git Bash or WSL

```bash
# Navigate to project folder
cd ~/OneDrive/Desktop/Crowdfunding/crowdfunding-platform

# Create database
mysql -u root -p -e "CREATE DATABASE crowd_funding;"

# Import data
mysql -u root -p crowd_funding < crowd_funding.sql

# Verify
mysql -u root -p -e "USE crowd_funding; SELECT COUNT(*) as table_count FROM information_schema.tables WHERE table_schema='crowd_funding';"
```

---

## Troubleshooting Database Issues

### Issue: "ERROR 1049 - Unknown database 'crowd_funding'"
**Solution:**
- The database wasn't created
- Run: `mysql -u root -p -e "CREATE DATABASE crowd_funding;"`
- Then import the SQL file

### Issue: "ERROR 2003 - Can't connect to MySQL server"
**Solution:**
- MySQL server is not running
- **Windows:**
  - Open Services (services.msc)
  - Find MySQL service
  - Right-click → Start
- Or restart: `net start MySQL80` (command prompt as admin)

### Issue: "ERROR 1045 - Access denied for user 'root'"
**Solution:**
- Password is different from expected
- Edit `api-node/database/index.js`:
  ```javascript
  password: 'YOUR_ACTUAL_PASSWORD'
  ```

### Issue: SQL file won't import (encoding issues)
**Solution:**
```bash
# Try with explicit charset
mysql -u root -p crowd_funding < crowd_funding.sql --default-character-set=utf8mb4
```

### Issue: "Tables don't look right after import"
**Solution:**
- Drop and recreate:
  ```bash
  mysql -u root -p -e "DROP DATABASE crowd_funding; CREATE DATABASE crowd_funding;"
  mysql -u root -p crowd_funding < crowd_funding.sql
  ```

---

## Verify Database is Working

After setup, verify with this command:

```bash
mysql -u root -p crowd_funding -e "
SELECT 'Users' as table_name, COUNT(*) as count FROM users
UNION
SELECT 'Campaigns', COUNT(*) FROM campaigns
UNION
SELECT 'Donations', COUNT(*) FROM donations
UNION
SELECT 'Reviews', COUNT(*) FROM reviews;
"
```

You should see output showing table counts.

---

## Next Steps

Once database is set up:

1. **Backend**
   ```bash
   cd api-node
   npm install
   node app.js
   ```

2. **Frontend**
   ```bash
   cd crowd-funding-angular
   npm install
   npm start
   ```

3. **Access Application**
   - Open browser to `http://localhost:4200`

---

## Database Connection Details

Once set up, the backend connects using:
- **Host:** localhost
- **Port:** 3306 (default)
- **User:** root
- **Password:** (empty)
- **Database:** crowd_funding

All in file: `api-node/database/index.js`

---

## Need Help?

- Check MySQL is running
- Verify credentials in `api-node/database/index.js`
- Review error messages carefully
- Try Option 2 (MySQL Workbench) if command line doesn't work
