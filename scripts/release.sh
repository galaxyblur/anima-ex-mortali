#!/bin/bash
set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check arguments
if [ -z "$1" ]; then
  echo -e "${RED}Usage: ./scripts/release.sh [major|minor|patch]${NC}"
  exit 1
fi

VERSION_TYPE=$1

if [[ ! "$VERSION_TYPE" =~ ^(major|minor|patch)$ ]]; then
  echo -e "${RED}Invalid version type. Use: major, minor, or patch${NC}"
  exit 1
fi

# Pre-flight checks
echo -e "${YELLOW}Running pre-flight checks...${NC}"

# Check we're on main
BRANCH=$(git branch --show-current)
if [ "$BRANCH" != "main" ]; then
  echo -e "${RED}Must be on main branch (currently on: $BRANCH)${NC}"
  exit 1
fi

# Check for uncommitted changes
if [ -n "$(git status --porcelain)" ]; then
  echo -e "${RED}Working directory not clean. Commit or stash changes first.${NC}"
  git status --short
  exit 1
fi

# Changelog confirmation
echo ""
echo -e "${YELLOW}Before releasing, ensure:${NC}"
echo "  1. CHANGELOG.md [Unreleased] section has all changes"
echo "  2. content/changelog.md (What's New) updated for user-facing changes"
echo ""
read -p "Have both changelogs been updated? [y/N] " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo -e "${RED}Update changelogs before releasing.${NC}"
  exit 1
fi

# Bump version
echo -e "${YELLOW}Bumping $VERSION_TYPE version...${NC}"
npm version $VERSION_TYPE --no-git-tag-version

# Get new version
VERSION=$(node -p "require('./package.json').version")
DATE=$(date +%Y-%m-%d)

echo -e "${GREEN}New version: $VERSION${NC}"

# Update CHANGELOG.md - replace [Unreleased] with version
echo -e "${YELLOW}Updating CHANGELOG.md...${NC}"

# macOS sed requires empty string for -i
if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i '' "s/## \[Unreleased\]/## [Unreleased]\n\n## [$VERSION] - $DATE/" CHANGELOG.md
else
  sed -i "s/## \[Unreleased\]/## [Unreleased]\n\n## [$VERSION] - $DATE/" CHANGELOG.md
fi

# Stage files
git add package.json package-lock.json CHANGELOG.md

# Commit and tag
echo -e "${YELLOW}Creating commit and tag...${NC}"
git commit -m "v$VERSION"
git tag -a "v$VERSION" -m "v$VERSION"

# Push
echo -e "${YELLOW}Pushing to origin...${NC}"
git push && git push --tags

# Extract changelog for this version (between this version header and next ## or EOF)
CHANGELOG_SECTION=$(awk "/## \[$VERSION\]/{flag=1; next} /## \[/{flag=0} flag" CHANGELOG.md)

# Create GitHub release
echo -e "${YELLOW}Creating GitHub release...${NC}"
gh release create "v$VERSION" \
  --title "v$VERSION" \
  --notes "$CHANGELOG_SECTION"

echo ""
echo -e "${GREEN}Released v$VERSION${NC}"
