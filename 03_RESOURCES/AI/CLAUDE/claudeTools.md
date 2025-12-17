# Claude Code Tools

This document provides a comprehensive list of available tools in Claude Code CLI, with detailed explanations and usage examples.

---

## File Operations

### `Read`

Reads file contents from the local filesystem. Can handle text files, images, PDFs, and Jupyter notebooks.

**Permission Required:** No

**Parameters:**
- `file_path` (required): Absolute path to the file
- `offset` (optional): Line number to start reading from
- `limit` (optional): Number of lines to read

**Examples:**
```bash
# Read entire file
@/Users/ideaopedia/Documents/project/src/utils.py

# Reference from conversation
> Explain what @src/utils.py does

# Read specific range (for large files)
Read file from line 100 to 200
```

**Supported Formats:**
- Text files (.txt, .md, .json, etc.)
- Source code (all languages)
- Images (.png, .jpg, .gif, .webp)
- PDFs (.pdf) - extracted page by page
- Jupyter notebooks (.ipynb) - with cell outputs

---

### `Write`

Creates a new file or completely overwrites an existing file.

**Permission Required:** Yes

**Parameters:**
- `file_path` (required): Absolute path where file will be written
- `content` (required): Complete file content

**Examples:**
```bash
> Create a new Python file with a hello world function

# Claude uses Write tool
Write(
  file_path="/Users/ideaopedia/Documents/project/hello.py",
  content="def hello_world():\n    print('Hello, World!')\n"
)
```

**Best Practices:**
- Avoid using Write for existing files; prefer Edit for modifications
- Always read a file before writing to it if it exists
- Claude will prompt for permission before creating files

---

### `Edit`

Makes targeted edits to specific sections of existing files using exact string replacement.

**Permission Required:** Yes

**Parameters:**
- `file_path` (required): Absolute path to the file to modify
- `old_string` (required): Exact text to replace (must be unique)
- `new_string` (required): Text to replace it with
- `replace_all` (optional): Replace all occurrences (default: false)

**Examples:**
```bash
# Simple edit
Edit(
  file_path="/Users/ideaopedia/Documents/project/config.py",
  old_string="DEBUG = False",
  new_string="DEBUG = True"
)

# Multi-line edit with context
Edit(
  file_path="/Users/ideaopedia/Documents/project/utils.py",
  old_string="def calculate(x, y):\n    return x + y",
  new_string="def calculate(x, y):\n    \"\"\"Add two numbers.\"\"\"\n    return x + y"
)

# Replace all occurrences
Edit(
  file_path="/Users/ideaopedia/Documents/project/app.py",
  old_string="oldVariableName",
  new_string="newVariableName",
  replace_all=True
)
```

**Important Notes:**
- `old_string` must match exactly, including indentation
- If string is not unique, edit will fail
- Preserve line number prefixes exactly as shown by Read tool
- Claude always reads file before editing

---

### `Glob`

Finds files matching glob patterns (like Unix `find` command).

**Permission Required:** No

**Parameters:**
- `pattern` (required): Glob pattern to match files
- `path` (optional): Directory to search in (defaults to current working directory)

**Pattern Syntax:**
- `*` - Match any characters except `/`
- `**` - Match any characters including `/` (recursive)
- `?` - Match single character
- `[abc]` - Match any character in brackets
- `{a,b}` - Match either a or b

**Examples:**
```bash
# Find all JavaScript files recursively
Glob(pattern="**/*.js")

# Find all Python files in src directory
Glob(pattern="src/**/*.py")

# Find config files
Glob(pattern="**/config/*.json")

# Find test files
Glob(pattern="**/*test*.{js,ts,jsx,tsx}")

# Find all markdown files in specific directory
Glob(pattern="*.md", path="/Users/ideaopedia/Documents/project/docs")
```

**Use Cases:**
- Discovering project structure
- Finding files before reading them
- Locating all files of specific type
- Pattern-based file operations

---

### `Grep`

Searches file contents using regex patterns (built on ripgrep).

**Permission Required:** No

**Parameters:**
- `pattern` (required): Regular expression pattern to search
- `path` (optional): File or directory to search
- `glob` (optional): Filter files (e.g., "*.js")
- `type` (optional): File type filter (e.g., "py", "js", "rust")
- `output_mode` (optional): "content" (matching lines), "files_with_matches" (paths only), "count" (match counts)
- `-i` (optional): Case insensitive search
- `-A` (optional): Show N lines after match
- `-B` (optional): Show N lines before match
- `-C` (optional): Show N lines before and after match
- `multiline` (optional): Enable multiline pattern matching

**Examples:**
```bash
# Find all functions named 'authenticate'
Grep(pattern="function authenticate", output_mode="files_with_matches")

# Case-insensitive search with context
Grep(
  pattern="error",
  -i=True,
  -C=3,
  output_mode="content"
)

# Search only Python files
Grep(pattern="class\\s+\\w+", type="py", output_mode="content")

# Search with glob filter
Grep(pattern="TODO", glob="src/**/*.{js,ts}", output_mode="content")

# Find imports in JavaScript files
Grep(pattern="^import.*from", glob="**/*.js", output_mode="content")

# Multiline search (e.g., find multi-line comments)
Grep(
  pattern="/\\*[\\s\\S]*?\\*/",
  glob="**/*.js",
  multiline=True,
  output_mode="content"
)

# Count matches per file
Grep(pattern="console\\.log", type="js", output_mode="count")
```

**Pattern Tips:**
- Use `\\` to escape special regex characters
- `.` matches any character (except newline by default)
- `.*` matches any number of characters
- `^` matches start of line, `$` matches end
- `\\s` matches whitespace, `\\w` matches word characters

---

## Terminal Operations

### `Bash`

Executes shell commands in a persistent shell session.

**Permission Required:** Yes

**Parameters:**
- `command` (required): Shell command to execute
- `description` (optional): Clear description of what command does
- `timeout` (optional): Timeout in milliseconds (default: 120000ms / 2 minutes, max: 600000ms / 10 minutes)
- `run_in_background` (optional): Run command in background
- `dangerouslyDisableSandbox` (optional): Override sandbox mode

**Examples:**
```bash
# Run tests
Bash(
  command="npm test",
  description="Run test suite"
)

# Git operations (chained with &&)
Bash(
  command="git add . && git commit -m 'Fix authentication bug'",
  description="Stage and commit changes"
)

# Check status
Bash(
  command="git status",
  description="Check git repository status"
)

# Long-running background task
Bash(
  command="npm run build",
  description="Build production bundle",
  run_in_background=True
)

# File paths with spaces (use quotes)
Bash(
  command='cd "/Users/ideaopedia/My Documents" && ls',
  description="List files in directory with spaces"
)
```

**Best Practices:**
- Use `&&` to chain dependent commands
- Use `;` for independent commands where failure is ok
- Always quote file paths with spaces
- Prefer specialized tools (Read, Edit) over bash equivalents (cat, sed)
- Use absolute paths or avoid `cd` to maintain working directory
- For git commits, use HEREDOC format for commit messages

**Environment Notes:**
- Working directory persists across commands
- Environment variables do NOT persist (use `;` or `&&` in single command)
- Set `CLAUDE_BASH_MAINTAIN_PROJECT_WORKING_DIR=1` to reset directory

---

### `BashOutput` / `TaskOutput`

Retrieves output from background tasks.

**Permission Required:** No

**Parameters:**
- `task_id` (required): ID of background task
- `block` (optional): Wait for completion (default: true)
- `timeout` (optional): Max wait time in milliseconds

**Examples:**
```bash
# Get output from background task
TaskOutput(task_id="abc123", block=True, timeout=30000)

# Check status without waiting
TaskOutput(task_id="xyz789", block=False)
```

---

### `KillShell`

Kills a running background bash shell.

**Permission Required:** No

**Parameters:**
- `shell_id` (required): ID of the shell to kill

**Examples:**
```bash
# Stop a long-running background task
KillShell(shell_id="abc123")
```

---

## Web Integration

### `WebSearch`

Performs web searches to retrieve current information.

**Permission Required:** Yes

**Parameters:**
- `query` (required): Search query (minimum 2 characters)
- `allowed_domains` (optional): Only include results from these domains
- `blocked_domains` (optional): Exclude results from these domains

**Examples:**
```bash
# Simple search
WebSearch(query="Python asyncio tutorial 2025")

# Domain-filtered search
WebSearch(
  query="React hooks best practices",
  allowed_domains=["react.dev", "stackoverflow.com"]
)

# Block specific domains
WebSearch(
  query="machine learning frameworks",
  blocked_domains=["ads.example.com", "spam-site.com"]
)
```

**Important Notes:**
- Always include year in queries for current information (e.g., "2025")
- Web search is only available in US region
- Results include markdown hyperlinks
- Must cite sources in responses

---

### `WebFetch`

Fetches and processes content from URLs.

**Permission Required:** Yes

**Parameters:**
- `url` (required): Fully-formed valid URL
- `prompt` (required): What information to extract from the page

**Examples:**
```bash
# Fetch and summarize documentation
WebFetch(
  url="https://platform.claude.com/docs",
  prompt="Extract the authentication section and summarize setup steps"
)

# Analyze API responses
WebFetch(
  url="https://api.github.com/repos/anthropics/claude-code",
  prompt="What is the current star count and latest release version?"
)

# Fetch multiple pages (Claude can do this in parallel)
WebFetch(url="https://example.com/page1", prompt="Extract key points")
WebFetch(url="https://example.com/page2", prompt="Extract key points")
```

**Notes:**
- HTTP URLs auto-upgrade to HTTPS
- Handles redirects automatically (Claude will inform you)
- 15-minute cache for repeated requests
- HTML converted to markdown for processing

---

## Task Management

### `Task`

Launches specialized subagents for complex, multi-step tasks.

**Permission Required:** No (subagent may require permissions)

**Parameters:**
- `subagent_type` (required): Type of agent to launch
- `prompt` (required): Task for the agent to perform
- `description` (required): Short 3-5 word description
- `model` (optional): "sonnet", "opus", or "haiku"
- `resume` (optional): Agent ID to resume from previous execution
- `run_in_background` (optional): Run agent in background

**Available Subagent Types:**

| Type | Purpose | Tools Available |
|------|---------|----------------|
| `Explore` | Fast codebase exploration | All tools (read-only preferred) |
| `Plan` | Software architecture planning | All tools |
| `general-purpose` | Multi-step complex tasks | All tools |
| `claude-code-guide` | Claude Code documentation lookup | Read, WebFetch, WebSearch |

**Examples:**
```bash
# Explore codebase
Task(
  subagent_type="Explore",
  prompt="Find all API endpoints and explain how authentication works",
  description="Explore authentication system"
)

# Plan implementation
Task(
  subagent_type="Plan",
  prompt="Design an implementation plan for adding dark mode to the application",
  description="Plan dark mode feature"
)

# Complex research
Task(
  subagent_type="general-purpose",
  prompt="Search for all deprecated API usage and suggest modern alternatives",
  description="Find deprecated API usage"
)

# Resume previous agent
Task(
  subagent_type="Explore",
  prompt="Now check the payment processing module",
  description="Continue codebase exploration",
  resume="previous-agent-id"
)

# Run in background
Task(
  subagent_type="general-purpose",
  prompt="Generate comprehensive documentation for all public APIs",
  description="Generate API documentation",
  run_in_background=True
)
```

**When to Use:**
- Multi-step tasks requiring multiple tool calls
- Open-ended searches across many files
- Complex analysis requiring exploration
- Tasks where you want specialized behavior

**When NOT to Use:**
- Reading specific known file path (use Read instead)
- Searching for specific class (use Glob instead)
- Searching within 2-3 known files (use Read instead)

---

## Specialized Tools

### `NotebookEdit`

Modifies Jupyter notebook (.ipynb) cells.

**Permission Required:** Yes

**Parameters:**
- `notebook_path` (required): Absolute path to .ipynb file
- `new_source` (required): New cell content
- `cell_id` (optional): ID of cell to edit
- `cell_type` (optional): "code" or "markdown"
- `edit_mode` (optional): "replace", "insert", or "delete"

**Examples:**
```bash
# Replace cell content
NotebookEdit(
  notebook_path="/Users/ideaopedia/Documents/analysis.ipynb",
  cell_id="abc123",
  new_source="import pandas as pd\ndf = pd.read_csv('data.csv')",
  edit_mode="replace"
)

# Insert new cell
NotebookEdit(
  notebook_path="/Users/ideaopedia/Documents/analysis.ipynb",
  new_source="# Data Analysis\nThis notebook analyzes sales data.",
  cell_type="markdown",
  edit_mode="insert"
)

# Delete cell
NotebookEdit(
  notebook_path="/Users/ideaopedia/Documents/analysis.ipynb",
  cell_id="xyz789",
  new_source="",
  edit_mode="delete"
)
```

---

### `mcp__ide__getDiagnostics`

Gets language diagnostics from VS Code.

**Permission Required:** No

**Parameters:**
- `uri` (optional): File URI to get diagnostics for

**Examples:**
```bash
# Get all diagnostics
mcp__ide__getDiagnostics()

# Get diagnostics for specific file
mcp__ide__getDiagnostics(uri="file:///path/to/file.ts")
```

---

### `mcp__ide__executeCode`

Executes Python code in Jupyter kernel.

**Permission Required:** Yes

**Parameters:**
- `code` (required): Python code to execute

**Examples:**
```bash
# Execute Python code
mcp__ide__executeCode(code="import numpy as np\nprint(np.mean([1,2,3,4,5]))")

# Multiple statements
mcp__ide__executeCode(code="x = 10\ny = 20\nprint(f'Sum: {x + y}')")
```

---

## User Interaction

### `AskUserQuestion`

Asks the user multiple-choice questions.

**Permission Required:** No

**Parameters:**
- `questions` (required): Array of question objects (1-4 questions)
  - `question`: The question text
  - `header`: Short label (max 12 chars)
  - `options`: Array of 2-4 options with label and description
  - `multiSelect`: Allow multiple selections (default: false)

**Examples:**
```bash
# Single choice question
AskUserQuestion(
  questions=[{
    "question": "Which testing framework should we use?",
    "header": "Framework",
    "multiSelect": False,
    "options": [
      {
        "label": "Jest (Recommended)",
        "description": "Popular, fast, built-in mocking"
      },
      {
        "label": "Vitest",
        "description": "Vite-native, very fast"
      },
      {
        "label": "Mocha",
        "description": "Flexible, mature ecosystem"
      }
    ]
  }]
)

# Multiple choice question
AskUserQuestion(
  questions=[{
    "question": "Which features should we implement?",
    "header": "Features",
    "multiSelect": True,
    "options": [
      {"label": "Authentication", "description": "User login system"},
      {"label": "Dark mode", "description": "Theme switching"},
      {"label": "Analytics", "description": "Usage tracking"}
    ]
  }]
)
```

---

### `TodoWrite`

Creates and manages task lists for tracking progress.

**Permission Required:** No

**Parameters:**
- `todos` (required): Array of todo objects
  - `content`: Task description (imperative form)
  - `activeForm`: Present continuous form
  - `status`: "pending", "in_progress", or "completed"

**Examples:**
```bash
# Create initial todo list
TodoWrite(todos=[
  {
    "content": "Read authentication module",
    "activeForm": "Reading authentication module",
    "status": "pending"
  },
  {
    "content": "Identify security vulnerabilities",
    "activeForm": "Identifying security vulnerabilities",
    "status": "pending"
  },
  {
    "content": "Fix identified issues",
    "activeForm": "Fixing identified issues",
    "status": "pending"
  }
])

# Update progress
TodoWrite(todos=[
  {
    "content": "Read authentication module",
    "activeForm": "Reading authentication module",
    "status": "completed"
  },
  {
    "content": "Identify security vulnerabilities",
    "activeForm": "Identifying security vulnerabilities",
    "status": "in_progress"
  },
  {
    "content": "Fix identified issues",
    "activeForm": "Fixing identified issues",
    "status": "pending"
  }
])
```

---

## Slash Commands

These commands are used to interact with Claude Code CLI directly (not tools, but user commands).

### Built-in Commands

| Command | Purpose |
|---------|---------|
| `/add-dir` | Add additional working directories |
| `/agents` | Manage custom subagents |
| `/bashes` | List and manage background tasks |
| `/bug` | Report bugs to Anthropic |
| `/clear` | Clear conversation history |
| `/compact` | Compact conversation to save tokens |
| `/config` | Open Settings interface |
| `/context` | Visualize context usage |
| `/cost` | Show token usage statistics |
| `/doctor` | Check Claude Code installation health |
| `/exit` | Exit the REPL |
| `/export` | Export conversation to file |
| `/help` | Get usage help |
| `/hooks` | Manage hook configurations |
| `/ide` | Manage IDE integrations |
| `/init` | Initialize project with CLAUDE.md |
| `/login` | Switch Anthropic accounts |
| `/logout` | Sign out from account |
| `/mcp` | Manage MCP servers |
| `/memory` | Edit CLAUDE.md memory files |
| `/model` | Select or change AI model |
| `/permissions` | View/update permissions |
| `/plugin` | Manage Claude Code plugins |
| `/resume` | Resume a conversation |
| `/rewind` | Rewind conversation and/or code |
| `/sandbox` | Enable sandboxed bash execution |
| `/stats` | View usage statistics |
| `/status` | Show version, model, account info |
| `/statusline` | Set up custom status line |
| `/todos` | List current TODO items |
| `/vim` | Enter vim mode for editing |

### Custom Slash Commands

Create project-specific commands in `.claude/commands/`:

```bash
# File: .claude/commands/review.md
Review this code for security vulnerabilities and performance issues.

# Usage in Claude Code:
/review
```

### MCP Slash Commands

MCP servers expose their prompts as slash commands:

```bash
# Pattern: /mcp__<server-name>__<prompt-name>
/mcp__github__list_prs
/mcp__github__pr_review 456
```

---

## Quick Command Reference

| Task | Command |
|------|---------|
| Read file | `@path/to/file` or `> read @file` |
| Find files | `> find all *.py files` |
| Search content | `> search for "function auth" in src/` |
| Edit file | `> update line 42 in utils.py to...` |
| Run command | `> run npm test` |
| Web search | `> search the web for...` |
| Create todo | `> create a todo list for...` |
| Ask question | `> ask me which framework to use` |
| Spawn agent | `> explore the authentication system` |

---

**Last Updated:** December 16, 2025
