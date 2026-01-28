# Releasing

## Versioning

This project uses [Semantic Versioning](https://semver.org/):

- **Major** (1.0.0): Breaking changes, public launch
- **Minor** (0.x.0): New features
- **Patch** (0.0.x): Bug fixes

## Workflow

### 1. Update Changelogs

Before releasing, update both changelog files:

**CHANGELOG.md** (technical, under `[Unreleased]`):
```markdown
## [Unreleased]
### Added
- New feature description

### Fixed
- Bug fix description
```

**content/changelog.md** (user-facing):
Add a new version section at the top with user-friendly descriptions of visible changes. Only include changes users would notice.
```markdown
## Version X.Y — Month Day, Year

- **Feature name** — Brief user-friendly description
```

### 2. Run Release Script

```bash
./scripts/release.sh minor   # New feature
./scripts/release.sh patch   # Bug fix
./scripts/release.sh major   # Breaking change
```

The script:
1. Verifies you're on `main` with no uncommitted changes
2. Bumps version in `package.json`
3. Moves `[Unreleased]` to new version with today's date
4. Commits and tags
5. Pushes to origin
6. Creates GitHub release with changelog notes

### 3. Manual Release (if needed)

```bash
# Bump version
npm version minor --no-git-tag-version

# Edit CHANGELOG.md manually

# Commit and tag
git add package.json CHANGELOG.md
git commit -m "v0.x.0"
git tag -a "v0.x.0" -m "Release v0.x.0"

# Push
git push && git push --tags

# Create GitHub release
gh release create "v0.x.0" --title "v0.x.0" --notes "Release notes here"
```

## Changelog Format

Follow [Keep a Changelog](https://keepachangelog.com/):

- **Added**: New features
- **Changed**: Changes to existing functionality
- **Deprecated**: Soon-to-be removed features
- **Removed**: Removed features
- **Fixed**: Bug fixes
- **Security**: Vulnerability fixes
