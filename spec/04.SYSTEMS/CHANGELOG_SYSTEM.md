# Level 4: Changelog System

**Document Type:** HOW (Implementation)
**References:** Levels 1-3 + Sibling L4 docs + External only

---

## Purpose

Tracks additions and changes to the exhibit, providing a "what's new" view for return visitors.

**Supports:** Living Inquiry (L1), Temporal Awareness (L3)

---

## Entities

### ChangeEntry

A record of a single addition or change.

**Properties:**
| Property | Type | Required | Description |
|----------|------|----------|-------------|
| id | string | yes | Unique identifier |
| date | date | yes | When the change occurred |
| type | enum | yes | Kind of change |
| description | string | yes | Human-readable description of change |
| artifact_id | string | no | Related artifact (if applicable) |
| thread_id | string | no | Related thread (if applicable) |

**Change Types:**
- `artifact_added` - New artifact published
- `artifact_updated` - Significant update to existing artifact
- `thread_added` - New thread created
- `thread_updated` - Thread description or scope changed

---

## Rules

### What Gets Logged
- New artifacts: ALWAYS logged
- Artifact updates: Logged when creator deems change significant
- New threads: Logged when created with artifacts
- Thread updates: Logged at creator discretion

### What Does NOT Get Logged
- Minor typo fixes
- Metadata corrections
- Internal reorganization
- Draft/private changes

### Entry Rules
- Entries are immutable once created
- Entries appear in reverse chronological order (newest first)
- Entries should be concise but descriptive
- No automatic logging—creator writes each entry

---

## Queries

| Query | Returns | Used For |
|-------|---------|----------|
| Recent entries | List of entries (limited) | What's new page |
| All entries | Full changelog | Archive/history view |
| Entries by type | Filtered list | Filter by artifact/thread changes |

---

## Display Behavior

The changelog:
- Shows [limited number] of recent entries by default
- Links to related artifacts/threads when applicable
- Does not create publishing pressure (no frequency expectations)
- Serves return visitors, not as primary navigation

---

## File Structure

```
content/
└── changelog.md         # Single file with all entries
```

---

## Content Format

The changelog is a single markdown file with entries as list items, newest first.

### Changelog File Format

`content/changelog.md`:

```yaml
---
title: "What's New"
---
```

Followed by entries in this format:

```markdown
## 2025

### January

- **2025-01-26** - Added [Project Name](/artifacts/project-name), a new tool for managing tasks. *(artifact_added)*
- **2025-01-25** - Created new thread: [Agency & Systems](/threads/agency-systems). *(thread_added)*
- **2025-01-20** - Updated [Essay Title](/artifacts/essay-title) with revised conclusion. *(artifact_updated)*

## 2024

### December

- **2024-12-15** - Added [Poem Title](/artifacts/poem-title), a meditation on impermanence. *(artifact_added)*
```

### Entry Format

Each entry follows this pattern:

```
- **YYYY-MM-DD** - Description with [link to artifact/thread](path). *(type)*
```

**Components:**
| Component | Required | Description |
|-----------|----------|-------------|
| Date | yes | ISO format date in bold |
| Description | yes | Human-readable description of change |
| Link | when applicable | Markdown link to related artifact or thread |
| Type | yes | Change type in italics and parentheses |

**Change Types:**
- `artifact_added` - New artifact published
- `artifact_updated` - Significant update to existing artifact
- `thread_added` - New thread created
- `thread_updated` - Thread description or scope changed

### Grouping

Entries are grouped by year and month for readability. Empty months are omitted.
