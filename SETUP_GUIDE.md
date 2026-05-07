# Crowdfunding Platform - Complete Setup Guide

## Project Overview
This is a **MEAN Stack** crowdfunding platform with:
- **M** - MongoDB/MySQL (using MySQL in this project)
- **E** - Express.js (Node.js backend)
- **A** - Angular 8 (Frontend)
- **N** - Node.js (JavaScript runtime)

**Project Structure:**
```
crowdfunding-platform/
├── api-node/                 # Express.js backend (runs on port 3000)
├── crowd-funding-angular/    # Angular 8 frontend (runs on port 4200)
├── crowd_funding.sql         # MySQL database dump
└── README.md
```

---

## Prerequisites

Before starting, ensure you have installed:

1. **Node.js & npm** (v12 or higher)
   - Download: https://nodejs.org/
   - Verify: `node --version` & `npm --version`

2. **MySQL Server** (v5.7 or higher)
   - Download: https://dev.mysql.com/downloads/mysql/
   - Verify: `mysql --version`

3. **Git** (optional, already cloned)

4. **Text Editor/IDE**
   - VS Code: https://code.visualstudio.com/

---

## Step 1: Database Setup

### 1.1 Create MySQL Database

1. Open MySQL Command Line or MySQL Workbench
2. Create a new database:
   ```sql
   CREATE DATABASE crowd_funding;
   ```

3. Import the database dump:
   ```bash
   mysql -u root -p crowd_funding < crowd_funding.sql
   ```
   - When prompted for password, press Enter (empty password by default)

### 1.2 Verify Database Connection
```bash
mysql -u root -p crowd_funding
```
Press Enter at password prompt, then verify tables:
```sql
SHOW TABLES;
```

---

## Step 2: Backend Setup (Express.js API)

### 2.1 Install Dependencies

Navigate to backend folder:
```bash
cd api-node
npm install
```

**Dependencies installed:**
- express - Web framework
- cors - Cross-Origin Resource Sharing
- mysql - Database driver
- multer - File uploads
- jsonwebtoken - Authentication
- stripe - Payment processing
- nodemailer - Email notifications
- uuid - Unique ID generation

### 2.2 Database Configuration

The backend connects to MySQL with these credentials (in `api-node/database/index.js`):
```
Host: localhost
User: root
Password: (empty)
Database: crowd_funding
```

**If your MySQL has a different password:**
Edit `api-node/database/index.js`:
```javascript
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'YOUR_PASSWORD',  // Update here
    database: 'crowd_funding'
});
```

### 2.3 Start Backend Server

```bash
node app.js
```

**Expected output:**
```
Server started on port 3000
MySql Connected...
```

✅ Backend is now running at `http://localhost:3000`

---

## Step 3: Frontend Setup (Angular 8)

### 3.1 Install Dependencies

Open a new terminal and navigate to frontend folder:
```bash
cd crowd-funding-angular
npm install
```

**Dependencies installed:**
- @angular/core, @angular/common, etc. - Angular framework
- rxjs - Reactive programming library
- ngx-slick-carousel - Carousel component
- @stripe/stripe-js - Stripe payment integration
- xlsx - Excel file handling

### 3.2 Configure Backend API URL

The frontend needs to know where the backend is running. Check the API configuration in the `src` folder (if needed):

Default Backend URL: `http://localhost:3000/api`

### 3.3 Start Frontend Server

```bash
npm start
```

Or use:
```bash
ng serve
```

**Expected output:**
```
✔ Compiled successfully.
⠙ Optimizing and bundling application for production...

Application bundle generation complete. [X.XXX seconds]

Initial Chunk Files   | Names         |      Size
vendor.js             | vendor        |   X.XX MB
polyfills.js          | polyfills     |   X.XX kB
main.js               | main          |   X.XX MB
styles.css            | styles        |   X.XX kB

Application bundle generation complete.

** Angular Live Development Server is listening on localhost:4200 **
```

✅ Frontend is now running at `http://localhost:4200`

---

## Step 4: Verify Everything Works

1. **Open your browser** and navigate to: `http://localhost:4200`
2. You should see the crowdfunding platform homepage
3. Test basic functionality:
   - Browse crowdfunding campaigns
   - Create a new campaign (if registration works)
   - Try making a donation

---

## Running Both Servers (Quick Reference)

### Terminal 1 - Backend
```bash
cd api-node
npm install
node app.js
```

### Terminal 2 - Frontend
```bash
cd crowd-funding-angular
npm install
npm start
```

---

## Troubleshooting

### Issue: MySQL Connection Error
**Solution:**
- Ensure MySQL server is running
- Check credentials in `api-node/database/index.js`
- Verify database exists: `mysql -u root -p -e "SHOW DATABASES;"`

### Issue: Port 3000 or 4200 Already in Use
**Solution:**
```bash
# Find process using port
netstat -ano | findstr :3000

# Kill process (replace PID with actual process ID)
taskkill /PID <PID> /F
```

### Issue: npm install fails
**Solution:**
```bash
# Clear npm cache
npm cache clean --force

# Try install again
npm install
```

### Issue: Angular build errors
**Solution:**
```bash
# Clear Angular cache
rm -rf .angular/cache
rm -rf node_modules
npm install
npm start
```

---

## Deployment Options

Once everything works locally, you can deploy to:

1. **Heroku** (Free tier)
2. **AWS** (EC2, Elastic Beanstalk)
3. **Azure** (App Service)
4. **Google Cloud** (Cloud Run, App Engine)
5. **DigitalOcean** (Droplets, Apps)

Basic deployment setup will be provided in separate guide.

---

## Key Files to Modify

| File | Purpose |
|------|---------|
| `api-node/database/index.js` | MySQL connection settings |
| `api-node/app.js` | Backend server configuration |
| `crowd-funding-angular/src/environments/environment.ts` | Frontend API endpoint |
| `crowd_funding.sql` | Database schema and initial data |

---

## Project Features

- ✅ User Authentication (JWT)
- ✅ Campaign Creation & Management
- ✅ Donation Processing (Stripe)
- ✅ File Uploads (Images, Documents)
- ✅ Email Notifications
- ✅ User Dashboard
- ✅ Campaign Browsing & Filtering
- ✅ Payment Integration
- ✅ Responsive UI (Angular Material/Bootstrap)

---

## Common NPM Commands

```bash
# Install dependencies
npm install

# Start development server
npm start

# Build for production
npm run build

# Run tests
npm test

# Check for code issues
npm run lint
```

---

## Support & Learning

- **Angular Documentation**: https://angular.io/docs
- **Express.js Guide**: https://expressjs.com/
- **MySQL Docs**: https://dev.mysql.com/doc/
- **Stripe API**: https://stripe.com/docs/api

---

## Notes for Your Internship

✨ **Customization Tips:**
- The Angular version used is 8 (older, but widely used)
- You can upgrade components gradually as you learn
- Start by understanding the existing code structure
- Document any changes you make
- Create your own features on top of this foundation

🎓 **Learning Path:**
1. Understand the current project structure
2. Modify UI components in Angular
3. Add new features to backend APIs
4. Deploy to cloud platform
5. Show the live deployed URL to your internship team

---

## Quick Start Checklist

- [ ] MySQL installed and running
- [ ] Database created (`crowd_funding`)
- [ ] Database imported from `crowd_funding.sql`
- [ ] Backend dependencies installed (`npm install` in api-node)
- [ ] Backend running (`node app.js` on port 3000)
- [ ] Frontend dependencies installed (`npm install` in crowd-funding-angular)
- [ ] Frontend running (`npm start` on port 4200)
- [ ] Application accessible at `http://localhost:4200`
- [ ] Tested basic functionality

---

**You're all set!** 🚀

For questions or issues, check the troubleshooting section above.
