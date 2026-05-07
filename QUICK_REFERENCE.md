# Quick Reference Cheat Sheet

## 📋 First-Time Setup (Copy-Paste Commands)

### 1. Database Setup (Run Once)
```bash
# Open Command Prompt or PowerShell and run:
mysql -u root -p -e "CREATE DATABASE crowd_funding;"
mysql -u root -p crowd_funding < crowd_funding.sql
```
Press `Enter` at password prompt (no password)

### 2. Backend Setup (Run Once)
```bash
cd C:\Users\gaurv\OneDrive\Desktop\Crowdfunding\crowdfunding-platform\api-node
npm install
```

### 3. Frontend Setup (Run Once)
```bash
cd C:\Users\gaurv\OneDrive\Desktop\Crowdfunding\crowdfunding-platform\crowd-funding-angular
npm install
```

---

## 🚀 Daily Startup (Every Time You Work)

### Terminal 1 - Backend
```bash
cd C:\Users\gaurv\OneDrive\Desktop\Crowdfunding\crowdfunding-platform\api-node
node app.js
```
**Expected:** `Server started on port 3000` + `MySql Connected...`

### Terminal 2 - Frontend
```bash
cd C:\Users\gaurv\OneDrive\Desktop\Crowdfunding\crowdfunding-platform\crowd-funding-angular
npm start
```
**Expected:** Frontend opens at `http://localhost:4200`

### Or Use Quick Start Script
```bash
# Windows - Double-click:
start-servers.bat

# OR PowerShell:
powershell -ExecutionPolicy Bypass -File start-servers.ps1
```

---

## 🔗 Access Points

| Service | URL | Port |
|---------|-----|------|
| Frontend | http://localhost:4200 | 4200 |
| Backend API | http://localhost:3000/api | 3000 |
| Database | localhost | 3306 |

---

## 📁 Important Files to Edit

| Path | Purpose | When to Edit |
|------|---------|--------------|
| `api-node/database/index.js` | Database credentials | Change MySQL password |
| `api-node/app.js` | Backend server config | Add new routes |
| `crowd-funding-angular/src/environments/environment.ts` | Backend URL | Change API endpoint |
| `crowd-funding-angular/src/app/` | UI components | Modify design/features |
| `crowd_funding.sql` | Database schema | Add new tables |

---

## 🛠️ Common Tasks

### Task: Update Database Password
**File:** `api-node/database/index.js`
```javascript
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'your_password',  // ← Change here
    database: 'crowd_funding'
});
```

### Task: Change Backend URL in Frontend
**File:** `crowd-funding-angular/src/environments/environment.ts`
```typescript
export const environment = {
  production: false,
  apiURL: 'http://localhost:3000/api'  // ← Change here
};
```

### Task: Add CORS for Deployment
**File:** `api-node/app.js`
```javascript
app.use(cors({
  origin: 'https://your-domain.com',  // ← Add your domain
  credentials: true
}));
```

### Task: Change Application Title
**File:** `crowd-funding-angular/src/index.html`
```html
<title>My Crowdfunding Platform</title>  <!-- Change title here -->
```

---

## 🐛 Quick Troubleshooting

| Problem | Solution |
|---------|----------|
| Backend won't start | `mysql -u root -p -e "SHOW DATABASES;"` to check MySQL |
| Port 3000 in use | `netstat -ano \| findstr :3000` then `taskkill /PID <PID> /F` |
| Frontend won't load | Clear cache: `Ctrl+Shift+Delete` in browser |
| MySQL won't connect | Check: `mysql -u root -p` can you connect? |
| npm install fails | `npm cache clean --force` then `npm install` |
| Changes not showing | Hard refresh: `Ctrl+F5` in browser |

---

## 📝 Common npm Commands

```bash
# Frontend commands (run in crowd-funding-angular folder)
npm start              # Start dev server (port 4200)
npm run build          # Build for production
npm test               # Run unit tests
npm run lint           # Check code quality

# Backend commands (run in api-node folder)
node app.js            # Start server (port 3000)
npm install            # Install dependencies
```

---

## 🗄️ Common SQL Commands

```sql
-- Connect
mysql -u root -p
USE crowd_funding;

-- View data
SHOW TABLES;
SELECT * FROM campaigns;
SELECT * FROM users;
SELECT * FROM donations;

-- Count records
SELECT COUNT(*) FROM campaigns;
SELECT COUNT(*) FROM users;

-- Find specific record
SELECT * FROM campaigns WHERE id = 1;
SELECT * FROM users WHERE email = 'test@example.com';

-- Update record
UPDATE campaigns SET title = 'New Title' WHERE id = 1;

-- Delete record
DELETE FROM campaigns WHERE id = 1;

-- Exit
exit
```

---

## 🔐 Database Credentials

| Setting | Value |
|---------|-------|
| Host | localhost |
| Port | 3306 |
| Username | root |
| Password | (empty) |
| Database | crowd_funding |

---

## 📂 Key Project Folders

```
crowdfunding-platform/
├── api-node/                 # Backend
│   ├── routes/              # API endpoints
│   └── database/            # DB config
├── crowd-funding-angular/    # Frontend
│   └── src/app/             # Components & services
└── SETUP_GUIDE.md           # Full setup instructions
```

---

## ☁️ Deployment One-Liner (After Setup)

### Heroku (Free)
```bash
# Install Heroku CLI first, then:
heroku login
heroku create your-app-name
git push heroku main
```

### Netlify (Frontend - Free)
```bash
npm install -g netlify-cli
cd crowd-funding-angular
npm run build
netlify deploy --prod --dir=dist/crowd-funding-angular
```

---

## 🎯 To Show Your Internship Team

✅ Live app at: `http://localhost:4200`
✅ Show these features:
- User registration & login
- Browse campaigns
- Create new campaign
- Make a donation
- Upload images
- User dashboard

✅ Code structure:
- Point to frontend components
- Point to backend API
- Show database tables

✅ Deployment:
- Share live link (after deploying)

---

## 📚 Read These Files First

1. `SETUP_GUIDE.md` - Complete setup
2. `DATABASE_SETUP.md` - Database only
3. `PROJECT_STRUCTURE.md` - Code organization
4. `DEPLOYMENT_GUIDE.md` - Cloud deployment
5. This file - Quick reference

---

## 💡 Pro Tips

1. **Always start MySQL first** before starting backend
2. **Use Chrome DevTools** (F12) to debug frontend
3. **Check console errors** if something breaks
4. **Commit code** frequently to Git
5. **Comment your changes** so internship team knows what you did
6. **Test locally first** before deploying
7. **Keep credentials in .env** not in code (later upgrade)
8. **Use meaningful names** for commits and branches

---

## 🆘 Still Stuck?

**Backend won't start?**
→ Check SETUP_GUIDE.md step by step

**Frontend blank?**
→ Open browser console (F12) and check errors

**Database issues?**
→ Check DATABASE_SETUP.md troubleshooting

**Deployment questions?**
→ Check DEPLOYMENT_GUIDE.md for your platform

---

## 🚀 You're Ready!

1. ✅ Database set up
2. ✅ Backend installed
3. ✅ Frontend installed
4. ✅ All servers running
5. ✅ App accessible at http://localhost:4200

**Start building! Good luck! 🎉**

---

*Last updated: May 2026*
*MEAN Stack Crowdfunding Platform*
