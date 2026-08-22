@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo.
echo ╔════════════════════════════════════════════════════════╗
echo ║  🚀 Deploy to Render - Afreen's Birthday Website      ║
echo ║        One-Click Deployment Script                    ║
echo ╚════════════════════════════════════════════════════════╝
echo.

REM Check if Git is installed
git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Git is not installed. Please install Git first.
    pause
    exit /b 1
)

echo ✓ Git is installed

REM Check if in git repository
git rev-parse --git-dir >nul 2>&1
if errorlevel 1 (
    echo ⚠️  Not in a git repository
    echo.
    echo Steps to set up:
    echo 1. Create a GitHub repository
    echo 2. Clone it: git clone ^<your-repo-url^>
    echo 3. Copy all files to the cloned directory
    echo 4. Run this script again
    pause
    exit /b 1
)

echo ✓ Git repository found

REM Check if remote exists
git remote -v | find "origin" >nul 2>&1
if errorlevel 1 (
    echo ❌ No 'origin' remote found
    echo Run: git remote add origin ^<your-github-url^>
    pause
    exit /b 1
)

echo ✓ Git remote configured
echo.

REM Show current status
echo Current git status:
git status
echo.

REM Get commit message
set /p commit_msg="Enter commit message (default: 'Update Afreen birthday website'): "
if "!commit_msg!"=="" (
    set commit_msg=Update Afreen birthday website
)

echo.
echo Staging files...
git add .

echo Committing changes...
git commit -m "!commit_msg!"

if errorlevel 1 (
    echo ⚠️  No changes to commit or commit failed
) else (
    echo ✓ Changes committed
)

echo Pushing to GitHub...
git push -u origin main

if errorlevel 1 (
    echo Trying with 'master' branch...
    git push -u origin master
    if errorlevel 1 (
        echo ❌ Failed to push to GitHub
        pause
        exit /b 1
    )
)

echo.
echo ✓ Code pushed to GitHub!
echo.
echo Next steps:
echo 1. Go to https://render.com
echo 2. Sign in with your GitHub account
echo 3. Click 'New +' ^> 'Web Service'
echo 4. Select your repository 'afreen-birthday-21'
echo 5. Click 'Create Web Service'
echo 6. Render will automatically deploy! 🎉
echo.
echo Your website will be live at:
echo https://afreen-birthday-21.onrender.com
echo.
echo Share this link with family and friends! 💕
echo ═══════════════════════════════════════════════════════
pause
