---
title: Rootspec
description: A hierarchical specification framework for software projects
medium: code
status: in-progress
date_created: "2025-11-01"
date_added: "2026-01-26"
external_links:
  - url: "https://github.com/rootspec/rootspec"
    label: "Repository"
    type: repository
---

An npm package providing a hierarchical specification framework designed to maintain architectural coherence across software projects.

## Core Principle

Each concern lives at exactly one level (single source of truth). Changes flow downward through abstraction layers while foundational documents remain stable. The framework enforces strict separation of concerns across five levels, from philosophical foundations to implementation details.

## AI-Assisted Workflow

This framework shines when used with AI assistants like Claude Code, which can guide you through the specification process, validate hierarchy rules, and ensure consistency across levels.

## Connection

This project's own spec framework (in `/spec`) is built on Rootspec.
