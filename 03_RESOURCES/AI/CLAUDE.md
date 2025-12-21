# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Directory Overview

This is the **AI Resources** directory (`03_RESOURCES/AI/`) within a PARA-organized knowledge management system. It serves as a centralized documentation hub for AI tools, frameworks, and workflows—not a software development project.

**Primary purpose:** Reference documentation and learning materials for AI tools (Claude, Gemini, Ollama, Fabric, OpenCode, etc.)

**Content format:** Primarily Markdown documentation (95%+), with occasional Python analysis scripts

## Important Context

### This is NOT a Software Project

- **No build system** - No compilation, bundling, or deployment processes
- **No test suite** - No automated testing infrastructure
- **No package dependencies** - Minimal Python scripts with standard library only
- **No deployment** - Static documentation repository

### What This Directory Contains

Reference documentation for AI tools used throughout the broader PARA system:
- **CLAUDE/** - Claude AI documentation hub (API, CLI, Agent SDK, patterns)
- **GEMINI/** - Google Gemini documentation and guides
- **OLLAMA/** - Local LLM deployment and management guides
- **fabric/** - Daniel Miessler's Fabric framework documentation
- **OPENCODE/** - OpenCode "second brain" tool reference
- **AI_STUDIO/** - Google AI Studio quickstart
- **FABRIC_PATTERNS/** - Custom pattern templates
- **Python scripts** - Small analysis utilities (conversation extraction, theme analysis)

## Directory Structure

```
03_RESOURCES/AI/
├── CLAUDE/                   # Claude documentation hub
│   ├── how-to/              # Step-by-step guides
│   ├── patterns/            # Usage patterns and templates
│   ├── examples/            # Real-world implementations
│   └── *.md                 # Core documentation files
├── GEMINI/                  # Gemini documentation
├── OLLAMA/                  # Ollama guides
├── fabric/                  # Fabric framework docs
├── OPENCODE/                # OpenCode tool reference
├── _MOC_AI.md              # Map of Content (central hub)
├── How_My_Projects_Fit_Together.md  # Philosophy
└── promptEngineering_PRIMER.md     # Prompt engineering guide
```

## Working in This Directory

### When Reading/Searching

**Use these patterns:**

1. **Finding documentation on a tool:**
   ```
   Grep for keywords in the tool's subdirectory
   Example: Grep "API" in CLAUDE/ for API-related docs
   ```

2. **Understanding tool relationships:**
   ```
   Read _MOC_AI.md (Map of Content) for navigation
   Read How_My_Projects_Fit_Together.md for philosophical context
   ```

3. **Finding guides/primers:**
   ```
   Look for files ending in *_PRIMER.md, *_guide.md, *Study.md
   Check how-to/ subdirectories for step-by-step instructions
   ```

### When Creating Documentation

**Follow these principles:**

1. **Placement:**
   - Tool-specific docs → Tool's subdirectory (e.g., CLAUDE/, GEMINI/)
   - Cross-tool patterns → Root level with descriptive name
   - Step-by-step guides → `[tool]/how-to/` subdirectory
   - Usage patterns → `[tool]/patterns/` subdirectory
   - Examples → `[tool]/examples/` subdirectory

2. **Naming conventions:**
   - Use descriptive names: `claude_code_primer.md` not `guide.md`
   - Use underscores: `prompt_engineering.md` not `prompt-engineering.md`
   - Include topic: `ollama_study_guide.md` not `study_guide.md`

3. **Content structure:**
   - Start with clear purpose statement
   - Use table of contents for long documents
   - Include practical examples
   - Cross-reference related docs with wiki-style links
   - Date time-sensitive content

4. **Markdown style:**
   - Use ATX headers (`#`, `##`, `###`)
   - Code blocks with language identifiers
   - Tables for structured comparisons
   - Bullet lists for concepts, numbered lists for procedures

### When Updating Existing Documentation

1. **Read the file first** - Always read before editing
2. **Maintain tone and style** - Match existing documentation patterns
3. **Preserve structure** - Don't reorganize without clear improvement
4. **Update dates** - Add "Last Updated" timestamp if not present
5. **Cross-references** - Update related documentation links if structure changes

## Key Files

### Central Hub Files
- **_MOC_AI.md** - Map of Content for navigating AI resources
- **How_My_Projects_Fit_Together.md** - Daniel Miessler-inspired philosophy
- **promptEngineering_PRIMER.md** - General prompt engineering guide

### Claude-Specific Documentation
- **CLAUDE/README.md** - Claude documentation hub overview
- **CLAUDE/how-to/claude_code_primer.md** - Comprehensive Claude Code guide
- **CLAUDE/agent_sdk_guide.md** - Agent SDK reference
- **CLAUDE/api_guide.md** - Claude API documentation
- **CLAUDE/examples/recommended_claude_agents.md** - Agent recommendations

### Other Tool Documentation
- **OLLAMA/OLLAMA_STUDY_GUIDE_PRIMER.md** - Local LLM management
- **GEMINI/geminiStudy.md** - Gemini CLI mastery
- **OPENCODE/opencode-primer.md** - OpenCode "second brain" tool
- **fabric/helpFabric.md** - Fabric framework introduction

## Python Scripts

Small analysis utilities exist in subdirectories:

**CLAUDE/CLAUDE-2025-11-12-17-26-20-batch-0000/**
- `analyze_themes.py` - Extract themes from conversation exports
- `create_mindmap.py` - Generate mindmaps from conversations
- `create_network_graph.py` - Visualize conversation networks
- `Bilan/analyze_electrolyte_themes.py` - Business-specific analysis
- `Bilan/isolate_electrolyte_conversations.py` - Filter conversations

**Dependencies:** Standard library only (json, collections, argparse, etc.)
**Usage:** Direct execution with Python 3.7+
**Purpose:** One-off analysis of Claude conversation exports

## Integration with Broader Repository

This AI resources directory connects to:

1. **01_PROJECTS/BILAN/** - Uses Claude extensively for business/marketing
   - See: `BILAN/METAPROMPTS/` for AI agent instructions
   - See: `BILAN/MARKETING/RAG/` for Claude RAG systems
   - See: `BILAN/recommended_claude_agents.md` for project agents

2. **02_AREAS/Workflow_Automation/n8n/** - AI tool integrations
   - n8n workflows connect Claude, Ollama, and other AI tools
   - See: Root level `n8n_primer.md`

3. **02_AREAS/Software_Development/** - Learning resources
   - Claude Code used for software development learning
   - AI tools support coding education

4. **03_RESOURCES/Knowledge_Management/OPENCODE/** - Second brain system
   - OpenCode integrates with AI tools for knowledge capture

## Philosophy and Approach

This directory embodies Daniel Miessler's approach to AI integration:

1. **AI for Clarity** - Use AI to connect ideas and create purpose
2. **Tool Integration** - Fabric, Ollama, Claude work together
3. **Knowledge Capture** - Documentation as learning amplification
4. **Practical Application** - Guides focused on real-world usage

**Core principle:** Leverage AI to accelerate learning, automate tasks, and connect disparate knowledge.

## Common Tasks

### Updating Claude Documentation

The CLAUDE/ subdirectory is actively maintained. When updating:

1. Check existing structure (how-to/, patterns/, examples/)
2. Read related documentation to avoid duplication
3. Follow the hub structure defined in CLAUDE/README.md
4. Cross-reference other AI tools where relevant (Fabric, Ollama, etc.)

### Adding New AI Tool Documentation

When documenting a new AI tool:

1. Create tool directory: `[TOOL_NAME]/`
2. Create README.md with overview and structure
3. Add entry to `_MOC_AI.md`
4. Consider subdirectories: how-to/, patterns/, examples/
5. Include practical usage examples
6. Cross-reference existing tools where applicable

### Analyzing Conversation Exports

For Claude conversation analysis:

1. Export conversations as JSON from Claude.ai
2. Use scripts in `CLAUDE/CLAUDE-2025-11-12-17-26-20-batch-0000/`
3. Scripts are self-contained with minimal dependencies
4. Review script code before running on sensitive data

### Finding Specific Information

**Search patterns:**
- Tool capabilities: Grep "features" or "capabilities" in tool directory
- Step-by-step guides: Look in `[tool]/how-to/` subdirectories
- Usage examples: Check `[tool]/examples/` or look for "example" in docs
- Integration guides: Grep "integration" or "workflow" across directories
- Keyboard shortcuts: Files named `shortcut_keys.md`

## Notes for AI Assistants

When working in this directory:

1. **Context awareness** - Understand this is documentation, not code
2. **No over-engineering** - Avoid suggesting build systems, tests, CI/CD
3. **Respect structure** - Maintain the hub-based organization
4. **Cross-tool thinking** - Connect patterns across Claude, Fabric, Ollama, etc.
5. **Practical focus** - Prioritize actionable information over theory
6. **Multi-language support** - Spanish versions exist for some content (BILAN project)
7. **Philosophy alignment** - Reference Daniel Miessler's clarity-driven approach
8. **Knowledge capture** - Help maintain this as a learning resource

## Search and Navigation Patterns

**To find:**
- **How to use a tool:** `[tool]/how-to/` or `[tool]/*Study.md`
- **Tool examples:** `[tool]/examples/` or grep "example" in tool dir
- **API references:** `[tool]/api*.md` or `[tool]/*API*.md`
- **Shortcuts:** `[tool]/shortcut_keys.md`
- **Patterns:** `[tool]/patterns/` or grep "pattern" in docs
- **Integration guides:** Grep "integration" across multiple tool dirs

**Common navigation:**
1. Start at `_MOC_AI.md` for overview
2. Navigate to tool subdirectory
3. Read tool's README.md if present
4. Explore how-to/, patterns/, examples/ subdirectories
5. Cross-reference related tools

## Git Workflow

**Current branch:** main (also the primary branch)

**Typical commit style:**
- Lowercase, descriptive: "add claude documentation hub structure"
- Topic-focused: "veo", "sugar and NETWORKCHUCK"
- Grouped changes: "Alicia medical marketing VEO prompts and examples"

**When committing documentation:**
- Clear commit messages describing what was added/changed
- Group related documentation updates
- Use present tense: "add guide" not "added guide"

## Platform and Environment

- **OS:** macOS (Darwin 21.6.0)
- **Shell:** zsh with oh-my-zsh
- **Editor:** VSCode with spell checking (English + Spanish)
- **Python:** Version 3.7+ (for analysis scripts)
- **Git:** Version control for documentation versioning

## Additional Notes

- This directory is part of a larger PARA system at `/Users/ideaopedia/Documents/textDump/`
- Root-level CLAUDE.md exists with comprehensive PARA system guidance
- This local CLAUDE.md focuses specifically on AI resources directory
- When in doubt about broader repository structure, reference root CLAUDE.md
