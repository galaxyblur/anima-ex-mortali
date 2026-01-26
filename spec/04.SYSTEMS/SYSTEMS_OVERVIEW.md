# Level 4: Systems Overview

**Document Type:** HOW (Implementation)
**References:** Levels 1-3 + Sibling L4 docs + External only

---

## System Map

```
┌─────────────────────────────────────────────────────────┐
│                      EXHIBIT                            │
├─────────────────────────────────────────────────────────┤
│                                                         │
│   ┌─────────────┐     ┌─────────────┐                  │
│   │   CHARTER   │     │  CHANGELOG  │                  │
│   │   (static)  │     │   SYSTEM    │                  │
│   └─────────────┘     └──────┬──────┘                  │
│                              │ logs                     │
│                              ▼                          │
│   ┌─────────────────────────────────────────────┐      │
│   │              CONTENT SYSTEM                  │      │
│   │  ┌─────────┐  ┌─────────┐  ┌─────────┐     │      │
│   │  │Artifacts│◄─┤ Threads │  │ Media   │     │      │
│   │  │         │  │ (tags)  │  │ Types   │     │      │
│   │  └─────────┘  └─────────┘  └─────────┘     │      │
│   └─────────────────────────────────────────────┘      │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

## Systems

| System | Responsibility | Key Entities |
|--------|---------------|--------------|
| **Content System** | Manages artifacts, threads, and their relationships | Artifact, Thread |
| **Changelog System** | Tracks and displays additions/changes | ChangeEntry |
| **Charter** | Static page presenting mission and values | (no entities—static content) |

## System Interactions

| From | To | Interaction |
|------|-----|-------------|
| Content System | Changelog System | New/updated artifacts trigger changelog entries |
| Threads | Artifacts | Threads reference artifacts by ID |
| Artifacts | Threads | Artifacts declare thread membership |

## Data Flow

**Adding an Artifact:**
```
Creator writes markdown → Artifact created → Thread links added → Changelog entry created
```

**Visitor Browsing:**
```
Entry point → Content System serves artifact/thread → Thread links enable discovery
```
