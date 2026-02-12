# Process Inbox Skill

## Description
Intelligently process files from 00_INBOX and move them to appropriate locations in the PARA structure, creating folders as needed.

## Usage
- `/process-inbox` - Process all files in 00_INBOX
- `/process-inbox [filename]` - Process a specific file from 00_INBOX

## What This Skill Does
1. Reads files from 00_INBOX directory
2. Analyzes content to determine topic and purpose
3. Suggests appropriate destination based on PARA method
4. Creates folders if they don't exist
5. Moves files to suggested locations
6. Provides summary of all moves

## Agent Instructions

When this skill is invoked:

### 1. Discovery Phase
- List all files in `00_INBOX/` (or use specified filename)
- Exclude `_readme.md` and `_log.md` from processing
- For each file, read its content to understand:
  - Topic/subject matter
  - Purpose (learning resource, project doc, reference, etc.)
  - Language (English/Spanish)
  - File type and format

### 2. Analysis Phase
For each file, determine the best location using PARA method:

**01_PROJECTS/** - Active projects with specific goals/deadlines
- ALICIA/ - Education, phonics, bilingual learning
- BILAN/ - Electrolyte business (marketing, sales, product)
- CAR/ - Car-related content
- COOKING/ - Recipes, cooking guides
- MUSIC/ - Strudel, Moises, Koala, music production
- NARANJOS/ - Naranjos project content

**02_AREAS/** - Ongoing responsibilities (no end date)
- HOME-LAB/ - Home automation, lab projects
- Personal_Development/ - Personal growth, learning
- Software_Development/ - Software engineering learning
- Workflow_Automation/ - n8n, automation workflows

**03_RESOURCES/** - Reference material and knowledge base
- AI/ - Claude, Fabric, Ollama, LangChain, etc.
- Design/ - FreeCAD, Inkscape
- Knowledge_Management/ - Logseq, OpenCode, second brain
- Software_Engineering/ - Python, Docker, Git, Security
- Terminal_And_Shell/ - tmux, zsh, fzf, dotfiles
- Misc/ - Travel, transcripts, general reference

**04_ARCHIVES/** - Completed or inactive items

**05_JOURNAL/** - Daily notes and journals

### 3. Suggestion Phase
For each file, provide:
- **Current location:** `00_INBOX/[filename]`
- **Suggested destination:** Full path (e.g., `03_RESOURCES/AI/CLAUDE/[filename]`)
- **Reason:** Brief explanation of why this location fits
- **Create folder:** YES/NO - whether new folders need to be created
- **Confidence:** HIGH/MEDIUM/LOW

### 4. Execution Phase
For each file:
1. Create destination folders if they don't exist
2. Move file to suggested location
3. Log the move with timestamp

### 5. Summary Phase
Provide a clear summary:
```
📥 Processed N files from inbox:

✅ [filename1]
   → Moved to: [destination]
   📁 Created: [new folders if any]

✅ [filename2]
   → Moved to: [destination]

❓ [filename3]
   → Needs user decision (LOW confidence)
   → Suggestions: [location1] or [location2]
```

## Decision Rules

### HIGH Confidence (auto-move)
- File name/content clearly matches existing project
- Topic explicitly matches a resource category
- Quiz/learning content for known technologies

### MEDIUM Confidence (suggest and ask)
- Topic matches area but unclear which subfolder
- Could fit multiple locations
- New topic that might need new subfolder

### LOW Confidence (ask user)
- Ambiguous content
- Multiple valid destinations
- Unclear if PROJECT vs AREA vs RESOURCE
- Completely new topic

## Special Cases

### Quiz Files
- If about Claude/AI tools → `03_RESOURCES/AI/CLAUDE/quizzes/`
- If about specific technology → `03_RESOURCES/Software_Engineering/[tech]/quizzes/`
- If about business/BILAN → `01_PROJECTS/BILAN/[relevant-section]/`

### Multilingual Content
- Spanish content for BILAN → Keep in BILAN structure
- Spanish personal content → Create `_es/` subfolder if needed

### Learning Materials
- Active learning roadmap → `02_AREAS/Software_Development/`
- Reference documentation → `03_RESOURCES/[category]/`
- Course notes → `02_AREAS/Personal_Development/courses/`

### Scripts and Code
- Project-specific → Project root or scripts/ subfolder
- General utilities → `03_RESOURCES/Software_Engineering/SCRIPTS/`

## Folder Creation Policy
- Create subfolders that follow existing naming patterns
- Use lowercase with hyphens or underscores matching parent style
- For new topics, suggest folder name to user first (MEDIUM/LOW confidence)
- Always create full path (e.g., `mkdir -p path/to/new/folder`)

## Examples

### Example 1: Claude quiz files
```
Input: `/process-inbox`
Files: claude-skills-quiz.md, claude-skills-quiz-answers.md

Analysis:
- Topic: Claude Code skills and features
- Purpose: Learning/reference material
- Type: Quiz format

Suggestion:
- Destination: 03_RESOURCES/AI/CLAUDE/quizzes/
- Create folder: YES (quizzes/ subfolder)
- Confidence: HIGH
- Reason: Claude-specific learning material fits AI resources

Action:
1. mkdir -p 03_RESOURCES/AI/CLAUDE/quizzes
2. mv 00_INBOX/claude-skills-quiz.md 03_RESOURCES/AI/CLAUDE/quizzes/
3. mv 00_INBOX/claude-skills-quiz-answers.md 03_RESOURCES/AI/CLAUDE/quizzes/
```

### Example 2: Remotion rendering quiz
```
Input: `/process-inbox`
File: remotion-rendering-quiz-full.md

Analysis:
- Topic: Remotion (React video framework)
- Purpose: Technical quiz/learning
- Related to: BILAN video generation project

Suggestions (MEDIUM confidence):
1. 01_PROJECTS/BILAN/video-generation/quizzes/
   - Pro: Related to active BILAN video work
   - Con: Might be archived already

2. 03_RESOURCES/Software_Engineering/REACT/remotion/
   - Pro: General learning resource
   - Con: New folder needed

Ask user: "Where should remotion-rendering-quiz-full.md go?"
```

### Example 3: New technology notes
```
Input: `/process-inbox`
File: rust-ownership-notes.md

Analysis:
- Topic: Rust programming language
- Purpose: Learning notes
- New category: Rust not in current structure

Suggestion (MEDIUM confidence):
- Create: 03_RESOURCES/Software_Engineering/RUST/
- Move to: 03_RESOURCES/Software_Engineering/RUST/ownership-notes.md
- Ask user: "Should I create a RUST folder in Software_Engineering resources?"
```

## Post-Processing
After moving files:
1. Update `00_INBOX/_log.md` with timestamp and moves
2. Suggest creating wiki-style links `[[note-name]]` if relevant
3. Suggest related files user might want to review
4. Clean up empty 00_INBOX (except _readme.md and _log.md)

## Error Handling
- If file read fails → Skip and report
- If destination exists → Ask to overwrite or rename
- If folder creation fails → Report and ask user to check permissions
- If move fails → Report error and keep in inbox
