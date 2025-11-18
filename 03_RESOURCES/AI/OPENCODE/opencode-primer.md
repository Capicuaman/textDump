# OpenCode Primer: Most Commonly Used Features

## Overview
OpenCode is an open-source AI coding agent built for the terminal that helps you write and run code directly from your command line. It's designed to be privacy-first, giving you control over your code and choice of AI providers.

## Installation
```bash
# Quick install
curl -fsSL https://opencode.ai/install | bash

# Or using npm
npm install -g opencode-ai

# Or using Homebrew (macOS/Linux)
brew install opencode
```

## Core Features

### 1. Terminal User Interface (TUI)
- **Native terminal UI** that's responsive and themeable
- **Multi-session support** - run multiple agents in parallel
- **LSP enabled** - automatically loads the right Language Server Protocol for your project
- **File fuzzy search** using `@` symbol to quickly find files

### 2. Authentication & Providers
- **75+ LLM providers** supported through Models.dev
- **Claude Pro integration** - use your Anthropic account directly
- **OpenCode Zen** - curated models tested specifically for coding agents
- **Local model support** for privacy-sensitive environments

### 3. Project Initialization
```bash
cd /path/to/project
opencode
/init  # Analyzes project and creates AGENTS.md
```

## Essential Commands & Usage

### Basic Workflow
1. **Navigate to project**: `cd your-project`
2. **Start OpenCode**: `opencode`
3. **Initialize**: `/init` (creates AGENTS.md file)
4. **Start coding**: Just type your requests

### Key Commands
- `/init` - Initialize project and create AGENTS.md
- `/undo` - Undo last changes
- `/redo` - Redo undone changes
- `/share` - Share conversation link with team
- `@filename` - Fuzzy search for files in project

### Mode Switching
- **Tab key** - Toggle between Plan mode and Build mode
- **Plan mode** - OpenCode suggests implementation without making changes
- **Build mode** - OpenCode directly implements changes

## Common Use Cases

### 1. Code Exploration
```
How is authentication handled in @packages/functions/src/api/index.ts
```

### 2. Feature Development
**Plan first approach:**
```
<TAB>  # Switch to Plan mode
When a user deletes a note, we'd like to flag it as deleted in the database.
Then create a screen that shows all the recently deleted notes.
From this screen, the user can undelete a note or permanently delete it.
``` 

**Then build:**
```
<TAB>  # Switch back to Build mode
Sounds good! Go ahead and make the changes.
```

### 3. Direct Changes
```
We need to add authentication to the /settings route. Take a look at how this is
handled in the /notes route in @packages/functions/src/notes.ts and implement
the same logic in @packages/functions/src/settings.ts
```

### 4. Code Refactoring
```
Can you refactor the function in @packages/functions/src/api/index.ts?
```

## Advanced Features

### Image Support
- **Drag and drop images** into terminal for reference
- OpenCode can scan and incorporate images into prompts
- Great for UI/UX implementation with design references

### Sharing & Collaboration
- **Share links** for any session
- **Team debugging** through shared conversations
- Conversations are private by default

### Customization
- **Themes** - Personalize the terminal UI
- **Keybinds** - Customize keyboard shortcuts
- **Code formatters** - Configure your preferred formatting
- **Custom commands** - Create your own commands
- **MCP servers** - Extend functionality with Model Context Protocol

## Privacy & Security
- **No code storage** - OpenCode doesn't store your code or context
- **Privacy-first design** - Suitable for sensitive environments
- **Open source** - Full control and transparency
- **Local model support** - Keep everything on your machine

## Tips for Effective Use

1. **Provide context** - Talk to OpenCode like a junior developer
2. **Use Plan mode** for complex features to review before implementation
3. **Reference existing code** using `@` symbol for consistency
4. **Commit AGENTS.md** to help OpenCode understand your project patterns
5. **Use images** for UI/UX work to show exactly what you want

## Integration
- **Works with any IDE** - OpenCode runs in terminal, pair with your favorite editor
- **Git integration** - Seamlessly works with version control
- **Multi-language support** - Works with any programming language

## Getting Help
- [Documentation](https://opencode.ai/docs)
- [Discord Community](https://opencode.ai/discord)
- [GitHub Issues](https://github.com/sst/opencode/issues)

---

*This primer covers the most commonly used features. For detailed configuration and advanced usage, refer to the official OpenCode documentation.*