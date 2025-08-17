@echo off
REM Scaffold-ETH 2 Setup Script for Windows
REM This script automates the setup process and handles common issues

echo 🏗 Setting up Scaffold-ETH 2...

REM Check Node.js version
echo 📋 Checking Node.js version...
for /f "tokens=2 delims=v" %%i in ('node --version') do set node_version=%%i
echo Node.js version: %node_version%

REM Install dependencies
echo 📦 Installing dependencies...
call yarn install
if %errorlevel% neq 0 (
    echo ❌ Failed to install dependencies
    exit /b 1
)

REM Install additional packages that might be missing
echo 📦 Installing additional packages...
cd packages\nextjs
call yarn add qrcode @types/qrcode
cd ..\..

REM Generate burner wallet
echo 👛 Generating burner wallet...
call yarn generate
if %errorlevel% neq 0 (
    echo ❌ Failed to generate burner wallet
    exit /b 1
)

REM Clear any existing build cache
echo 🧹 Clearing build cache...
if exist packages\nextjs\.next rmdir /s /q packages\nextjs\.next

echo ✅ Setup complete!
echo.
echo 🚀 Next steps:
echo 1. Start blockchain:    yarn chain     (in terminal 1)
echo 2. Deploy contracts:    yarn deploy    (in terminal 2)
echo 3. Start frontend:      yarn start     (in terminal 3)
echo.
echo 📖 Visit http://localhost:3000 when all services are running
echo 🔧 For troubleshooting, see TROUBLESHOOTING.md

pause
