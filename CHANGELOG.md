# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Commit hook enforcing CHANGELOG updates (husky)
- Release automation script (`./scripts/release.sh`)
- User-facing What's New page format
- Artifact: SpriteStory — AI pixel art story generator

### Removed
- Placeholder example artifact

## [0.1.0] - 2026-01-26

### Added
- Dark design system with archival aesthetic
  - Design tokens: void/surface/elevated backgrounds
  - Text hierarchy: primary/secondary/tertiary
  - Accent colors: ember (mortality), verdigris (age), aureate (illumination)
  - Typography: Cormorant Garamond headings, Source Serif 4 body, JetBrains Mono mono
- MVP pages: home, charter, artifacts, threads, changelog
- Content collections: artifacts, threads, content
- Artifact filtering by medium
- Thread-artifact relationships
- Dev server process management scripts
- Commit hook enforcing CHANGELOG updates
- Release automation script

### Changed
- Migrated from light (stone-*) to dark semantic color tokens

[Unreleased]: https://github.com/USER/anima-ex-mortali/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/USER/anima-ex-mortali/releases/tag/v0.1.0
