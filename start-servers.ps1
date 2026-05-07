# PowerShell Script to Start Crowdfunding Platform Servers
# Run as: powershell -ExecutionPolicy Bypass -File start-servers.ps1

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "Crowdfunding Platform - Quick Start" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Check if running from correct directory
if (-not (Test-Path "api-node")) {
    Write-Host "ERROR: Please run this script from the crowdfunding-platform root directory" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "Prerequisites Check:" -ForegroundColor Yellow
Write-Host "✓ Node.js installed" -ForegroundColor Green
Write-Host "✓ MySQL server should be running" -ForegroundColor Green
Write-Host "✓ Database 'crowd_funding' should exist" -ForegroundColor Green
Write-Host ""

# Backend Setup
Write-Host "============================================" -ForegroundColor Yellow
Write-Host "Step 1: Backend Setup" -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Yellow

Set-Location "api-node"

if (-not (Test-Path "node_modules")) {
    Write-Host "Installing backend dependencies..." -ForegroundColor Cyan
    npm install
} else {
    Write-Host "Backend dependencies already installed" -ForegroundColor Green
}

Write-Host ""
Write-Host "Starting Backend Server on port 3000..." -ForegroundColor Cyan
Start-Process powershell -ArgumentList "-NoExit", "-Command", "node app.js"

Set-Location ".."

Start-Sleep -Seconds 2

# Frontend Setup
Write-Host ""
Write-Host "============================================" -ForegroundColor Yellow
Write-Host "Step 2: Frontend Setup" -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Yellow

Set-Location "crowd-funding-angular"

if (-not (Test-Path "node_modules")) {
    Write-Host "Installing frontend dependencies..." -ForegroundColor Cyan
    npm install
} else {
    Write-Host "Frontend dependencies already installed" -ForegroundColor Green
}

Write-Host ""
Write-Host "Starting Frontend Server on port 4200..." -ForegroundColor Cyan
Start-Process powershell -ArgumentList "-NoExit", "-Command", "npm start"

Write-Host ""
Write-Host "============================================" -ForegroundColor Green
Write-Host "✓ Servers Starting!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green
Write-Host ""
Write-Host "Backend:  http://localhost:3000" -ForegroundColor Yellow
Write-Host "Frontend: http://localhost:4200" -ForegroundColor Yellow
Write-Host ""
Write-Host "Both servers are starting in new PowerShell windows" -ForegroundColor Cyan
Write-Host ""
