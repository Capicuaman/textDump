# OpenCode Commands Guide

Comprehensive guide to OpenCode commands with examples and customization options.

---

## 🎯 Essential Commands

### `/init` - Initialize Project
**Purpose**: Analyzes your project and creates an `AGENTS.md` file for better context understanding.

**Usage**:
```
/init
```

**What it does**:
- Scans project structure and file types
- Identifies programming languages and frameworks
- Creates AGENTS.md with project-specific context
- Helps OpenCode understand your coding patterns

**When to use**: First time using OpenCode in a new project.

---

### `/undo` - Undo Last Changes
**Purpose**: Reverts the most recent changes made by OpenCode.

**Usage**:
```
/undo
```

**What it does**:
- Reverts file modifications
- Restores deleted files
- Returns to previous state
- Preserves your conversation context

**Pro tip**: Can be used multiple times to undo several changes.

---

### `/redo` - Redo Undone Changes
**Purpose**: Reapplies changes that were undone with `/undo`.

**Usage**:
```
/redo
```

**What it does**:
- Reapplies the last undone changes
- Works in sequence with undo operations
- Maintains conversation flow

**Use case**: When you undo something and want to restore it.

---

### `/share` - Share Conversation
**Purpose**: Creates a shareable link to your current OpenCode session.

**Usage**:
```
/share
```

**What it does**:
- Generates a unique URL
- Copies link to clipboard
- Allows team collaboration
- Preserves conversation context

**Privacy**: Conversations are private until explicitly shared.

---

## 🔍 Navigation & Search

### File Reference with `@`
**Purpose**: Quickly reference files in your project without typing full paths.

**Usage**:
```
How is authentication handled in @src/components/auth.js
```

**Features**:
- Fuzzy search for file names
- Auto-completion support
- Works with any file type
- Case-insensitive matching

**Advanced examples**:
```
@package.json              # Find package.json
@*.test.js               # Find all test files
@src/utils/*             # Reference all utils files
```

---

## 🎨 Customization Options

### Custom Commands
OpenCode allows you to create custom commands for repetitive tasks.

**Creating Custom Commands**:
1. Create a `.opencode/` folder in your project root
2. Add `commands.json` file
3. Define your custom commands

**Example commands.json**:
```json
{
  "commands": {
    "test": {
      "description": "Run all tests",
      "action": "npm test",
      "shortcut": "t"
    },
    "deploy": {
      "description": "Deploy to production",
      "action": "npm run deploy",
      "shortcut": "d"
    },
    "lint": {
      "description": "Run linter",
      "action": "npm run lint",
      "shortcut": "l"
    }
  }
}
```

**Using Custom Commands**:
```
/test        # or /t
/deploy      # or /d
/lint        # or /l
```

---

### Custom Themes
Personalize OpenCode's appearance with custom themes.

**Theme Structure**:
Create `.opencode/theme.json` in your project:

```json
{
  "name": "My Custom Theme",
  "colors": {
    "background": "#1a1a1a",
    "text": "#ffffff",
    "accent": "#00ff88",
    "border": "#333333",
    "selection": "#00ff8820"
  },
  "fonts": {
    "ui": "Fira Code",
    "code": "JetBrains Mono",
    "sizes": {
      "ui": 14,
      "code": 13
    }
  }
}
```

**Built-in Theme Switching**:
```
/theme dark      # Switch to dark theme
/theme light     # Switch to light theme
/theme auto      # Follow system theme
```

---

### Custom Keybindings
Configure keyboard shortcuts to match your workflow.

**Keybinding Configuration**:
Create `.opencode/keybindings.json`:

```json
{
  "keybindings": {
    "save": "Ctrl+S",
    "quit": "Ctrl+Q",
    "find": "Ctrl+F",
    "replace": "Ctrl+R",
    "goto_file": "Ctrl+P",
    "command_palette": "Ctrl+Shift+P",
    "toggle_terminal": "Ctrl+`",
    "split_horizontal": "Ctrl+H",
    "split_vertical": "Ctrl+V"
  }
}
```

**Common Keybinding Examples**:
```json
{
  "keybindings": {
    "vim_mode": "Ctrl+Shift+V",
    "emacs_mode": "Ctrl+Shift+E",
    "focus_editor": "Alt+1",
    "focus_terminal": "Alt+2",
    "focus_explorer": "Alt+3"
  }
}
```

---

## 🔧 Advanced Configuration

### Project-Specific Settings
Configure OpenCode behavior per project.

**Create `.opencode/config.json`**:
```json
{
  "project": {
    "name": "My Web App",
    "type": "web",
    "main_language": "javascript",
    "framework": "react"
  },
  "preferences": {
    "auto_save": true,
    "auto_format": true,
    "lint_on_save": true,
    "show_line_numbers": true,
    "word_wrap": true
  },
  "tools": {
    "linter": "eslint",
    "formatter": "prettier",
    "test_runner": "jest",
    "build_tool": "webpack"
  }
}
```

### Environment Variables
Set environment-specific configurations.

**Example `.opencode/env.json`**:
```json
{
  "development": {
    "api_url": "http://localhost:3000",
    "debug": true,
    "log_level": "verbose"
  },
  "production": {
    "api_url": "https://api.myapp.com",
    "debug": false,
    "log_level": "error"
  }
}
```

---

## 🚀 Workflow Automation

### Git Integration
Automate Git operations within OpenCode.

**Git Commands in OpenCode**:
```
/git status          # Check git status
/git add .           # Stage all changes
/git commit "message" # Commit with message
/git push            # Push to remote
/git pull            # Pull from remote
```

**Custom Git Workflows**:
```json
{
  "workflows": {
    "feature_branch": {
      "steps": [
        "git checkout -b feature/{name}",
        "git add .",
        "git commit -m 'feat: {message}'",
        "git push -u origin feature/{name}"
      ]
    },
    "hotfix": {
      "steps": [
        "git checkout main",
        "git pull",
        "git checkout -b hotfix/{name}",
        "git add .",
        "git commit -m 'fix: {message}'",
        "git push -u origin hotfix/{name}"
      ]
    }
  }
}
```

### Build & Deploy Automation
Set up automated build and deployment pipelines.

**Build Configuration**:
```json
{
  "build": {
    "commands": {
      "dev": "npm run dev",
      "build": "npm run build",
      "test": "npm run test",
      "lint": "npm run lint"
    },
    "triggers": {
      "on_save": ["lint"],
      "on_commit": ["test"],
      "on_push": ["build"]
    }
  },
  "deploy": {
    "provider": "netlify",
    "build_folder": "dist",
    "environment_variables": {
      "NODE_ENV": "production"
    }
  }
}
```

---

## 🎯 Productivity Tips

### Command Aliases
Create shortcuts for frequently used commands.

**Alias Configuration**:
```json
{
  "aliases": {
    "h": "help",
    "q": "quit",
    "w": "write",
    "r": "read",
    "f": "find",
    "c": "clear",
    "gs": "git status",
    "gc": "git commit",
    "gp": "git push"
  }
}
```

### Snippets
Define code snippets for quick insertion.

**Snippet Examples**:
```json
{
  "snippets": {
    "react_component": {
      "prefix": "rc",
      "body": [
        "import React from 'react';",
        "",
        "const {1} = () => {",
        "  return (",
        "    <div>",
        "      {2}",
        "    </div>",
        "  );",
        "};",
        "",
        "export default {1};"
      ],
      "description": "React functional component"
    },
    "for_loop": {
      "prefix": "for",
      "body": ["for (let {1} = 0; {1} < {2}; {1}++) {", "  {3}"],
      "description": "For loop"
    }
  }
}
```

**Using Snippets**:
```
Type 'rc' + Tab  # Inserts React component
Type 'for' + Tab  # Inserts for loop
```

---

## 🔍 Search & Navigation Tips

### Advanced File Search
Use patterns and operators for precise file searching.

**Search Patterns**:
```
@src/**/*.js           # All JS files in src
@*.test.*             # All test files
@package.json           # Exact file match
@readme*              # Files starting with 'readme'
@config/**/*.{js,json} # JS and JSON files in config
```

**Content Search**:
```
find "function" in @src/utils/*.js    # Search for functions
find "TODO" in @**/*.{js,ts}     # Find all TODOs
find "import.*React" in @**/*.{js,jsx}  # React imports
```

### Quick Navigation
Jump between locations efficiently.

**Navigation Commands**:
```
/goto line:50           # Go to line 50
/goto function:myFunc   # Jump to function definition
/goto error:SyntaxError  # Go to error location
/back                  # Go back to previous location
/forward               # Go forward in history
```

---

## 🛠️ Tool Integration

### LSP Integration
Enhance code intelligence with Language Server Protocol.

**LSP Configuration**:
```json
{
  "lsp": {
    "javascript": {
      "server": "typescript-language-server",
      "settings": {
        "typescript.preferences.importModuleSpecifier": "relative"
      }
    },
    "python": {
      "server": "pylsp",
      "settings": {
        "pylsp.plugins.pycodestyle.enabled": true
      }
    }
  }
}
```

### External Tools
Integrate your favorite development tools.

**Tool Integration Examples**:
```json
{
  "external_tools": {
    "docker": {
      "command": "docker",
      "integration": "terminal"
    },
    "postman": {
      "command": "postman",
      "integration": "external"
    },
    "figma": {
      "command": "figma",
      "integration": "desktop"
    }
  }
}
```

---

## 📚 Learning Resources

### Command Reference
- `/help` - Show all available commands
- `/commands` - List custom commands
- `/settings` - Open configuration
- `/themes` - List available themes
- `/shortcuts` - Show keybindings

### Configuration Files Location
- Project config: `.opencode/config.json`
- Commands: `.opencode/commands.json`
- Themes: `.opencode/theme.json`
- Keybindings: `.opencode/keybindings.json`
- Snippets: `.opencode/snippets.json`

---

*This guide covers the most commonly used OpenCode commands and customization options. For the most up-to-date information, check the official OpenCode documentation.*