# Releasing

## Versioning

This project uses [Semantic Versioning](https://semver.org/):

- **Major** (1.0.0): Breaking changes, public launch
- **Minor** (0.x.0): New features
- **Patch** (0.0.x): Bug fixes

## Workflow

Use the `/release` skill:

```
/release minor   # New feature
/release patch   # Bug fix
/release major   # Breaking change
```

The skill guides through updating changelogs and runs `npm run release`, which:
1. Verifies you're on `main` with no uncommitted changes
2. Bumps version in `package.json`
3. Moves `[Unreleased]` to new version with today's date
4. Commits and tags
5. Pushes to origin
6. Creates GitHub release with changelog notes

## Changelogs

Update both before releasing:

**`CHANGELOG.md`** — technical changelog, under `[Unreleased]`

**`content/changelog.md`** — user-facing, visible in the app
