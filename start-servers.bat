@echo off
REM Quick Start Script for Crowdfunding Platform - Windows

echo ============================================
echo Crowdfunding Platform - Quick Start
echo ============================================
echo.
echo This script will start both backend and frontend servers
echo Press Ctrl+C to stop each server when done
echo.

echo Starting MySQL Database (ensure it's running first!)
echo.

REM Check if running from correct directory
if not exist "api-node" (
    echo ERROR: Please run this script from the crowdfunding-platform root directory
    pause
    exit /b 1
)

echo ============================================
echo Step 1: Installing/Checking Backend Dependencies
echo ============================================
cd api-node
if not exist "node_modules" (
    echo Installing backend dependencies...
    call npm install
) else (
    echo Backend dependencies already installed
)
echo.

REM Start backend in a new window
echo Starting Backend Server on port 3000...
start "Backend Server" cmd /k node app.js

REM Wait a bit for backend to start
timeout /t 2 /nobreak

cd ..

echo.
echo ============================================
echo Step 2: Installing/Checking Frontend Dependencies
echo ============================================
cd crowd-funding-angular
if not exist "node_modules" (
    echo Installing frontend dependencies...
    call npm install
) else (
    echo Frontend dependencies already installed
)
echo.

REM Start frontend in a new window
echo Starting Frontend Server on port 4200...
start "Frontend Server" cmd /k npm start

echo.
echo ============================================
echo Servers Starting!
echo ============================================
echo.
echo Backend: http://localhost:3000
echo Frontend: http://localhost:4200
echo.
echo Both servers are starting in new windows
echo The frontend will open automatically in your browser
echo.
echo Press any key to close this window
echo (The servers will continue running)
echo.
pause
