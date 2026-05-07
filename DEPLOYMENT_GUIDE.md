# Deployment Guide - Crowdfunding Platform

## Overview

Once your project works locally, you can deploy it to the cloud. This guide covers multiple platforms.

---

## Deployment Architecture

**Frontend (Angular):**
- Deployed on: Static hosting (AWS S3, Azure Static Web Apps, Netlify, Vercel)
- or on same server as backend

**Backend (Express + MySQL):**
- Deployed on: App servers (Heroku, AWS EC2, Azure App Service)
- Database: Cloud MySQL (Azure Database, AWS RDS, or managed MySQL)

---

## Option 1: Heroku (Easiest - Free Tier Available)

### Prerequisites
- Heroku account (free at https://www.heroku.com/)
- Heroku CLI installed

### Step 1: Backend Deployment

```bash
# Login to Heroku
heroku login

# Create Heroku app
heroku create crowdfunding-api

# Set up MySQL database (Heroku doesn't include free MySQL, use JawsDB)
heroku addons:create jawsdb:kitefin

# Get database URL
heroku config -a crowdfunding-api

# Update database connection
# Modify api-node/database/index.js to use JAWSDB_URL
```

### Step 2: Update for Production

Create `api-node/Procfile`:
```
web: node app.js
```

Update database URL in `api-node/database/index.js`:
```javascript
const db = mysql.createConnection(process.env.JAWSDB_URL);
```

### Step 3: Deploy Backend

```bash
cd api-node
git init
git add .
git commit -m "initial"
heroku git:remote -a crowdfunding-api
git push heroku main
```

### Step 4: Frontend Deployment

Build Angular:
```bash
cd crowd-funding-angular
npm run build
```

Deploy built files to Netlify or Vercel:
```bash
# Using Netlify CLI
npm install -g netlify-cli
netlify deploy --prod --dir=dist/crowd-funding-angular
```

---

## Option 2: Azure (Recommended for Enterprise)

### Prerequisites
- Azure account (free credits available)
- Azure CLI installed

### Step 1: Create Resources

```bash
# Login
az login

# Create resource group
az group create --name crowdfunding-rg --location eastus

# Create App Service Plan
az appservice plan create --name crowdfunding-plan --resource-group crowdfunding-rg --sku B1 --is-linux

# Create MySQL Database
az mysql server create --resource-group crowdfunding-rg --name crowdfunding-db --location eastus --admin-user dbadmin --admin-password YourPassword123!
```

### Step 2: Backend Deployment

```bash
cd api-node

# Create web app
az webapp create --resource-group crowdfunding-rg --plan crowdfunding-plan --name crowdfunding-api --runtime "NODE:14"

# Configure connection
az webapp config appsettings set --resource-group crowdfunding-rg --name crowdfunding-api --settings DB_HOST=crowdfunding-db.mysql.database.azure.com DB_USER=dbadmin DB_PASSWORD=YourPassword123! DB_NAME=crowd_funding

# Deploy
az webapp up --resource-group crowdfunding-rg --name crowdfunding-api --runtime "node|14"
```

### Step 3: Frontend Deployment

```bash
cd crowd-funding-angular
npm run build

# Deploy to Static Web Apps
az staticwebapp create --name crowdfunding-ui --source . --location eastus --resource-group crowdfunding-rg
```

---

## Option 3: AWS (Most Scalable)

### Prerequisites
- AWS account
- AWS CLI configured

### Step 1: Backend on EC2

```bash
# Launch EC2 instance (Ubuntu 20.04 LTS)
# SSH into instance
ssh -i your-key.pem ubuntu@instance-ip

# Install dependencies
sudo apt-get update
sudo apt-get install nodejs npm mysql-client git

# Clone your repo
git clone https://github.com/yourname/crowdfunding-platform.git
cd crowdfunding-platform/api-node

# Install and start
npm install
node app.js
```

### Step 2: Database on RDS

```bash
# Create RDS MySQL instance
aws rds create-db-instance \
  --db-instance-identifier crowdfunding-db \
  --db-instance-class db.t2.micro \
  --engine mysql \
  --master-username admin \
  --master-user-password YourPassword123!
```

### Step 3: Frontend on S3 + CloudFront

```bash
cd crowd-funding-angular
npm run build

# Create S3 bucket
aws s3 mb s3://crowdfunding-ui

# Upload built files
aws s3 sync dist/crowd-funding-angular s3://crowdfunding-ui

# Create CloudFront distribution (optional for HTTPS)
```

---

## Option 4: DigitalOcean (Budget-Friendly)

### Prerequisites
- DigitalOcean account
- App Platform or Droplet

### Using App Platform (Easier)

```bash
# Create app.yaml in root:
name: crowdfunding
services:
- name: backend
  github:
    repo: yourname/crowdfunding-platform
    branch: main
  build_command: cd api-node && npm install
  run_command: cd api-node && node app.js
  source_dir: api-node
  
- name: frontend
  github:
    repo: yourname/crowdfunding-platform
    branch: main
  build_command: cd crowd-funding-angular && npm install && npm run build
  source_dir: crowd-funding-angular

databases:
- name: crowdfunding-db
  engine: MYSQL
  version: "8"
```

Push to DigitalOcean:
- Connect GitHub repo
- Select app.yaml
- Deploy

---

## Environment Variables to Configure

For all deployments, set these environment variables:

```
# Database
DB_HOST=your-db-host
DB_PORT=3306
DB_USER=admin
DB_PASSWORD=your-password
DB_NAME=crowd_funding

# Stripe (for payments)
STRIPE_SECRET_KEY=sk_test_...
STRIPE_PUBLIC_KEY=pk_test_...

# Email
EMAIL_SERVICE_USER=your-email@gmail.com
EMAIL_SERVICE_PASSWORD=your-app-password

# CORS
FRONTEND_URL=https://your-frontend-domain.com
```

---

## Production Checklist

Before deploying to production:

- [ ] Update database credentials (not hardcoded)
- [ ] Use HTTPS certificates (SSL/TLS)
- [ ] Configure CORS properly
- [ ] Add database backups
- [ ] Set up error logging
- [ ] Configure monitoring/alerts
- [ ] Test all payment flows
- [ ] Test file uploads
- [ ] Document API endpoints
- [ ] Set up CI/CD pipeline

---

## CI/CD Pipeline (Automated Deployment)

### GitHub Actions Example

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to Production

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Setup Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '14'
      
      - name: Install & Test Backend
        run: |
          cd api-node
          npm install
          npm test
      
      - name: Build Frontend
        run: |
          cd crowd-funding-angular
          npm install
          npm run build
      
      - name: Deploy to Production
        run: |
          # Add your deployment commands here
```

---

## Post-Deployment Testing

After deployment:

1. **Test API Endpoints**
   ```bash
   curl https://your-backend-domain/api/campaigns
   ```

2. **Test Frontend**
   - Open https://your-frontend-domain
   - Test login, create campaign, donation flow

3. **Monitor Errors**
   - Check server logs
   - Monitor database connections
   - Check file uploads

---

## Domain & DNS

1. Purchase domain (GoDaddy, Namecheap, etc.)
2. Point to your deployment:
   - Frontend: Point to CDN/hosting service
   - Backend: Point to app server IP or domain

Example DNS records:
```
app.crowdfunding.com → your-heroku-app.herokuapp.com
api.crowdfunding.com → your-backend-ip
```

---

## Cost Estimation

| Service | Estimated Monthly Cost |
|---------|------------------------|
| Heroku (Backend) | $7-50 |
| Netlify (Frontend) | Free-$19 |
| Azure (All-in-one) | $10-50 |
| AWS (All-in-one) | $5-50 |
| DigitalOcean | $5-12 |

---

## Common Deployment Issues

### Issue: Database Connection Fails
- Verify connection string
- Check firewall rules
- Ensure database exists

### Issue: Frontend Can't Reach Backend
- Update API endpoint URL in frontend
- Check CORS settings in backend
- Verify backend is running

### Issue: File Uploads Not Working
- Check file permissions on server
- Verify upload directory exists
- Check disk space

### Issue: Payment (Stripe) Not Working
- Update Stripe keys from production
- Verify webhook URLs
- Check payment endpoint

---

## Recommended Deployment Path

1. **Start with:** Heroku (fast, easy)
2. **Scale to:** Azure or AWS (more control)
3. **Use:** GitHub Actions for CI/CD
4. **Add:** CDN for frontend (Cloudflare)
5. **Monitor:** With Datadog or New Relic

---

## Support Resources

- Heroku Docs: https://devcenter.heroku.com/
- Azure Docs: https://docs.microsoft.com/azure/
- AWS Docs: https://docs.aws.amazon.com/
- DigitalOcean Docs: https://docs.digitalocean.com/

---

**Happy Deploying! 🚀**
