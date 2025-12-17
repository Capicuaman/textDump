# Claude Code Keyboard Shortcuts

Comprehensive guide to keyboard shortcuts and input methods for Claude Code CLI.

## Essential Shortcuts

### Session Control

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Ctrl+C` | Cancel | Cancel current input or stop generation |
| `Ctrl+D` | Exit | Exit Claude Code session |
| `Ctrl+L` | Clear Screen | Clear terminal screen (preserves context) |
| `Esc + Esc` | Rewind | Rewind code/conversation to previous state |

### Display and Output

| Shortcut | Action | Description |
|----------|--------|-------------|
| `Ctrl+O` | Toggle Verbose | Toggle verbose output mode |
| `Ctrl+R` | Reverse Search | Search command history (readline-style) |

### Model and Permissions

| Shortcut (macOS) | Shortcut (Windows/Linux) | Action |
|------------------|--------------------------|--------|
| `Option+P` | `Alt+P` | Switch Model | Quick model selection dialog |
| `Shift+Tab` | `Alt+M` | Toggle Permission Mode | Cycle between permission modes |

### Media Input

| Shortcut (macOS/Linux) | Shortcut (Windows) | Action |
|------------------------|---------------------|--------|
| `Ctrl+V` | `Alt+V` | Paste Image | Paste image from clipboard |

## Multiline Input

Claude Code supports multiple ways to enter multiline input.

### Universal Method (Works Everywhere)

| Method | Shortcut |
|--------|----------|
| Backslash Escape | `\ + Enter` |

**Usage:**
```bash
> This is line one \
  and this continues on line two \
  and this is line three
```

### Platform-Specific Defaults

| Platform | Default Shortcut |
|----------|------------------|
| macOS | `Option+Enter` |
| Windows | `Alt+Enter` |
| Linux | `Alt+Enter` |

### After Terminal Setup

After running `/terminal-setup`:

| Method | Shortcut |
|--------|----------|
| Modern Terminal | `Shift+Enter` |

### Control Sequence

| Method | Shortcut | Description |
|--------|----------|-------------|
| Line Feed | `Ctrl+J` | Insert literal newline |

## History Navigation

### Command History

| Shortcut | Action |
|----------|--------|
| `Up Arrow` | Previous Command | Navigate to previous input |
| `Down Arrow` | Next Command | Navigate to next input |
| `Ctrl+R` | Reverse Search | Search through history |
| `Ctrl+S` | Forward Search | Forward incremental search |

**Reverse Search Usage:**
```bash
> (Ctrl+R)
(reverse-i-search)`auth': explain the authentication flow

# Type to search, Enter to execute, Ctrl+C to cancel
```

## Vim Mode

Enable Vim mode for advanced editing:

```bash
> /vim
# or
> vim on
```

### Vim Normal Mode

#### Navigation

| Key | Action |
|-----|--------|
| `h` | Move left |
| `j` | Move down |
| `k` | Move up |
| `l` | Move right |
| `w` | Next word |
| `e` | End of word |
| `b` | Previous word |
| `0` | Beginning of line |
| `$` | End of line |
| `gg` | Beginning of input |
| `G` | End of input |
| `{` | Previous paragraph |
| `}` | Next paragraph |

#### Editing

| Key | Action |
|-----|--------|
| `i` | Insert mode (before cursor) |
| `a` | Insert mode (after cursor) |
| `I` | Insert at beginning of line |
| `A` | Insert at end of line |
| `o` | Open new line below |
| `O` | Open new line above |
| `x` | Delete character |
| `dd` | Delete line |
| `D` | Delete to end of line |
| `cc` | Change line |
| `C` | Change to end of line |
| `yy` | Yank (copy) line |
| `p` | Paste after cursor |
| `P` | Paste before cursor |
| `.` | Repeat last change |
| `u` | Undo |
| `Ctrl+R` | Redo |

#### Visual Mode

| Key | Action |
|-----|--------|
| `v` | Visual character mode |
| `V` | Visual line mode |
| `Ctrl+V` | Visual block mode |

**In Visual Mode:**
| Key | Action |
|-----|--------|
| `d` | Delete selection |
| `y` | Yank (copy) selection |
| `c` | Change selection |

### Vim Insert Mode

| Key | Action |
|-----|--------|
| `Esc` | Return to Normal mode |
| `Ctrl+[` | Return to Normal mode (alternative) |
| `Ctrl+W` | Delete word backward |
| `Ctrl+U` | Delete to beginning of line |

## Quick Commands

Special prefixes for quick actions:

| Prefix | Action | Example |
|--------|--------|---------|
| `/` | Slash Command | `/help`, `/cost`, `/model` |
| `!` | Direct Bash | `!git status`, `!npm test` |
| `@` | File Reference | `@src/utils.js`, `@package.json` |
| `#` | Add to Memory | `#Always use TypeScript strict mode` |

**Examples:**
```bash
# Slash commands
> /context
> /cost
> /model opus

# Direct bash
> !ls -la
> !git log --oneline -5

# File references
> Explain @src/auth/login.js
> Compare @package.json with @package-lock.json

# Add to memory
> #This project uses PostgreSQL, not MongoDB
> #All functions must have TypeScript return types
```

## Background Task Management

### Running Tasks in Background

| Method | Action |
|--------|--------|
| `Ctrl+B` | Background | Send currently executing command to background |
| Add `&` | Background | Run command in background from start |

**Example:**
```bash
# Method 1: Start command, then Ctrl+B while running
> npm run build
(Press Ctrl+B to background)

# Method 2: Specify background at start
> npm run build &
```

### Managing Background Tasks

```bash
# List background tasks
> /bashes

# Check task output
> Show me output from task abc123

# Stop background task
> Kill task abc123
```

## Terminal Setup

Optimize your terminal for better Claude Code experience:

```bash
> /terminal-setup
```

This configures:
- `Shift+Enter` for multiline input
- Improved readline bindings
- Better history management
- Enhanced copy/paste

## Platform-Specific Notes

### macOS

**Option Key Configuration:**
- Ensure Option key is configured as "Meta" in terminal settings
- ITerm2: Preferences → Profiles → Keys → Left Option key: "Esc+"
- Terminal.app: Usually works by default

**Paste Image:**
- Copy image to clipboard (Cmd+C)
- In Claude Code: `Ctrl+V`

### Windows (WSL/PowerShell)

**Alt Key:**
- Alt key functions as Meta key
- May need terminal configuration

**Paste Image:**
- Copy image to clipboard
- In Claude Code: `Alt+V`

### Linux

**Alt Key Configuration:**
- Most terminals: Alt works as Meta by default
- Check terminal emulator settings if not working

**Paste Image:**
- Copy image with system clipboard
- In Claude Code: `Ctrl+V`

## IDE Integration Shortcuts

When using Claude Code with IDE integration:

```bash
# Open IDE integration
> /ide

# Enable integration
> /ide enable

# Check status
> /ide status
```

**IDE Commands:**
- Get diagnostics from VS Code
- Execute code in Jupyter
- Navigate to definitions
- See compiler errors in real-time

## Advanced Input Techniques

### Heredoc-Style Input

For large multiline inputs:

```bash
> Create a file with this content: \
Line 1 \
Line 2 \
Line 3
```

### Paste Mode

For pasting code without execution:

1. Start typing or paste
2. Claude detects multiline paste
3. Auto-enters paste mode
4. `Ctrl+D` or `Ctrl+C` to finish

### File Input

```bash
# Reference file in prompt
> Analyze this config: @config.yaml

# Read and use content
> Based on @package.json, what's our node version?
```

## Readline Commands

Claude Code uses GNU Readline, supporting standard readline shortcuts:

### Cursor Movement

| Shortcut | Action |
|----------|--------|
| `Ctrl+A` | Beginning of line |
| `Ctrl+E` | End of line |
| `Ctrl+F` | Forward one character |
| `Ctrl+B` | Backward one character |
| `Alt+F` | Forward one word |
| `Alt+B` | Backward one word |

### Editing

| Shortcut | Action |
|----------|--------|
| `Ctrl+K` | Kill (cut) to end of line |
| `Ctrl+U` | Kill to beginning of line |
| `Ctrl+W` | Kill previous word |
| `Alt+D` | Kill next word |
| `Ctrl+Y` | Yank (paste) killed text |
| `Ctrl+T` | Transpose characters |
| `Alt+T` | Transpose words |
| `Alt+U` | Uppercase word |
| `Alt+L` | Lowercase word |
| `Alt+C` | Capitalize word |

### History

| Shortcut | Action |
|----------|--------|
| `Ctrl+P` | Previous history |
| `Ctrl+N` | Next history |
| `Alt+<` | Beginning of history |
| `Alt+>` | End of history |
| `Ctrl+R` | Reverse search |
| `Ctrl+S` | Forward search |

## Customization

### Custom Keybindings

Create `~/.inputrc` for custom readline bindings:

```bash
# Example ~/.inputrc
set editing-mode vi  # Vim mode by default
set show-mode-in-prompt on
set vi-ins-mode-string \1\e[6 q\2  # Cursor shape for insert
set vi-cmd-mode-string \1\e[2 q\2  # Cursor shape for normal

# Custom bindings
"\C-f": forward-word
"\C-b": backward-word
```

### Shell Integration

Add to `~/.zshrc` or `~/.bashrc`:

```bash
# Alias for quick Claude start
alias c='claude'
alias cc='claude -c'  # Continue last session

# Function to start Claude with file context
clandef() {
    claude "@$1"
}
```

## Tips and Tricks

### Quick Tip 1: Rapid Fire Commands

```bash
# Chain commands with direct bash
> !npm test && echo "Tests passed!"

# Or use Claude's bash tool
> Run tests, and if they pass, commit the changes
```

### Quick Tip 2: Context-Aware History

```bash
# Search history by context
> (Ctrl+R)
(reverse-i-search)`test': run the test suite and fix failures

# Reuse with modification
> [Edit command and run]
```

### Quick Tip 3: Efficient File References

```bash
# Multiple file references
> Compare @src/old.js with @src/new.js and explain differences

# Glob patterns
> Find all @**/*.test.js files and summarize testing approach
```

### Quick Tip 4: Quick Model Switching

```bash
# For simple task
> (Option+P / Alt+P)
# Select: Haiku

> What's 2+2?

# Back to default
> (Option+P / Alt+P)
# Select: Sonnet
```

## Troubleshooting

### Shortcut Not Working

**Issue:** `Option+P` or `Alt+P` doesn't work

**Solutions:**
1. Check terminal Option/Alt key configuration
2. Use slash command instead: `/model`
3. Configure terminal to send escape sequences

**Issue:** `Shift+Enter` doesn't create newline

**Solutions:**
1. Run `/terminal-setup`
2. Use `\ + Enter` instead
3. Check terminal key bindings

**Issue:** Vim mode not activating

**Solutions:**
1. Check vim mode status: `/vim`
2. Enable explicitly: `vim on`
3. Add to settings for permanent: `.claude/settings.json`

### Copy/Paste Issues

**Issue:** Can't paste images

**Solutions:**
1. Verify image is in clipboard
2. Use correct shortcut for platform
3. Check terminal supports image protocol (iTerm2, WezTerm, etc.)

**Issue:** Paste executes immediately

**Solutions:**
1. Use multiline input method first
2. Enable bracketed paste in terminal
3. Use file references instead: `@file.txt`

## Quick Reference Card

```
═══════════════════════════════════════════════════════════════
CLAUDE CODE KEYBOARD SHORTCUTS - QUICK REFERENCE
═══════════════════════════════════════════════════════════════

SESSION CONTROL              MULTILINE INPUT
Ctrl+C  Cancel              \ + Enter    Universal
Ctrl+D  Exit                Shift+Enter  After /terminal-setup
Ctrl+L  Clear Screen        Option+Enter macOS default
Esc Esc Rewind             Alt+Enter    Win/Linux default

QUICK COMMANDS              NAVIGATION
/cmd    Slash command       ↑/↓          History
!cmd    Direct bash         Ctrl+R       Search history
@file   File reference      Ctrl+A/E     Start/End of line
#text   Add to memory       Alt+F/B      Word forward/back

MODEL & PERMISSIONS         VIM MODE (after /vim)
Option+P (Alt+P) Switch     i/a          Insert mode
Shift+Tab       Toggle      h/j/k/l      Navigation
                            dd/yy        Delete/Yank line
MEDIA                       u/Ctrl+R     Undo/Redo
Ctrl+V  Paste image         Esc          Normal mode

═══════════════════════════════════════════════════════════════
```

---

**Last Updated:** December 16, 2025
