# OpenCode Power-User Tricks & Advanced Features

Based on OpenCode documentation research, here are the essential power-user tricks and advanced features for maximizing productivity.

## Essential Commands & Shortcuts

### Leader Key System
- **Default leader**: `Ctrl+X` (most advanced actions use this)
- Press leader first, then action key

### Critical Power Shortcuts
- `Tab` - Switch between Build/Plan agents instantly
- `@` - Fuzzy file search (type `@filename` to reference files)
- `!command` - Run bash commands inline (`!git status`, `!npm test`)
- `Ctrl+T` - Cycle through model variants (reasoning modes)
- `Ctrl+P` - Command palette
- `Ctrl+X + U` - Undo last action (reverts file changes via Git)
- `Ctrl+X + R` - Redo undone actions

### Advanced Agent System

#### Built-in Agents
- **Build** - Full access, default development agent
- **Plan** - Read-only, safe for exploration/analysis
- **@general** - Multi-step parallel task execution
- **@explore** - Fast codebase exploration (read-only)

#### Custom Agent Creation
Create specialized agents in `~/.config/opencode/agents/` or `.opencode/agents/`:

```yaml
---
description: "Code reviewer"
mode: subagent
model: anthropic/claude-sonnet-4-20250514
temperature: 0.1
tools:
  write: false
  edit: false
---
You are a code reviewer focusing on security and performance...
```

#### Agent Configuration Options
- **temperature**: Control randomness (0.0-1.0, lower = more focused)
- **mode**: `primary`, `subagent`, or `all`
- **tools**: Enable/disable specific tools
- **permissions**: Fine-grained control over actions
- **steps**: Limit maximum iterations for cost control
- **model**: Override default model per agent

## Power Workflow Features

### Session Management
- `Ctrl+X + L` - List/switch between sessions
- `Ctrl+X + N` - New session
- `Ctrl+X + G` - Session timeline
- `<Leader> + ←/→` - Navigate between parent/child sessions

### Advanced File Operations
- **File references**: `@src/components/Button.tsx` auto-includes content
- **Shell injection in commands**: `!npm test` includes output in prompts
- **Multi-file editing** with batch operations

### Custom Commands System
Create markdown files in `.opencode/commands/`:

```markdown
---
description: "Run tests with coverage"
agent: build
model: anthropic/claude-3-5-sonnet-20241022
---

Run full test suite with coverage and suggest fixes for failures.
!npm test --coverage
```

#### Command Features
- **Arguments**: Use `$ARGUMENTS` or positional parameters (`$1`, `$2`, etc.)
- **Shell output**: `!command` injects bash command results
- **File references**: `@filename` includes file content
- **Subtask control**: Force subagent invocation with `subtask: true`

## Advanced Configuration

### TUI Customization
```json
{
  "tui": {
    "scroll_acceleration": {"enabled": true},
    "scroll_speed": 5
  },
  "keybinds": {
    "leader": "ctrl+x",
    "agent_cycle": "tab"
  }
}
```

### Permission Control
```json
{
  "permission": {
    "bash": {
      "git push": "ask",
      "git *": "allow"
    },
    "edit": "deny"
  }
}
```

#### Permission Levels
- **allow** - Run without approval
- **ask** - Prompt for approval before running
- **deny** - Disable the tool entirely

### Editor Integration
Set up external editor for complex prompts:
```bash
export EDITOR="code --wait"  # For VS Code
export EDITOR="nvim"         # For Neovim
export EDITOR="nano"          # For nano
```

## Pro Tips & Workflows

### 1. Planning Mode Strategy
- Switch to Plan agent for code analysis without risk of changes
- Use Tab to toggle between agents based on task needs
- Plan agent has restricted permissions by default for safety

### 2. Subagent Workflows
- Use `@general` for complex multi-step tasks
- Use `@explore` for fast codebase navigation
- Navigate between parent/child sessions with `<Leader> + ←/→`

### 3. Template System
- Create custom commands for repetitive workflows
- Use shell injection for dynamic content
- Leverage file references for context

### 4. Session Management
- Multiple concurrent sessions for different contexts
- Session timeline for tracking work history
- Fork sessions for experimental work

### 5. Git Integration
- All changes tracked through Git automatically
- Undo/redo works at Git level
- Project must be a Git repository for undo/redo

### 6. Model Optimization
- `Ctrl+T` switches between reasoning/creative modes
- Different models for different tasks (fast vs. capable)
- Temperature control per agent

### 7. Advanced Keybinds
- Emacs-style text editing in prompt
- Word navigation with Alt+B/F
- Line manipulation with Ctrl+K/U

## Most Power-User Workflow

1. **Start in Plan mode** for exploration and analysis
2. **Use `@` file references heavily** for context
3. **Create custom commands** for common workflows
4. **Maintain multiple specialized agents** for different use cases
5. **Leverage session switching** for context isolation
6. **Use permission system** for safety in production codebases
7. **Master leader key combinations** for efficiency

## Key Insights

OpenCode is designed for terminal power users with:
- **vim-like workflows** and modal editing
- **Extensive customization** through configuration
- **Sophisticated agent orchestration** capabilities
- **Git-native** change management
- **Terminal-first** interface philosophy

The power comes from combining these features into workflows that match your development style and project needs.