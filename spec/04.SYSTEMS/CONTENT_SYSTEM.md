# Level 4: Content System

**Document Type:** HOW (Implementation)
**References:** Levels 1-3 + Sibling L4 docs + External only

---

## Purpose

Manages all exhibit content: artifacts and their organization into threads.

**Supports:** Authentic Documentation (L1), Body of Work Over Individual Projects (L2)

---

## Entities

### Artifact

A discrete piece of creative work in the exhibit.

**Properties:**
| Property | Type | Required | Description |
|----------|------|----------|-------------|
| id | string (slug) | yes | Unique identifier, URL-friendly |
| title | string | yes | Display title |
| description | string | yes | Brief description of the work |
| medium | enum | yes | Type of content |
| status | enum | yes | Current state of the work |
| threads | array[string] | no | Thread IDs this artifact belongs to |
| date_created | date | yes | When the work was created |
| date_added | date | yes | When added to exhibit |
| external_links | array[Link] | no | Links to external resources |
| content | markdown | no | Embedded content (for prose, poetry) |

**Medium Types:**
- `prose` - Essays, writing
- `poetry` - Poems (embedded directly)
- `code` - Apps, tools, software projects
- `music` - Songs, albums, audio work
- `visual` - Visual art (future)

**Status Values:**
- `complete` - Finished work
- `in-progress` - Ongoing/evolving
- `archived` - No longer active but preserved

**Link Structure:**
| Property | Type | Description |
|----------|------|-------------|
| url | string | External URL |
| label | string | Display text (e.g., "GitHub", "Bandcamp") |
| type | enum | Link type: `repository`, `streaming`, `demo`, `download`, `other` |

### Thread

A lightweight grouping that connects related artifacts.

**Properties:**
| Property | Type | Required | Description |
|----------|------|----------|-------------|
| id | string (slug) | yes | Unique identifier |
| title | string | yes | Thread name/phrase |
| description | string | no | Brief description (optional—artifacts speak for thread) |

**Note:** Threads are intentionally minimal. They exist as connective tissue, not as content containers.

---

## Rules

### Artifact Rules
- Artifacts MAY belong to zero or more threads
- Artifacts MUST have at least one medium type
- Artifacts with `prose` or `poetry` medium SHOULD have embedded content
- Artifacts with `code` or `music` medium SHOULD have external links
- Status can change over time; transitions are not restricted

### Thread Rules
- Threads exist when at least one artifact references them
- Empty threads (no artifacts) MAY be pruned or kept as placeholders
- Thread descriptions are optional—if artifacts fully represent the thread, description can be minimal

### Relationship Rules
- Thread-artifact relationship is many-to-many
- Artifacts declare their thread membership (artifact owns the relationship)
- Threads do not store artifact lists (derived from artifact declarations)

---

## Queries

The Content System supports these access patterns:

| Query | Returns | Used For |
|-------|---------|----------|
| All artifacts | List of artifacts | Browse/index pages |
| Artifacts by thread | Filtered list | Thread detail pages |
| Artifacts by medium | Filtered list | Browse by type |
| Single artifact by ID | Artifact | Artifact detail page |
| All threads | List of threads | Navigation, thread index |
| Single thread with artifacts | Thread + related artifacts | Thread detail page |

---

## File Structure

```
content/
├── charter.md                 # Static charter page
├── artifacts/
│   ├── project-name.md        # One file per artifact
│   └── another-work.md
└── threads/
    └── thread-name.md         # Optional thread description files
```

---

## Content Formats

### Artifact File Format

Each artifact is a markdown file in `content/artifacts/` with YAML frontmatter:

```yaml
---
title: "Project Name"
description: "Brief description of the work"
medium: code                    # prose | poetry | code | music | visual
status: complete                # complete | in-progress | archived
threads:                        # optional
  - thread-slug
  - another-thread
date_created: 2024-06-15        # when work was created
date_added: 2025-01-26          # when added to exhibit
external_links:                 # optional, for code/music
  - url: "https://example.com/app"
    label: "Live Demo"
    type: demo                  # repository | streaming | demo | download | other
  - url: "https://github.com/user/repo"
    label: "GitHub"
    type: repository
---

# Content body (for prose/poetry)

For prose and poetry, the markdown body contains the full work.
For code and music, the body can contain additional context or notes.
```

**Examples by Medium:**

Code artifact:
```yaml
---
title: "Task Manager App"
description: "A simple tool for managing daily tasks without guilt"
medium: code
status: complete
threads:
  - agency-systems
  - practical-tools
date_created: 2024-03-10
date_added: 2025-01-26
external_links:
  - url: "https://taskapp.example.com"
    label: "Live App"
    type: demo
---
```

Poetry artifact:
```yaml
---
title: "Untitled (Mortality)"
description: "A meditation on impermanence"
medium: poetry
status: complete
threads:
  - mortality-meditations
date_created: 2023-11-20
date_added: 2025-01-26
---

The body holds the poem itself,
with line breaks preserved
exactly as written.
```

Music artifact:
```yaml
---
title: "Album Name"
description: "Songs exploring themes of loss and renewal"
medium: music
status: complete
threads:
  - mortality-meditations
  - self-actualization
date_created: 2022-08-01
date_added: 2025-01-26
external_links:
  - url: "https://bandcamp.com/album"
    label: "Bandcamp"
    type: streaming
  - url: "https://spotify.com/album"
    label: "Spotify"
    type: streaming
---
```

### Thread File Format

Threads are markdown files in `content/threads/` with minimal frontmatter:

```yaml
---
title: "Thread Name"
description: "Optional brief description"  # can be omitted
---

Optional body content if the thread needs more context.
Usually left empty—artifacts speak for the thread.
```

**Example:**
```yaml
---
title: "Agency & Systems"
description: "Exploring individual agency within systemic forces"
---
```

### Charter File Format

Single file at `content/charter.md`:

```yaml
---
title: "Charter"
---

# Charter content in markdown

Mission statement, values, creative philosophy, etc.
```
