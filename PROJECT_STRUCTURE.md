# Project Structure & Customization Guide

## Complete Project Structure

```
crowdfunding-platform/
│
├── api-node/                          # EXPRESS.JS BACKEND
│   ├── database/
│   │   └── index.js                   # MySQL connection config
│   ├── routes/                        # API route handlers
│   │   ├── campaigns.js               # Campaign CRUD operations
│   │   ├── users.js                   # User authentication & management
│   │   ├── donations.js               # Donation processing
│   │   └── ...
│   ├── uploads/                       # User uploaded files (images, documents)
│   ├── app.js                         # Main Express application
│   ├── stripepayment.js               # Stripe payment integration
│   ├── package.json                   # Node.js dependencies
│   └── .gitignore
│
├── crowd-funding-angular/              # ANGULAR 8 FRONTEND
│   ├── src/
│   │   ├── app/                       # Angular components, services, modules
│   │   │   ├── components/            # Reusable components (navbar, cards, etc)
│   │   │   ├── services/              # API services (HttpClient)
│   │   │   ├── models/                # TypeScript interfaces & classes
│   │   │   └── app.module.ts          # Main app module
│   │   ├── assets/                    # Images, styles, fonts
│   │   ├── environments/              # Environment config (dev, prod)
│   │   ├── index.html                 # HTML entry point
│   │   ├── main.ts                    # Application bootstrap
│   │   └── styles.css                 # Global styles
│   ├── e2e/                           # End-to-end tests
│   ├── angular.json                   # Angular CLI config
│   ├── package.json                   # npm dependencies
│   ├── tsconfig.json                  # TypeScript config
│   └── karma.conf.js                  # Unit test config
│
├── crowd_funding.sql                  # MySQL database dump
├── SETUP_GUIDE.md                     # Setup instructions (YOU ARE HERE)
├── DATABASE_SETUP.md                  # Database setup details
├── DEPLOYMENT_GUIDE.md                # Cloud deployment guide
├── README.md                          # Original project README
└── start-servers.bat                  # Quick start script (Windows)
```

---

## Backend Architecture (Express.js)

### API Endpoints Structure

```
http://localhost:3000/api/

/campaigns
  GET    /                    - List all campaigns
  POST   /                    - Create new campaign
  GET    /:id                 - Get campaign details
  PUT    /:id                 - Update campaign
  DELETE /:id                 - Delete campaign

/users
  POST   /register            - User registration
  POST   /login               - User login
  GET    /:id                 - Get user profile
  PUT    /:id                 - Update profile

/donations
  GET    /                    - List donations
  POST   /                    - Create donation
  GET    /:id                 - Get donation details

/upload
  POST   /                    - Upload file (image, document)
```

### Key Backend Files to Modify

| File | What to Change |
|------|-----------------|
| `database/index.js` | Database connection credentials |
| `routes/campaigns.js` | Campaign logic & queries |
| `routes/users.js` | User authentication & profiles |
| `app.js` | Add new endpoints, middleware |
| `stripepayment.js` | Stripe configuration & keys |

### Backend Dependencies Explained

```json
{
  "express": "Web framework for APIs",
  "mysql": "MySQL database driver",
  "cors": "Allow cross-origin requests (frontend to backend)",
  "body-parser": "Parse JSON request bodies",
  "jsonwebtoken": "JWT for user authentication",
  "multer": "Handle file uploads",
  "stripe": "Payment processing",
  "nodemailer": "Send emails",
  "uuid": "Generate unique IDs"
}
```

---

## Frontend Architecture (Angular 8)

### Component Structure

```
src/app/
├── components/
│   ├── header/               # Navigation bar
│   ├── footer/               # Footer
│   ├── campaign-list/        # Display all campaigns
│   ├── campaign-detail/      # Single campaign page
│   ├── campaign-form/        # Create/edit campaign
│   ├── donation-form/        # Donation checkout
│   ├── user-profile/         # User dashboard
│   ├── login/                # Login form
│   ├── register/             # Signup form
│   └── ...
│
├── services/
│   ├── api.service.ts        # HTTP calls to backend
│   ├── auth.service.ts       # Authentication logic
│   ├── campaign.service.ts   # Campaign data management
│   └── ...
│
├── models/
│   ├── campaign.model.ts     # Campaign interface
│   ├── user.model.ts         # User interface
│   ├── donation.model.ts     # Donation interface
│   └── ...
│
└── app.module.ts             # Main module
```

### How Frontend Communicates with Backend

```typescript
// In any component:
constructor(private apiService: ApiService) {}

ngOnInit() {
  // Get campaigns from backend
  this.apiService.getCampaigns().subscribe(
    (data) => {
      this.campaigns = data;  // Display data
    },
    (error) => {
      console.log('Error:', error);
    }
  );
}
```

### Key Frontend Files to Modify

| File | What to Change |
|------|-----------------|
| `components/` | UI layout & forms |
| `services/api.service.ts` | API endpoint URLs |
| `models/` | Data types & interfaces |
| `assets/` | Images, colors, fonts |
| `environments/environment.ts` | Backend API endpoint |

---

## Database Schema (MySQL)

### Main Tables

```sql
-- Users table
CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255),
  email VARCHAR(255) UNIQUE,
  password VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Campaigns table
CREATE TABLE campaigns (
  id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(255),
  description TEXT,
  target_amount DECIMAL(10,2),
  current_amount DECIMAL(10,2) DEFAULT 0,
  user_id INT,
  status ENUM('active', 'completed', 'failed'),
  created_at TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Donations table
CREATE TABLE donations (
  id INT PRIMARY KEY AUTO_INCREMENT,
  campaign_id INT,
  user_id INT,
  amount DECIMAL(10,2),
  donation_date TIMESTAMP,
  FOREIGN KEY (campaign_id) REFERENCES campaigns(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

---

## How Data Flows Through the Application

```
User (Frontend/Browser)
        ↓
   Angular UI
   (HTML/CSS/TS)
        ↓
   HTTP Request
   (GET/POST/PUT/DELETE)
        ↓
   Express.js Backend
   (Node.js)
        ↓
   Route Handler
   (campaigns.js, users.js, etc)
        ↓
   Business Logic
   (Validation, Processing)
        ↓
   MySQL Query
   (SELECT/INSERT/UPDATE/DELETE)
        ↓
   Database Response
        ↓
   JSON Response to Frontend
        ↓
   Angular Updates UI
        ↓
   User sees changes
```

---

## Common Customizations for Your Internship

### 1. Change Application Colors & Branding

**File:** `crowd-funding-angular/src/styles.css` or `src/app/components/*/component.css`

```css
/* Change primary color */
:root {
  --primary-color: #007bff;      /* Blue */
  --secondary-color: #6c757d;    /* Gray */
  --success-color: #28a745;       /* Green */
}
```

### 2. Add New Feature: Campaign Categories

**Backend (Node.js):**
```javascript
// api-node/routes/campaigns.js
router.get('/by-category/:category', (req, res) => {
  const query = 'SELECT * FROM campaigns WHERE category = ?';
  db.query(query, [req.params.category], (err, result) => {
    if (err) throw err;
    res.json(result);
  });
});
```

**Frontend (Angular):**
```typescript
// crowd-funding-angular/src/app/services/campaign.service.ts
getCampaignsByCategory(category: string) {
  return this.http.get(`/api/campaigns/by-category/${category}`);
}
```

### 3. Add New Table for Reviews/Comments

```sql
-- In crowd_funding.sql
CREATE TABLE reviews (
  id INT PRIMARY KEY AUTO_INCREMENT,
  campaign_id INT,
  user_id INT,
  rating INT (1-5),
  comment TEXT,
  created_at TIMESTAMP,
  FOREIGN KEY (campaign_id) REFERENCES campaigns(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);
```

### 4. Modify User Authentication

**Backend:** Update `routes/users.js` for additional validation
**Frontend:** Modify `components/login/` for different auth method

### 5. Add New API Endpoint

1. Create route in `api-node/routes/newfeature.js`
2. Import in `app.js`
3. Create service in `crowd-funding-angular/src/app/services/`
4. Use in component

---

## Testing Your Changes

### Backend Testing
```bash
# Check syntax
node -c api-node/app.js

# Start server
cd api-node
npm start
```

### Frontend Testing
```bash
# Check for errors
cd crowd-funding-angular
npm run lint

# Run tests
npm test

# Build for production
npm run build
```

---

## Performance Optimization Tips

### Frontend (Angular)
- Use lazy loading for routes
- Implement OnPush change detection
- Minimize HTTP requests
- Compress images

### Backend (Express)
- Add caching headers
- Use connection pooling for database
- Implement pagination for large datasets
- Add error handling & logging

### Database (MySQL)
- Add indexes on frequently queried columns
- Optimize queries with EXPLAIN
- Archive old data
- Set up backups

---

## Security Best Practices

1. **Passwords:** Hash before storing (use bcrypt)
2. **API Keys:** Never commit to GitHub, use environment variables
3. **SQL Injection:** Use parameterized queries (already done in project)
4. **CORS:** Restrict to your domain
5. **Input Validation:** Validate all user inputs
6. **HTTPS:** Always use in production

---

## Tips for Your Internship Presentation

✨ **Highlight:**
1. Full-stack development (frontend + backend + database)
2. Real-world features (payments, uploads, authentication)
3. Cloud deployment capability
4. Responsive design
5. Working payment integration

📊 **Show:**
1. Live working application
2. Admin dashboard
3. Multiple user roles
4. Payment flow
5. File upload feature

🎯 **Explain:**
1. How MEAN stack works
2. Database relationships
3. Authentication/authorization
4. API architecture
5. Deployment process

---

## Learning Resources

- **Angular:** https://angular.io/tutorial
- **Express:** https://expressjs.com/
- **MySQL:** https://www.w3schools.com/mysql/
- **REST APIs:** https://restfulapi.net/
- **Web Dev:** https://developer.mozilla.org/

---

## Project Features to Highlight

✅ User Registration & Authentication (JWT)
✅ Create & Manage Campaigns
✅ Donate to Campaigns (Stripe)
✅ File Upload (Images)
✅ Search & Filter
✅ User Dashboard
✅ Real-time Updates
✅ Responsive Design
✅ Database Management
✅ Email Notifications

---

## Quick Reference: Key Commands

```bash
# Backend
cd api-node
npm install                 # Install dependencies
node app.js                 # Start server
npm test                    # Run tests

# Frontend
cd crowd-funding-angular
npm install                 # Install dependencies
npm start                   # Start dev server
npm run build              # Build for production
npm test                   # Run tests
npm run lint               # Check code quality

# Database
mysql -u root -p           # Connect to MySQL
USE crowd_funding;         # Select database
SHOW TABLES;              # List tables
SELECT * FROM campaigns;  # View data
```

---

## Next Steps

1. ✅ Setup locally (follow SETUP_GUIDE.md)
2. ✅ Understand the code structure
3. ✅ Make small modifications
4. ✅ Add new features
5. ✅ Deploy to cloud
6. ✅ Share live link with internship team

**Good luck! You've got a great foundation to build upon! 🚀**
