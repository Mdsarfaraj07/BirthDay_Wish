#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  🚀 Deploy to Render - Afreen's Birthday Website      ║${NC}"
echo -e "${BLUE}║        One-Click Deployment Script                    ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ Git is not installed. Please install Git first.${NC}"
    exit 1
fi

echo -e "${GREEN}✓ Git is installed${NC}"

# Check if in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${YELLOW}⚠️  Not in a git repository${NC}"
    echo ""
    echo "Steps to set up:"
    echo "1. Create a GitHub repository"
    echo "2. Clone it: git clone <your-repo-url>"
    echo "3. Copy all files to the cloned directory"
    echo "4. Run this script again"
    exit 1
fi

echo -e "${GREEN}✓ Git repository found${NC}"
echo ""

# Check if remote exists
if ! git remote -v | grep -q "origin"; then
    echo -e "${RED}❌ No 'origin' remote found${NC}"
    echo "Run: git remote add origin <your-github-url>"
    exit 1
fi

echo -e "${GREEN}✓ Git remote configured${NC}"

# Show current status
echo ""
echo -e "${BLUE}Current git status:${NC}"
git status

echo ""
echo -e "${YELLOW}Files to be committed:${NC}"
git status --porcelain | head -10

echo ""
read -p "Do you want to continue with deployment? (y/n): " confirm

if [[ "$confirm" != "y" ]]; then
    echo "Cancelled."
    exit 0
fi

echo ""
read -p "Enter commit message (default: 'Update Afreen birthday website'): " commit_msg
commit_msg=${commit_msg:-"Update Afreen birthday website"}

# Stage all changes
echo -e "${YELLOW}Staging files...${NC}"
git add .

# Commit
echo -e "${YELLOW}Committing changes...${NC}"
if git commit -m "$commit_msg"; then
    echo -e "${GREEN}✓ Changes committed${NC}"
else
    echo -e "${YELLOW}⚠️  No changes to commit${NC}"
fi

# Push to GitHub
echo -e "${YELLOW}Pushing to GitHub...${NC}"
if git push -u origin main; then
    echo -e "${GREEN}✓ Pushed to GitHub successfully${NC}"
else
    # Try with master branch
    echo -e "${YELLOW}Trying with 'master' branch...${NC}"
    if git push -u origin master; then
        echo -e "${GREEN}✓ Pushed to GitHub successfully${NC}"
    else
        echo -e "${RED}❌ Failed to push to GitHub${NC}"
        exit 1
    fi
fi

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✓ Code pushed to GitHub!${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Go to https://render.com"
echo "2. Sign in with your GitHub account"
echo "3. Click 'New +' → 'Web Service'"
echo "4. Select your repository 'afreen-birthday-21'"
echo "5. Click 'Create Web Service'"
echo "6. Render will automatically deploy! 🎉"
echo ""
echo -e "${BLUE}Your website will be live at:${NC}"
echo -e "${GREEN}https://afreen-birthday-21.onrender.com${NC}"
echo ""
echo -e "${YELLOW}Share this link with family and friends! 💕${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════${NC}"
