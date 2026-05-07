# Crowdfunding Platform

Reward-based crowdfunding platform for creators and backers built with Angular, Node.js, Express, and MySQL.

## Overview

This project includes a frontend Angular application, a Node.js/Express API, and a MySQL database. It supports campaign browsing, user accounts, pledges, rewards, profiles, file uploads, and Stripe-based payments.

## Features

- Campaign browsing and filtering
- Creator and backer login and registration
- Create, edit, and manage campaigns
- Reward-based and rewardless pledges
- Profile pages and backed project history
- File uploads for campaign images and stories
- Stripe payment integration
- MySQL-backed data storage

## Tech Stack

- Frontend: Angular 8
- Backend: Node.js + Express
- Database: MySQL
- Payments: Stripe

## Project Structure

```text
crowdfunding-platform/
├── api-node/                  # Express API
├── crowd-funding-angular/     # Angular frontend
├── crowd_funding.sql          # Database schema and sample data
├── README_START_HERE.md      # Setup guide for new users
├── QUICK_REFERENCE.md        # Copy-paste commands
└── DEPLOYMENT_GUIDE.md       # Deployment notes
```

## Prerequisites

- Node.js
- npm
- MySQL server
- Git

## Quick Start

### 1. Set up the database

Create the database and import the schema.

```bash
mysql -u root -p -e "CREATE DATABASE crowd_funding;"
mysql -u root -p crowd_funding < crowd_funding.sql
```

If your MySQL client is not on PATH in Windows, use the full path to `mysql.exe`.

### 2. Start the backend

Open a terminal in `api-node` and run:

```powershell
Set-Location "C:\Users\gaurv\OneDrive\Desktop\Crowdfunding\crowdfunding-platform\api-node"
$env:DB_PASSWORD = "your_mysql_password"
$env:STRIPE_SECRET_KEY = "your_stripe_test_key"
node app.js
```

If your MySQL user has no password, you can skip `DB_PASSWORD`.

### 3. Start the frontend

Open a second terminal in `crowd-funding-angular` and run:

```powershell
Set-Location "C:\Users\gaurv\OneDrive\Desktop\Crowdfunding\crowdfunding-platform\crowd-funding-angular"
$env:NODE_OPTIONS = "--openssl-legacy-provider"
npm start
```

### 4. Open the app

- Frontend: http://localhost:4200
- Backend API: http://localhost:3000

## Helpful Commands

Install dependencies:

```bash
cd api-node
npm install

cd ../crowd-funding-angular
npm install
```

Run backend:

```bash
cd api-node
node app.js
```

Run frontend:

```bash
cd crowd-funding-angular
npm start
```

## Environment Variables

The backend reads these values from the environment:

- `DB_HOST` - MySQL host, default `localhost`
- `DB_USER` - MySQL username, default `root`
- `DB_PASSWORD` - MySQL password
- `DB_NAME` - Database name, default `crowd_funding`
- `STRIPE_SECRET_KEY` - Stripe secret key required for payment routes

## Screenshots

The `screens/` folder contains sample screenshots of the application UI.

## Troubleshooting

- If the backend says `Access denied`, check `DB_PASSWORD`.
- If the backend says `Unknown database`, make sure `crowd_funding` exists and the SQL file was imported.
- If the frontend fails with an OpenSSL error on Node 22, start it with `NODE_OPTIONS=--openssl-legacy-provider`.
- If GitHub push protection blocks a push, make sure no secrets are committed in history.

## Documentation

- `README_START_HERE.md` - Best place to begin
- `QUICK_REFERENCE.md` - Copy-paste startup commands
- `SETUP_GUIDE.md` - Full setup walkthrough
- `DATABASE_SETUP.md` - Database import instructions
- `DEPLOYMENT_GUIDE.md` - Deployment notes

## Notes

This repository was cleaned up for local development, GitHub push protection, and easier setup on Windows.

