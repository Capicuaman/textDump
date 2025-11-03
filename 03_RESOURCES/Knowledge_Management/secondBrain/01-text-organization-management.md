# Text Organization & Management with OpenCode

## Directory Structure Setup

### Command to Create Knowledge Base Structure
```bash
opencode "Create a structured directory system for my knowledge base with folders for: projects, ideas, references, and daily notes"
```

### Expected Structure
```
knowledge-base/
├── projects/
│   ├── active/
│   ├── completed/
│   └── archived/
├── ideas/
│   ├── business/
│   ├── personal/
│   └── creative/
├── references/
│   ├── articles/
│   ├── books/
│   ├── tutorials/
│   └── resources/
├── daily-notes/
│   ├── 2025/
│   │   ├── 01-january/
│   │   ├── 02-february/
│   │   └── ...
│   └── templates/
└── templates/
    ├── project-note.md
    ├── idea-capture.md
    └── reference-summary.md
```

## Template Generation

### Meeting Notes Template
```bash
opencode "Generate a meeting notes template with sections for: attendees, agenda, key decisions, action items, and follow-up"
```

### Book Summary Template
```bash
opencode "Create a book summary template with sections for: key concepts, memorable quotes, actionable insights, and personal reflections"
```

### Project Planning Template
```bash
opencode "Generate a project planning template with: objectives, timeline, resources, risks, and success metrics"
```

### Daily Reflection Template
```bash
opencode "Create a daily reflection template with: accomplishments, challenges, lessons learned, and tomorrow's priorities"
```

## File Management Commands

### Batch File Operations
```bash
# Organize loose notes into proper folders
opencode "Move all .md files from the root directory into appropriate subfolders based on their content"

# Rename files consistently
opencode "Rename all files in the ideas folder to follow the format: YYYY-MM-DD-idea-title.md"

# Create index files
opencode "Generate an index.md file for each folder that lists all contained files with brief descriptions"
```

### Content-Based Organization
```bash
# Categorize by content
opencode "Read all files in the references folder and categorize them by topic into subfolders"

# Tag and label
opencode "Add frontmatter tags to all markdown files based on their content for better searchability"
```

## Advanced Organization Features

### Smart Filing System
```bash
opencode "Create a smart filing system that automatically suggests the best folder for new notes based on content analysis"
```

### Cross-Reference Management
```bash
opencode "Generate a master index that cross-references related topics across all my knowledge base files"
```

### Archive Management
```bash
opencode "Identify and move old project files to archive folder while maintaining a reference index"
```

## Maintenance Commands

### Regular Cleanup
```bash
# Weekly organization
opencode "Review and organize all files created this week into proper folders"

# Duplicate detection
opencode "Find and flag potential duplicate content across my knowledge base files"

# Content refresh
opencode "Review old notes and suggest updates or connections to newer information"
```

### Backup and Sync
```bash
opencode "Create a backup script that preserves folder structure and metadata for my knowledge base"
```

## Search and Retrieval Enhancement

### Metadata Enhancement
```bash
opencode "Add consistent frontmatter to all files with creation date, last modified, tags, and summary"
```

### Content Indexing
```bash
opencode "Generate a searchable content index with keywords and file locations"
```

## Workflow Integration

### Daily Note Creation
```bash
opencode "Create today's daily note using the template and pre-fill with any scheduled items from my calendar"
```

### Project Note Generation
```bash
opencode "Create a new project note template for [project-name] with standard sections and initial planning prompts"
```

## Best Practices

### Naming Conventions
- Use consistent date formats: YYYY-MM-DD
- Include descriptive titles in filenames
- Use hyphens instead of spaces
- Keep filenames under 50 characters when possible

### Folder Organization
- Keep folder depth to 3-4 levels maximum
- Use numeric prefixes for ordering (01-, 02-, etc.)
- Maintain an index file in each major folder
- Review and reorganize quarterly

### Content Standards
- Use consistent markdown formatting
- Include frontmatter metadata
- Add creation and modification dates
- Use tags for cross-referencing

## Example Templates

### Basic Note Template
```markdown
---
title: "Note Title"
date: 2025-01-01
tags: [tag1, tag2, tag3]
category: "folder-name"
---

# Note Title

## Key Points
- Point 1
- Point 2

## Action Items
- [ ] Task 1
- [ ] Task 2

## Related Notes
- [[related-note-1]]
- [[related-note-2]]
```

### Quick Capture Template
```markdown
---
type: "quick-capture"
date: 2025-01-01
tags: []
---

# Quick Capture

**Idea:**

**Context:**

**Next Steps:**
```

This system transforms OpenCode into a powerful text organization tool that adapts to your personal knowledge management style.