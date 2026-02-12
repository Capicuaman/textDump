# Claude Code Migration Strategy Guide

**Date:** 2026-02-10
**Purpose:** Maintain uniform Claude Code configuration across multiple machines

---

## 🎯 Executive Summary

To maintain a consistent Claude Code experience across machines, you need to version control:
1. **Skills** (`.claude/skills/`)
2. **Agents** (`.claude/agents/`)
3. **Project Instructions** (`CLAUDE.md`, project-specific `CLAUDE.md` files)
4. **Keybindings** (`.claude/keybindings.json`)
5. **Shared Settings** (`.claude/settings.json` - NOT `.local`)
6. **Auto Memory** (`.claude/memory/` - selective)
7. **Package Dependencies** (`package.json`, `package-lock.json`)

---

## 📁 File-by-File Breakdown

### ✅ VERSION CONTROL (Include in Git)

#### 1. `.claude/skills/` Directory
**What:** Custom slash commands for specific tasks
**Example:** `/process-inbox`, `/scale-recipe`
**Why:** These are workflow automation tools you've built
**Format:** Markdown files (`.md`)
**Current files:**
- `.claude/skills/process-inbox.md`
- `01_PROJECTS/COOKING/.claude/skills/scale-recipe.md`

**Migration action:**
```bash
# Already in git, just ensure no .gitignore excludes them
git add .claude/skills/
```

---

#### 2. `.claude/agents/` Directory
**What:** Custom AI agents with specialized behaviors
**Example:** Business-specific agents, domain experts
**Why:** These embody your custom workflows and expertise
**Format:** Markdown files (`.md`) with agent instructions
**Location:** Root `.claude/agents/` or project-specific (like `01_PROJECTS/BILAN/.claude/agents/`)

**Migration action:**
```bash
git add .claude/agents/
git add 01_PROJECTS/*/\.claude/agents/
```

---

#### 3. `CLAUDE.md` Files
**What:** Project instructions and context for Claude Code
**Why:** Core documentation that defines how Claude should work with your codebase
**Locations:**
- Root: `/CLAUDE.md` (main system instructions)
- Project-specific: `01_PROJECTS/BILAN/CLAUDE.md`, etc.

**Current status:** ✅ Already version controlled

**Migration action:**
```bash
# Verify they're tracked
git ls-files | grep CLAUDE.md
```

---

#### 4. `.claude/keybindings.json`
**What:** Custom keyboard shortcuts and chord bindings
**Why:** Productivity optimizations and muscle memory
**Format:** JSON configuration
**Example:**
```json
{
  "keybindings": [
    {
      "key": "ctrl+shift+p",
      "command": "process-inbox"
    }
  ]
}
```

**Migration action:**
```bash
# Add if it exists, create if it doesn't
git add .claude/keybindings.json
```

**Note:** This file may not exist yet if you haven't customized keybindings

---

#### 5. `.claude/settings.json` (NOT `.local`)
**What:** Shared, non-machine-specific settings
**Why:** Project defaults that should be consistent across machines
**Format:** JSON configuration
**Important:** This is different from `settings.local.json`

**Example content:**
```json
{
  "model": "sonnet",
  "features": {
    "autoMemory": true
  },
  "preferences": {
    "confirmDestructiveActions": true
  }
}
```

**Migration action:**
```bash
# Only if you want to share default settings
git add .claude/settings.json
```

**Current status:** Does NOT currently exist in your repo (optional)

---

#### 6. `.claude/memory/` Directory (Selective)
**What:** Auto memory files that persist learnings across sessions
**Files:**
- `MEMORY.md` - Core memories (loaded in every session)
- Topic-specific files (e.g., `debugging.md`, `patterns.md`)

**Why version control:**
- ✅ Project-specific patterns and conventions
- ✅ Architecture decisions
- ✅ User preferences for workflow

**Why NOT version control:**
- ❌ Session-specific context
- ❌ Machine-specific paths
- ❌ Temporary debugging notes

**Migration strategy:**
```bash
# Review memory files before committing
cat .claude/memory/MEMORY.md

# Add project-relevant memories
git add .claude/memory/MEMORY.md
git add .claude/memory/patterns.md
git add .claude/memory/conventions.md

# Exclude session-specific memories
echo ".claude/memory/temp_*.md" >> .gitignore
echo ".claude/memory/session_*.md" >> .gitignore
```

**Current status:** You have memory enabled but MEMORY.md is empty

---

#### 7. Package Dependencies
**What:** Node.js dependencies for Claude Code
**Files:**
- `package.json` - Dependency declarations
- `package-lock.json` - Locked versions

**Current content:**
```json
{
  "dependencies": {
    "@anthropic-ai/claude-code": "^2.0.37"
  }
}
```

**Migration action:**
```bash
git add package.json package-lock.json
```

**Current status:** ✅ Already version controlled

---

### ❌ DO NOT VERSION CONTROL (Exclude from Git)

#### 1. `.claude/settings.local.json`
**What:** Machine-specific settings and permissions
**Why:** Contains local paths, user-specific permissions, auth tokens
**Current content:**
```json
{
  "permissions": {
    "allow": [
      "Bash(git add:*)",
      "Read(//home/capicuaman/Documents/bilan-video/data/**)"
    ]
  }
}
```

**Exclusion action:**
```bash
# Add to .gitignore
echo ".claude/settings.local.json" >> .gitignore
git rm --cached .claude/settings.local.json
```

**Current status:** ⚠️ Currently tracked in git (should be excluded)

---

#### 2. `.claude/auth/` or Auth Tokens
**What:** Authentication credentials, API keys
**Why:** Security - never commit secrets
**Action:**
```bash
echo ".claude/auth/" >> .gitignore
echo ".claude/**/*token*" >> .gitignore
echo ".claude/**/*secret*" >> .gitignore
```

---

#### 3. `.claude/cache/` or Temp Files
**What:** Cached data, temporary processing files
**Why:** Regenerated automatically, bloats repository
**Action:**
```bash
echo ".claude/cache/" >> .gitignore
echo ".claude/temp/" >> .gitignore
```

---

#### 4. Machine-Specific Memory
**What:** Session logs, machine-specific debugging notes
**Why:** Not relevant to other machines
**Action:**
```bash
echo ".claude/memory/machine_*.md" >> .gitignore
echo ".claude/memory/sessions/" >> .gitignore
```

---

## 🚀 Migration Procedure

### New Machine Setup (Step-by-Step)

#### Step 1: Clone Repository
```bash
git clone <your-repo-url> ~/Documents/textDump
cd ~/Documents/textDump
```

#### Step 2: Install Node Dependencies
```bash
npm install
```

This installs `@anthropic-ai/claude-code@^2.0.37`

#### Step 3: Create Local Settings
```bash
# Create local settings for this machine
cat > .claude/settings.local.json << 'EOF'
{
  "permissions": {
    "allow": [
      "Bash(git add:*)",
      "Bash(git commit:*)",
      "WebSearch"
    ]
  }
}
EOF
```

Customize permissions as needed for this machine.

#### Step 4: Initialize Auto Memory
```bash
# Memory directory is already created, MEMORY.md is synced via git
# Add machine-specific notes if needed
cat > .claude/memory/machine_$(hostname).md << EOF
# Machine-Specific Notes for $(hostname)

- OS: $(uname -s)
- Date: $(date +%Y-%m-%d)
- Working directory: $(pwd)

## Local paths
- Projects: $HOME/Documents/textDump
EOF
```

#### Step 5: Verify Skills
```bash
# List available skills
ls -la .claude/skills/

# Expected output:
# - process-inbox.md
# Also check project-specific skills:
ls -la 01_PROJECTS/COOKING/.claude/skills/
# - scale-recipe.md
```

#### Step 6: Verify Agents
```bash
# Check if agents exist
ls -la .claude/agents/ 2>/dev/null || echo "No root agents yet"
ls -la 01_PROJECTS/BILAN/.claude/agents/ 2>/dev/null || echo "No BILAN agents yet"
```

#### Step 7: Test Claude Code
```bash
# Start Claude Code session
claude

# Test a skill
/process-inbox

# Verify CLAUDE.md is loaded (check system prompt includes PARA structure)
```

---

## 📋 Complete .gitignore for Claude Code

Add these lines to your `.gitignore`:

```gitignore
# Claude Code - Machine-specific files
.claude/settings.local.json
.claude/auth/
.claude/cache/
.claude/temp/
.claude/**/*token*
.claude/**/*secret*
.claude/**/*.log

# Claude Code - Session-specific memory
.claude/memory/machine_*.md
.claude/memory/session_*.md
.claude/memory/temp_*.md
.claude/memory/sessions/

# Node modules (should already be here)
node_modules/
```

---

## ✅ Version Control Checklist

Before pushing to git:

```bash
# 1. Check what's tracked
git ls-files | grep .claude

# Expected to see:
# ✅ .claude/skills/*.md
# ✅ .claude/agents/*.md (if they exist)
# ✅ .claude/memory/MEMORY.md
# ✅ .claude/keybindings.json (if customized)
# ❌ .claude/settings.local.json (should NOT be listed)

# 2. Check gitignore
cat .gitignore | grep claude

# 3. Add files
git add .claude/skills/
git add .claude/agents/
git add .claude/memory/MEMORY.md
git add .claude/keybindings.json
git add CLAUDE.md

# 4. Commit
git commit -m "Update Claude Code configuration"

# 5. Push
git push origin main
```

---

## 🔄 Ongoing Sync Strategy

### When You Create a New Skill
```bash
# On Machine A
# Create skill via Claude or manually
# Commit and push
git add .claude/skills/new-skill.md
git commit -m "Add new-skill for [purpose]"
git push

# On Machine B
git pull
# Skill is now available with /new-skill
```

### When You Update CLAUDE.md
```bash
# On any machine
git add CLAUDE.md
git commit -m "Update project instructions"
git push

# On other machines
git pull
# Claude Code automatically loads updated instructions
```

### When You Learn Something (Auto Memory)
```bash
# Claude automatically updates .claude/memory/MEMORY.md
# Review changes
git diff .claude/memory/MEMORY.md

# If valuable for all machines, commit
git add .claude/memory/MEMORY.md
git commit -m "Update auto memory with [topic] learnings"
git push

# If machine-specific, don't commit
# Keep it local in machine_*.md files
```

---

## 🏗️ Directory Structure Reference

```
textDump/
├── .claude/
│   ├── skills/                    # ✅ VERSION CONTROL
│   │   └── process-inbox.md
│   ├── agents/                    # ✅ VERSION CONTROL (if exists)
│   │   └── [custom-agents].md
│   ├── memory/                    # ⚠️ SELECTIVE
│   │   ├── MEMORY.md             # ✅ Version control
│   │   ├── patterns.md           # ✅ Version control
│   │   └── machine_*.md          # ❌ Local only
│   ├── settings.json             # ✅ VERSION CONTROL (optional, shared defaults)
│   ├── settings.local.json       # ❌ LOCAL ONLY (permissions, paths)
│   ├── keybindings.json          # ✅ VERSION CONTROL
│   ├── auth/                     # ❌ LOCAL ONLY (never commit)
│   ├── cache/                    # ❌ LOCAL ONLY (auto-generated)
│   └── temp/                     # ❌ LOCAL ONLY (auto-generated)
├── CLAUDE.md                      # ✅ VERSION CONTROL
├── package.json                   # ✅ VERSION CONTROL
├── package-lock.json              # ✅ VERSION CONTROL
├── .gitignore                     # ✅ VERSION CONTROL (with Claude exceptions)
└── 01_PROJECTS/
    ├── BILAN/
    │   ├── CLAUDE.md              # ✅ VERSION CONTROL
    │   └── .claude/
    │       ├── agents/            # ✅ VERSION CONTROL
    │       └── skills/            # ✅ VERSION CONTROL
    └── COOKING/
        └── .claude/
            └── skills/
                └── scale-recipe.md # ✅ VERSION CONTROL
```

---

## 🎓 Best Practices

### 1. Document Your Skills
Each skill should have:
- Clear description
- Usage examples
- Expected behavior
- Decision rules

See `.claude/skills/process-inbox.md` as template.

### 2. Separate Concerns
- **Project instructions** (CLAUDE.md) → General behavior and context
- **Skills** → Specific, reusable tasks
- **Agents** → Specialized AI personas
- **Memory** → Learned patterns and preferences

### 3. Test Before Committing
```bash
# On Machine A
# Create new skill
# Test it: /new-skill
# Verify it works
# Then commit

git add .claude/skills/new-skill.md
git commit -m "Add new-skill"
git push

# On Machine B
git pull
# Test again: /new-skill
# Ensure it works across machines
```

### 4. Use Semantic Versioning for Major Changes
```bash
# Tag significant Claude configuration updates
git tag -a claude-config-v1.0 -m "Initial Claude Code setup"
git push --tags

# Later, after major improvements
git tag -a claude-config-v2.0 -m "Added process-inbox skill and memory system"
git push --tags
```

### 5. Document Machine-Specific Setup
Create a `SETUP.md` in `.claude/` with:
- Required permissions for different OS
- Local path examples
- Integration notes (VSCode, terminal, etc.)

---

## 🔧 Troubleshooting

### Skills Not Appearing
```bash
# Check file location
ls -la .claude/skills/

# Check file format (must be .md)
file .claude/skills/*.md

# Restart Claude Code session
```

### Memory Not Syncing
```bash
# Check MEMORY.md exists
cat .claude/memory/MEMORY.md

# Check file size (max 200 lines loaded)
wc -l .claude/memory/MEMORY.md

# Verify it's tracked
git ls-files | grep MEMORY.md
```

### Settings Conflict
```bash
# Check which settings file exists
ls -la .claude/settings*.json

# Remember precedence:
# settings.local.json OVERRIDES settings.json

# Debug: View merged settings
# (Not directly available, but Claude Code uses this order)
```

### Permissions Not Working on New Machine
```bash
# Settings are in local file (not synced)
# Recreate .claude/settings.local.json manually
# Copy from old machine and adapt paths

# Example:
ssh old-machine "cat ~/Documents/textDump/.claude/settings.local.json" > /tmp/old-settings.json
# Edit /tmp/old-settings.json to update paths
cp /tmp/old-settings.json .claude/settings.local.json
```

---

## 📊 Migration Checklist

### Pre-Migration (Prepare on Current Machine)
- [ ] Ensure all skills are in `.claude/skills/`
- [ ] Document any agents in `.claude/agents/`
- [ ] Review `MEMORY.md` - keep only project-relevant content
- [ ] Create `.gitignore` entries for local files
- [ ] Test all skills work: `/process-inbox`, etc.
- [ ] Export `settings.local.json` separately (don't commit)
- [ ] Commit and push all changes
- [ ] Tag the commit: `git tag claude-migration-ready`

### Migration (On New Machine)
- [ ] Clone repository
- [ ] Run `npm install`
- [ ] Create `.claude/settings.local.json` (adapt from old machine)
- [ ] Test Claude Code starts: `claude`
- [ ] Verify `CLAUDE.md` is loaded (check context)
- [ ] Test each skill: `/process-inbox`, `/scale-recipe`
- [ ] Check memory works: `.claude/memory/MEMORY.md`
- [ ] Create machine-specific memory: `machine_$(hostname).md`
- [ ] Configure keybindings if needed
- [ ] Test read/write permissions with a simple task

### Post-Migration (Verify Everything Works)
- [ ] Run a full workflow (e.g., process inbox files)
- [ ] Commit something and verify git works
- [ ] Test WebSearch if enabled
- [ ] Test project-specific features (BILAN agents, etc.)
- [ ] Document any machine-specific issues
- [ ] Update this guide if you discover gaps

---

## 🎯 Quick Reference

### What Goes in Git?
✅ Skills, Agents, CLAUDE.md, keybindings.json, MEMORY.md, package.json

### What Stays Local?
❌ settings.local.json, auth tokens, cache, machine-specific memory

### How to Sync?
```bash
# Push from Machine A
git add .claude/skills/ .claude/agents/ .claude/memory/MEMORY.md
git commit -m "Update Claude config"
git push

# Pull on Machine B
git pull
```

### How to Create New Skill?
1. Create `.claude/skills/skill-name.md`
2. Follow format from `process-inbox.md`
3. Test with `/skill-name`
4. Commit and push
5. Pull on other machines

---

## 📚 Additional Resources

- **Claude Code Documentation:** Check for latest features at `claude.ai/code`
- **Skills Examples:** See `01_PROJECTS/COOKING/.claude/skills/scale-recipe.md`
- **Project Instructions:** Review root `CLAUDE.md` and `01_PROJECTS/BILAN/CLAUDE.md`
- **Auto Memory:** See `.claude/memory/MEMORY.md` (currently empty but enabled)

---

## 🔄 Version History

- **2026-02-10:** Initial migration strategy guide created
- **Next steps:** Test on second machine and update this guide with findings

---

## ⚡ Quick Start Commands

```bash
# On new machine, full setup:
git clone <repo> ~/Documents/textDump
cd ~/Documents/textDump
npm install
cat > .claude/settings.local.json << 'EOF'
{"permissions": {"allow": ["Bash(git add:*)", "Bash(git commit:*)", "WebSearch"]}}
EOF
claude

# To sync changes:
git pull  # Get latest skills/agents/instructions

# To share changes:
git add .claude/skills/ .claude/agents/ CLAUDE.md
git commit -m "Update Claude config"
git push
```

---

**End of Migration Strategy Guide**
