# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **personal knowledge management system** (digital garden) organized using the PARA method (Projects, Areas, Resources, Archives). It serves as a comprehensive workspace for AI-assisted learning, project development, and knowledge capture across software development, AI tools, personal development, and business ventures.

### Philosophy

Inspired by Daniel Miessler's approach to using AI for clarity and purpose, this repository integrates AI tools deeply into workflows through frameworks like Fabric, Ollama, and n8n automation. The core principle is leveraging AI to connect ideas, automate tasks, and accelerate learning.

## Directory Structure (PARA Method)

```
textDump/
├── 00_INBOX/              # Temporary holding area for unprocessed notes and files
├── 01_PROJECTS/           # Active projects with specific goals and deadlines
│   ├── ALICIA/           # Educational project (phonics, bilingual learning)
│   ├── BILAN/            # Electrolyte powder business (comprehensive docs)
│   ├── CAR/              # Personal car-related project
│   ├── COOKING/          # Cooking project materials
│   ├── MUSIC/            # Music creation and live coding (Strudel, Moises, Koala)
│   └── NARANJOS/         # Project with inbox structure
├── 02_AREAS/             # Ongoing areas of responsibility (no end date)
│   ├── HOME-LAB/         # Home automation and lab projects
│   ├── Personal_Development/ # Personal growth and learning
│   ├── Software_Development/ # Software engineering learning paths
│   └── Workflow_Automation/  # n8n and automation workflows
├── 03_RESOURCES/         # Knowledge base on topics of interest
│   ├── AI/               # AI tools (Claude, ChatGPT, Ollama, Fabric, etc.)
│   ├── Design/           # FreeCAD, Inkscape resources
│   ├── Knowledge_Management/ # Logseq, OpenCode, second brain systems
│   ├── Software_Engineering/ # Python, Docker, Git, Security
│   ├── Terminal_And_Shell/   # tmux, zsh, fzf, dotfiles
│   └── Misc/             # Travel, YouTube transcripts, cooking notes
├── 04_ARCHIVES/          # Completed or inactive items
└── 05_JOURNAL/           # Daily notes and journal templates
```

## Key Organizational Principles

1. **Actionability-Based:** Items are organized by how actionable they are, not by traditional category hierarchies
2. **Just-in-Time Organization:** Information is organized when it becomes relevant to a project
3. **Interconnected Notes:** Wiki-style links (`[[note-name]]`) connect related concepts
4. **Multi-Language:** Content exists in both English and Spanish (especially in BILAN project)

## Major Projects

### BILAN (01_PROJECTS/BILAN/)

A comprehensive business repository for an electrolyte powder brand. This is **NOT a software project** - it's a content and knowledge management system.

**Structure:**
- `BUSINESS/` - Financial models, pricing, strategy
- `SALES/` - 12-part sales playbook, e-commerce guides
- `MARKETING/` - Campaigns, social media strategy, RAG systems, VEO video prompts
- `PRODUCT/` - Electrolyte science, ingredient documentation
- `BLOG/` - Astro static site
- `WEB/` - Website materials and SEO strategies
- `METAPROMPTS/` - AI agent instructions
- `PACKAGING/` - Product label designs (JSON format)

**Key Files:**
- `readme.md` - Project overview
- `GEMINI.md` - Comprehensive documentation
- `recommended_claude_agents.md` - AI agent recommendations
- `CLAUDE.md` - Claude Code-specific guidance (nested within BILAN)
- `MARKETING/RAG/faq.json` - FAQ database for AI systems
- `SALES/consolidated_sales_manual.md` - Complete sales playbook

**Important Note:** BILAN content is primarily Markdown (70+ files), JSON (data), and HTML/CSS.

**Astro Blog:**
- Located at: `BLOG/`
- Static site generator built with Astro
- Markdown-based content with component support
- Modern, fast static site generation

**AI Integration Points:**
- RAG system for customer support (`MARKETING/RAG/`)
- VEO video generation prompts (`MARKETING/VEO/`)
- Object-oriented marketing framework (`MARKETING/OOP/`)
- AI agent configurations (`.claude/agents/`)

### ALICIA (01_PROJECTS/ALICIA/)

Educational project focused on phonics, bilingual learning, and child education.

**Subprojects:**
- `monsterPhonics/` - Phonics curriculum
- `wordFlashcards/` - Vocabulary learning tools
- `MEDICAL/` - Medical terminology education
- `MATHS/` - Mathematics education
- `BUS/` - Educational bus-related content

**Key File:**
- `monsterPhonicsSchedule.md` - Detailed educational schedule

### MUSIC (01_PROJECTS/MUSIC/)

Music creation and live coding project focused on browser-based algorithmic composition and music production tools.

**Tools & Platforms:**
- `strudel/` - Strudel live coding environment documentation
- `moises.md` - Moises.ai music separation and practice tool
- `koalaSampler.md` - Koala Sampler iOS/Android app

**Strudel Resources:**
- `strudel/README.md` - Learning path and project overview
- `strudel/01_strudel_usage_primer.md` - Basic usage and fundamentals
- `strudel/02_strudel_live_performance_guide.md` - Live performance techniques
- `strudel/03_strudel_quick_reference.md` - Quick reference and cheat sheet

**About Strudel:**
Strudel is a browser-based live coding environment for music creation (JavaScript port of TidalCycles). No installation required - runs entirely in browser at [strudel.cc](https://strudel.cc/). Used for algorithmic composition, live performances, and Algorave events.

**Project Focus:**
- Live coding music performances
- Pattern-based composition
- Real-time algorithmic music generation
- Music production and practice tools

## Key Learning Resources

### AI & Machine Learning (03_RESOURCES/AI/)

- **Fabric** (`fabric/`) - Daniel Miessler's AI command framework
- **Ollama** (`OLLAMA/`) - Local LLM deployment and management
- **Claude** (`CLAUDE/`) - Claude-specific resources and patterns
- **OpenCode** (`OPENCODE/`) - Code automation and second brain tools
- **CrewAI, LangChain, Gradio** - AI frameworks and tools

### Software Development (02_AREAS/ & 03_RESOURCES/)

**Learning Roadmaps:**
- `02_AREAS/Software_Development/Back-End_Development_Learning_Roadmap.md`
- `02_AREAS/Software_Development/frontendRoadmap.md`

**Technical Resources:**
- `03_RESOURCES/Software_Engineering/PYTHON/` - Python development
- `03_RESOURCES/Software_Engineering/DOCKER/` - Container management
- `03_RESOURCES/Software_Engineering/git/` - Version control
- `03_RESOURCES/Software_Engineering/SECURITY/` - Security and red teaming

### Workflow Automation (02_AREAS/Workflow_Automation/)

- **n8n** (`n8n/`) - Workflow automation platform
  - `nodeTypes.md` - Node type documentation
  - `googleDocs.md` - Google Docs integration
  - `localFile.md` - Local file operations

### Terminal & Shell (03_RESOURCES/Terminal_And_Shell/)

- **tmux** (`tmux/`) - Terminal multiplexer guides
- **zsh/oh-my-zsh** - Shell configuration
- **fzf** - Fuzzy finder integration
- **dotfiles** - Configuration files

## Important Top-Level Files

- `_Digital_Garden_Overview.md` - Comprehensive overview of the repository's purpose and philosophy
- `PARA_Method_Benefits.md` - Explanation of the PARA organizational system
- `directory_organization_reference.md` - Quick reference for directory structure
- `n8n_primer.md` - n8n workflow automation primer
- `summarize_science_points.py` - Python script for extracting key points from JSON conversations

## Common Workflows

### Capturing New Information

1. Save to `00_INBOX/` (or project-specific inbox like `01_PROJECTS/BILAN/00_INBOX/`)
2. Process regularly: move to appropriate PARA location
3. Create wiki-style links to related notes
4. Add to relevant project documentation

### Working on Active Projects

1. Navigate to `01_PROJECTS/[project-name]/`
2. Review project readme or main documentation
3. Update relevant documentation as work progresses
4. Move completed projects to `04_ARCHIVES/`

### Learning New Technologies

1. Create notes in `03_RESOURCES/[category]/[technology]/`
2. Link to related resources and learning roadmaps
3. Create practical examples in appropriate project folders
4. Reference learning materials in daily journal (`05_JOURNAL/`)

### Content Creation for BILAN

1. **Marketing Content:** Add to `01_PROJECTS/BILAN/MARKETING/campaigns/[campaign-name]/`
2. **Social Media:** Use templates in `MARKETING/SOCIAL-MEDIA/`
3. **Product Info:** Update `PRODUCT/` and `MARKETING/RAG/` for FAQ-worthy content
4. **Sales Materials:** Follow 12-part playbook structure in `SALES/`
5. **AI Prompts:** Add to `METAPROMPTS/` or `MARKETING/VEO/`

## VSCode Configuration

**Settings:** `.vscode/settings.json`
- Spell checking enabled for English and Spanish (`"cSpell.language": "en,es-ES"`)

## Python Scripts

**summarize_science_points.py** (Root directory)
- Purpose: Extract key scientific points from Claude conversation JSON files
- Target: Electrolyte business conversations
- Extracts: Sodium, potassium, magnesium, formulation details
- Input: JSON conversation exports from Claude
- Output: Console summary with key points

## Git Workflow

**Current branch:** `main` (primary development branch)

**Recent commit patterns:**
- Lowercase, descriptive commit messages
- Topic-focused (e.g., "veo", "sugar and NETWORKCHUCK")
- Grouped related changes (e.g., "Alicia medical marketing VEO prompts and examples")

**Status Notes:**
- Modified files: Various documentation updates
- Untracked files: New metaprompts, social media guides, agent recommendations

**Startup Protocol:**
- At the start of each conversation, check GitHub sync status by running `git fetch origin && git status`
- Inform the user if the repository is behind, ahead, or out of sync with the remote
- If behind remote: offer to pull changes
- If ahead of remote: inform user they have unpushed commits
- If diverged: inform user and ask how to proceed
- Check for new Claude Code features and updates (search for latest releases and changelogs)
- If new features are found: inform the user and document them in `03_RESOURCES/AI/CLAUDE/` as a dated markdown file (e.g., `claude_code_[version]_features.md`)
- Update or create feature documentation with comprehensive details including use cases, configuration, and examples

## Dependencies

**Node.js (package.json):**
```json
{
  "dependencies": {
    "@anthropic-ai/claude-code": "^2.0.37"
  }
}
```

This is the ONLY software dependency in the root directory. Most content is static documentation.

## Working with This Repository

### When Searching for Information

1. **Use Grep for content search** - Most content is in Markdown
2. **Use Glob for file patterns** - Find files by name/extension
3. **Check project-specific CLAUDE.md** - Some projects (like BILAN) have their own guidance
4. **Reference README files** - Many directories have README.md for context

### When Creating New Content

1. **Maintain PARA structure** - Put items in the right category
2. **Use existing patterns** - Match tone, style, and format of similar files
3. **Create bidirectional links** - Use `[[wiki-links]]` to connect related notes
4. **Consider language** - Add Spanish versions where appropriate (especially BILAN)
5. **Avoid duplication** - Check if similar content exists before creating new files

### When Working with BILAN

1. **Read BILAN's CLAUDE.md first** - Project-specific guidance at `01_PROJECTS/BILAN/CLAUDE.md`
2. **No traditional dev workflow** - This is content management, not software development
3. **Update RAG systems** - Add FAQ-worthy information to `MARKETING/RAG/faq.json`
4. **Respect content taxonomy** - Business/Sales/Marketing/Product are distinct domains
5. **Validate scientific claims** - Product documentation should be accurate and referenced

### When Using AI Tools

1. **Fabric patterns** - Reference `03_RESOURCES/AI/fabric/` and `03_RESOURCES/AI/FABRIC_PATTERNS/`
2. **Ollama** - Check `03_RESOURCES/AI/OLLAMA/OLLAMA_STUDY_GUIDE_PRIMER.md`
3. **Prompt engineering** - See `03_RESOURCES/AI/promptEngineering_PRIMER.md`
4. **OpenCode (second brain)** - Reference `03_RESOURCES/Knowledge_Management/OPENCODE/`

## Notes for AI Assistants

- This is a **knowledge management system**, not a traditional software project
- Focus on content organization, accuracy, and interconnections
- Respect the PARA method - don't reorganize without understanding the system
- Multi-language support is important (English/Spanish)
- BILAN project is extensive and has its own documentation structure
- Scientific accuracy matters, especially for health-related content (BILAN)
- The user leverages AI tools extensively - be familiar with Fabric, Ollama, n8n
- Personal development and learning are core themes - support growth-oriented tasks

## Search Patterns

**To find specific content types:**
- Learning roadmaps: `02_AREAS/Software_Development/*Roadmap.md`
- AI tool documentation: `03_RESOURCES/AI/[tool-name]/`
- BILAN marketing: `01_PROJECTS/BILAN/MARKETING/`
- MUSIC resources: `01_PROJECTS/MUSIC/strudel/`
- Scripts and code: Python files in root or project directories
- Configuration: `.vscode/`, `.claude/`, dotfiles in `03_RESOURCES/Terminal_And_Shell/dotfiles/`

**To find by topic:**
- Use Grep with relevant keywords
- Check `03_RESOURCES/` for reference materials
- Check `02_AREAS/` for ongoing learning/development
- Check `01_PROJECTS/` for active implementation

## Platform Compatibility

- **OS:** macOS (Darwin 21.6.0)
- **Shell:** zsh (oh-my-zsh configured)
- **Terminal:** Konsole configuration available
- **Editor:** VSCode (configuration in `.vscode/`)
- **Version Control:** Git (repository root)
