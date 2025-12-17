# Claude Code Primer: Complete Guide to Mastery

A comprehensive guide to becoming proficient with Claude Code CLI, covering agents, skills, slash commands, hooks, MCP servers, and advanced workflows.

**Last Updated:** December 16, 2025
**Claude Code Version:** 2.0.37+
**Target Audience:** Developers seeking mastery of Claude Code capabilities

---

## Table of Contents

1. [What is Claude Code?](#what-is-claude-code)
2. [Core Concepts](#core-concepts)
3. [Agents](#agents)
4. [Skills](#skills)
5. [Slash Commands](#slash-commands)
6. [Hooks](#hooks)
7. [MCP Servers](#mcp-servers)
8. [Settings & Configuration](#settings--configuration)
9. [Advanced Workflows](#advanced-workflows)
10. [Best Practices](#best-practices)
11. [Troubleshooting](#troubleshooting)

---

## What is Claude Code?

Claude Code is Anthropic's official CLI tool for AI-assisted software development. It provides an interactive terminal interface where Claude can:

- Read, write, and edit files
- Execute bash commands
- Search codebases
- Run tests and builds
- Commit code with git
- Launch specialized agents for complex tasks
- Integrate with your development workflow

**Key Differentiators:**
- **Persistent context:** Conversations maintain context through automatic summarization
- **Tool access:** Claude can directly manipulate your filesystem and run commands
- **Agent system:** Specialized sub-agents for exploration, planning, and domain-specific tasks
- **Extensibility:** Custom slash commands, hooks, skills, and MCP integrations

---

## Core Concepts

### The Claude Code Session

When you run `claude-code`, you start an interactive session where:
- Claude has access to your working directory
- All file operations are relative to this directory
- Multiple working directories can be configured
- Context persists across the conversation

### Tools Available to Claude

Claude Code provides these built-in tools:

| Tool | Purpose | Example Use |
|------|---------|-------------|
| **Read** | Read file contents | View source code |
| **Write** | Create new files | Generate new modules |
| **Edit** | Modify existing files | Update functions |
| **Glob** | Find files by pattern | `**/*.ts` searches |
| **Grep** | Search file contents | Find function calls |
| **Bash** | Execute shell commands | Run tests, git commands |
| **Task** | Launch specialized agents | Complex multi-step tasks |
| **TodoWrite** | Manage task lists | Track progress |
| **AskUserQuestion** | Interactive questions | Clarify requirements |
| **WebSearch/WebFetch** | Access web content | Look up documentation |

### Working Directory Context

Claude knows:
- Current working directory
- Git repository status
- Platform and OS information
- Recent commit history
- File structure

---

## Agents

Agents are specialized sub-processes that autonomously handle complex, multi-step tasks. They have access to the same tools as the main Claude session but operate independently.

### Available Agent Types

#### 1. **General-Purpose Agent**
**When to use:** Complex research, multi-step tasks, searching for keywords/files when you're not confident about the first match

**Capabilities:**
- Full tool access
- Deep codebase exploration
- Multi-step reasoning
- Autonomous problem-solving

**Example tasks:**
- "Search through the codebase and find all places where authentication is handled"
- "Investigate why the build is failing and identify the root cause"
- "Research how the payment flow works across multiple services"

#### 2. **Explore Agent**
**When to use:** Quick codebase exploration, finding files, understanding architecture

**Thoroughness Levels:**
- `quick` - Basic searches, surface-level exploration
- `medium` - Moderate depth, check common patterns
- `very thorough` - Comprehensive analysis, multiple naming conventions

**Example tasks:**
- "Find all React components that handle user input" (medium)
- "Explore how API endpoints are structured" (quick)
- "Thoroughly map out the authentication system" (very thorough)

#### 3. **Plan Agent**
**When to use:** Planning implementation strategy for coding tasks

**Capabilities:**
- Architectural analysis
- Step-by-step planning
- Critical file identification
- Trade-off consideration

**Example tasks:**
- "Plan how to add user authentication to this app"
- "Design an implementation strategy for adding dark mode"
- "Create a plan to refactor the database layer"

#### 4. **Claude-Code-Guide Agent**
**When to use:** Questions about Claude Code features, API usage, Agent SDK

**Knowledge domains:**
- Claude Code CLI features and usage
- Hooks, slash commands, MCP servers
- Claude Agent SDK
- Claude API (formerly Anthropic API)

**Example tasks:**
- "How do I set up a custom slash command?"
- "Can Claude Code integrate with VS Code?"
- "How do I use the Claude API for tool use?"

**Important:** Check if an existing `claude-code-guide` agent is running before spawning a new one - you can resume previous agents.

#### 5. **Statusline-Setup Agent**
**When to use:** Configuring Claude Code status line settings

**Capabilities:**
- Read and edit status line configuration
- Adjust display preferences

### How to Use Agents

Agents are launched automatically by Claude when appropriate, but you can explicitly request them:

```
"Use the explore agent to find all database query files"
"Launch a plan agent to design the authentication system"
"Can you use the claude-code-guide agent to explain hooks?"
```

### Agent Workflow

1. **Launch:** Claude invokes the Task tool with appropriate agent type
2. **Autonomous operation:** Agent explores, reasons, and acts independently
3. **Return results:** Agent completes and returns findings to main session
4. **Resume (optional):** Agents can be resumed with their full context preserved

### Parallel Agent Execution

Multiple agents can run concurrently:

```
"Launch explore agents in parallel to:
1. Find authentication code
2. Find payment processing code
3. Find user profile management code"
```

Claude will launch all three agents simultaneously for faster results.

---

## Skills

Skills are specialized capabilities invoked within the main conversation to handle specific tasks more effectively.

### How Skills Work

- Skills provide domain-specific expertise
- Invoked using the `Skill` tool
- No arguments needed - just the skill name
- Skills are blocking operations

### Skill Invocation Pattern

When a task matches a skill's domain, Claude should invoke it **immediately** before generating other responses:

```
User: "Can you extract data from this PDF?"
Claude: [Invokes Skill tool with skill="pdf" immediately]
```

**Important:** Don't just mention a skill - invoke it directly.

### Checking Available Skills

Skills are project/environment-specific. Available skills are listed in the `<available_skills>` section of Claude's system prompt.

**Note:** As of this writing, the example session shows no skills configured. Skills are optional extensions.

### Creating Custom Skills

Skills are typically defined in project configuration or through MCP servers. Check Claude Code documentation for skill development guides.

---

## Slash Commands

Slash commands are custom shortcuts that expand to prompts or execute actions. They're defined in `.claude/commands/` directory.

### How Slash Commands Work

1. User types `/command-name` or Claude invokes via `SlashCommand` tool
2. Claude sees: `<command-message>command-name is running...</command-message>`
3. The command file contents are injected as a prompt
4. Claude processes the expanded prompt

### Command File Structure

**Location:** `.claude/commands/my-command.md`

**Contents:** Plain text prompt that will be injected

**Example:** `.claude/commands/review-code.md`
```markdown
Please review the code I've written for:
- Bugs and errors
- Security vulnerabilities
- Performance issues
- Code style and best practices
Provide specific suggestions for improvement.
```

**Usage:** `/review-code` expands to the above prompt

### Built-in vs Custom Commands

**Built-in commands** (not for SlashCommand tool):
- `/help` - Get help with Claude Code
- `/clear` - Clear conversation
- `/tasks` - View running tasks

**Custom commands** (use SlashCommand tool):
- Any command in `.claude/commands/`
- With descriptions shown in available commands list

### Creating Custom Slash Commands

1. Create file in `.claude/commands/`:
   ```bash
   mkdir -p .claude/commands
   echo "Explain this code in simple terms" > .claude/commands/explain.md
   ```

2. Use it:
   ```
   /explain
   ```

3. Add parameters (optional):
   ```markdown
   Review the pull request #$1 and provide feedback
   ```
   Usage: `/review-pr 123`

### Best Practices for Slash Commands

- **Short and memorable:** `/review` not `/review-code-for-issues`
- **Descriptive files:** Name files clearly
- **Focused prompts:** One task per command
- **Reusable:** Make prompts generic enough for multiple uses
- **Documented:** Add comments explaining usage if complex

### Multiple Sequential Commands

When executing multiple slash commands:
```
User: "Run /test and then /build"
```

Claude should:
1. Execute `/test` with SlashCommand tool
2. Wait for `<command-message>test is running...</command-message>`
3. Process the result
4. Execute `/build` with SlashCommand tool
5. Process that result

**Never invoke a command that's already running.**

---

## Hooks

Hooks are shell commands that execute in response to specific events during the Claude Code session. They provide automated feedback and integration with external tools.

### Available Hook Events

Hooks can be configured for:
- Tool calls (Read, Write, Edit, Bash, etc.)
- User prompt submissions
- Agent launches
- Task completions
- Other session events

### Hook Configuration

**Location:** Settings file (typically `.claude/settings.json` or global config)

**Example hook configuration:**
```json
{
  "hooks": {
    "userPromptSubmit": {
      "command": "echo 'Processing your request...'",
      "enabled": true
    },
    "beforeToolCall": {
      "command": "notify-send 'Claude is using a tool'",
      "enabled": true
    }
  }
}
```

### Common Hook Use Cases

1. **Linting on file edit:**
   ```json
   {
     "hooks": {
       "afterEdit": {
         "command": "eslint ${file_path}",
         "enabled": true
       }
     }
   }
   ```

2. **Type checking after write:**
   ```json
   {
     "hooks": {
       "afterWrite": {
         "command": "tsc --noEmit ${file_path}",
         "enabled": true
       }
     }
   }
   ```

3. **Security scanning:**
   ```json
   {
     "hooks": {
       "beforeCommit": {
         "command": "git-secrets --scan",
         "enabled": true
       }
     }
   }
   ```

4. **Notifications:**
   ```json
   {
     "hooks": {
       "userPromptSubmit": {
         "command": "say 'Working on it'",
         "enabled": true
       }
     }
   }
   ```

### Hook Feedback

Claude receives hook output as if it came from the user. If a hook blocks an action (non-zero exit code), Claude should:
1. Read the error message
2. Determine if it can fix the issue
3. Adjust actions accordingly
4. Or ask the user to check hook configuration

**Example:**
```
Hook output: "ESLint error: Missing semicolon on line 42"
Claude: [Adjusts the code to add semicolon and retries]
```

### Hook Best Practices

- **Fast execution:** Hooks should complete quickly to avoid delays
- **Clear output:** Provide actionable error messages
- **Selective enabling:** Only hook critical events
- **Testing:** Test hooks before enabling in production
- **Documentation:** Document hook behavior in project README

---

## MCP Servers

MCP (Model Context Protocol) servers provide additional tools and capabilities to Claude Code sessions. They extend Claude's functionality beyond built-in tools.

### What are MCP Servers?

MCP servers are external processes that:
- Expose additional tools to Claude
- Provide access to external APIs and services
- Enable custom integrations
- Can be shared across projects

### Common MCP Server Use Cases

1. **Database access:** Query databases directly
2. **API integrations:** Connect to third-party services
3. **Custom tools:** Project-specific utilities
4. **File system extensions:** Advanced file operations
5. **Web automation:** Browser control, scraping

### Installing MCP Servers

MCP servers are typically installed via:
- npm packages
- Python packages
- Standalone binaries
- Custom implementations

**Configuration location:** `.claude/mcp-servers.json` or settings file

### Example MCP Server Configuration

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-filesystem"],
      "enabled": true
    },
    "postgres": {
      "command": "mcp-postgres",
      "args": ["--connection", "postgresql://localhost/mydb"],
      "enabled": true
    }
  }
}
```

### Using MCP-Provided Tools

Once configured, MCP server tools appear alongside built-in tools. Claude uses them automatically when appropriate.

**Example:**
```
User: "Query the users table"
Claude: [Uses postgres MCP tool to execute query]
```

### Discovering Available MCP Servers

Check:
- [Anthropic MCP documentation](https://docs.anthropic.com)
- npm registry: `@anthropic/mcp-server-*`
- Community repositories
- Custom internal tools

### MCP Server Best Practices

- **Security:** Only install trusted MCP servers
- **Permissions:** Understand what access each server requires
- **Testing:** Test in isolated environment first
- **Documentation:** Document server purpose and usage
- **Monitoring:** Watch for performance impacts

---

## Settings & Configuration

### Configuration File Locations

**Project-specific:**
```
.claude/
├── settings.json          # Project settings
├── commands/              # Slash commands
│   └── *.md
├── agents/                # Custom agent configurations
│   └── *.json
└── mcp-servers.json       # MCP server config
```

**Global settings:**
- Platform-specific location
- Overridden by project settings

### Important Settings

#### 1. **Working Directories**
```json
{
  "workingDirectories": [
    "/Users/you/project1",
    "/Users/you/project2"
  ]
}
```

#### 2. **Model Selection**
```json
{
  "model": "claude-sonnet-4-5"
}
```

Options: `sonnet`, `opus`, `haiku`

#### 3. **Status Line Configuration**
```json
{
  "statusLine": {
    "enabled": true,
    "format": "detailed"
  }
}
```

#### 4. **Spell Checking (VS Code)**
`.vscode/settings.json`:
```json
{
  "cSpell.language": "en,es-ES"
}
```

### Project Instructions (CLAUDE.md)

**Location:** `CLAUDE.md` in project root (or working directory)

**Purpose:** Provide Claude with project-specific context and instructions

**Best practices:**
- Document project architecture
- Explain non-obvious patterns
- List important files and their purposes
- Specify coding standards
- Include deployment instructions
- Note common gotchas

**Example structure:**
```markdown
# CLAUDE.md

## Project Overview
Brief description of what this project does.

## Architecture
Explanation of how components fit together.

## Important Files
- `src/main.ts` - Entry point
- `config/db.ts` - Database configuration

## Development Workflow
How to run tests, build, deploy.

## Common Tasks
Step-by-step guides for frequent operations.

## Notes for Claude
Specific instructions for AI assistance.
```

---

## Advanced Workflows

### 1. Multi-Step Feature Implementation

**Pattern:** Use Plan Mode for complex features

```
User: "Add user authentication with JWT"
Claude: [Enters plan mode, explores codebase, creates implementation plan]
User: [Approves plan]
Claude: [Implements step by step using TodoWrite to track progress]
```

**Benefits:**
- Clear roadmap before coding
- User approval on approach
- Systematic implementation
- Progress tracking

### 2. Parallel Exploration

**Pattern:** Launch multiple explore agents concurrently

```
User: "Map out the authentication, payment, and notification systems"
Claude: [Launches 3 explore agents in parallel]
       Agent 1: Explores authentication
       Agent 2: Explores payment processing
       Agent 3: Explores notifications
       [Consolidates findings]
```

**Benefits:**
- Faster information gathering
- Comprehensive codebase understanding
- Efficient context building

### 3. Iterative Debugging

**Pattern:** Use targeted search → investigate → fix → verify loop

```
1. Use Grep to find error-related code
2. Use Read to examine suspicious files
3. Use Edit to apply fixes
4. Use Bash to run tests
5. Repeat if tests fail
```

**Tips:**
- Start broad, narrow down
- Use git diff to review changes
- Run tests frequently
- Commit working states

### 4. Code Review Workflow

**Pattern:** Custom slash command + checklist

Create `/review-pr` command:
```markdown
Review this pull request for:
- [ ] Correctness and logic errors
- [ ] Security vulnerabilities (SQL injection, XSS, etc.)
- [ ] Performance issues
- [ ] Test coverage
- [ ] Documentation completeness
- [ ] Code style consistency

Provide specific, actionable feedback.
```

Usage:
```
/review-pr
[Claude performs comprehensive review]
```

### 5. Documentation Generation

**Pattern:** Explore codebase → understand patterns → generate docs

```
User: "Generate API documentation for this service"
Claude:
  1. [Uses Explore agent to map API endpoints]
  2. [Reads route handlers and schemas]
  3. [Generates OpenAPI/Swagger documentation]
  4. [Creates markdown API reference]
```

### 6. Refactoring Large Codebases

**Pattern:** Plan → execute incrementally → test continuously

```
1. Use Plan agent to design refactoring strategy
2. Create TodoWrite list of refactoring steps
3. Execute one step at a time
4. Run tests after each step
5. Commit working states frequently
6. Use git bisect if issues arise
```

### 7. Integration with External Tools

**Pattern:** Hooks + MCP + Bash for complete automation

**Example: Continuous quality checks**
```json
{
  "hooks": {
    "afterEdit": {
      "command": "npm run lint && npm run type-check"
    }
  },
  "mcpServers": {
    "testing": {
      "command": "test-runner-mcp",
      "args": ["--watch"]
    }
  }
}
```

Claude edits → Hook runs linter → MCP runs tests → Feedback to Claude

---

## Best Practices

### General Principles

1. **Read before editing:** Always read files before modifying them
2. **Prefer editing over writing:** Modify existing files rather than creating new ones
3. **Avoid over-engineering:** Only make requested changes
4. **Use parallel tools:** Call independent tools in the same message
5. **Track complex tasks:** Use TodoWrite for multi-step work
6. **Complete tasks fully:** Don't stop mid-task
7. **Validate assumptions:** Use AskUserQuestion when uncertain

### Agent Usage

1. **Choose the right agent:** Match agent type to task complexity
2. **Be specific:** Provide clear task descriptions
3. **Use parallel agents:** Launch multiple agents concurrently when possible
4. **Check for running agents:** Don't spawn duplicate agents
5. **Resume when appropriate:** Continue previous agents instead of starting fresh

### Slash Commands

1. **Keep commands focused:** One clear purpose per command
2. **Make them reusable:** Avoid hardcoding specific values
3. **Document complex commands:** Explain parameters and usage
4. **Test before committing:** Verify commands work as expected
5. **Use descriptive names:** Make purpose clear from name

### Hooks

1. **Fast and focused:** Hooks should execute quickly
2. **Clear feedback:** Provide actionable messages
3. **Selective enabling:** Only hook critical events
4. **Handle failures gracefully:** Non-zero exit should block action
5. **Test thoroughly:** Verify hooks work in all scenarios

### MCP Servers

1. **Trust but verify:** Only install from trusted sources
2. **Understand permissions:** Know what access servers require
3. **Document integrations:** Explain what each server does
4. **Monitor performance:** Watch for latency impacts
5. **Keep updated:** Update servers regularly for security

### Project Configuration

1. **Comprehensive CLAUDE.md:** Provide thorough project context
2. **Clear structure:** Organize code consistently
3. **Meaningful commits:** Write descriptive commit messages
4. **Regular cleanup:** Remove unused code and files
5. **Document decisions:** Explain architectural choices

---

## Troubleshooting

### Common Issues

#### 1. Claude doesn't see my changes
**Cause:** Files not read after editing
**Solution:** Ask Claude to read the file: "Can you read file.ts to see the changes?"

#### 2. Agent never completes
**Cause:** Task too vague or agent stuck
**Solution:** Kill the task and relaunch with more specific instructions
```
Use /tasks to find task ID, then kill it
Rephrase task with clearer goals
```

#### 3. Slash command not working
**Cause:** Command file not in `.claude/commands/` or not expanded
**Solution:**
- Verify file location: `.claude/commands/my-command.md`
- Check command name matches filename
- Look for `<command-message>` in response

#### 4. Hook blocking operations
**Cause:** Hook exiting with non-zero status
**Solution:**
- Check hook output for errors
- Fix the underlying issue (linting, tests, etc.)
- Or temporarily disable the hook

#### 5. MCP server not available
**Cause:** Server not started or misconfigured
**Solution:**
- Check MCP server configuration
- Verify server installation
- Test server command manually
- Check logs for error messages

#### 6. Context loss or confusion
**Cause:** Very long conversation or complex task
**Solution:**
- Start new session for unrelated tasks
- Use agents for deep exploration
- Reference specific files explicitly
- Summarize previous work when resuming

#### 7. File not found errors
**Cause:** Relative path issues or wrong working directory
**Solution:**
- Use absolute paths
- Verify working directory with `pwd`
- Check if file exists with `ls`
- Verify path in error message

#### 8. Git conflicts
**Cause:** Multiple changes to same code
**Solution:**
- Use `git status` to see conflicts
- Review conflict markers
- Manually resolve or ask Claude to help
- Use `git diff` to understand changes

### Getting Help

1. **Built-in help:** `/help` for Claude Code documentation
2. **Agent guide:** Use claude-code-guide agent for specific questions
3. **GitHub issues:** Report bugs at https://github.com/anthropics/claude-code/issues
4. **Documentation:** Check official Anthropic docs
5. **Community:** Forums and Discord channels

### Debugging Tips

1. **Verbose output:** Ask Claude to explain what it's doing
2. **Step-by-step:** Break complex tasks into smaller steps
3. **Verify assumptions:** Check state with git, ls, cat commands
4. **Isolate issues:** Test in clean environment
5. **Compare working state:** Use git diff to see what changed

---

## Quick Reference

### Essential Commands

```bash
# Start Claude Code
claude-code

# Get help
/help

# View running tasks
/tasks

# Clear conversation
/clear
```

### Common Patterns

**Search codebase:**
```
"Use Grep to find all instances of 'authenticate' in TypeScript files"
```

**Explore architecture:**
```
"Use the explore agent with medium thoroughness to map out the API structure"
```

**Plan feature:**
```
"Use the plan agent to design implementation for user roles system"
```

**Execute parallel tasks:**
```
"Launch explore agents in parallel to find auth code, payment code, and user management code"
```

**Create custom command:**
```bash
mkdir -p .claude/commands
echo "Review code for security issues" > .claude/commands/security-review.md
```

**Configure hook:**
```json
{
  "hooks": {
    "afterEdit": {
      "command": "npm run lint",
      "enabled": true
    }
  }
}
```

### File Locations

```
Project root/
├── CLAUDE.md                    # Project instructions
├── .claude/
│   ├── settings.json           # Project settings
│   ├── commands/               # Slash commands
│   │   └── *.md
│   ├── agents/                 # Custom agents
│   │   └── *.json
│   └── mcp-servers.json        # MCP configuration
└── .vscode/
    └── settings.json           # Editor config
```

---

## Next Steps

### Beginner Path

1. ✅ Read this primer
2. Start Claude Code session in a test project
3. Practice basic file operations (Read, Edit, Write)
4. Create your first custom slash command
5. Use TodoWrite to track a multi-step task
6. Practice with Explore agent

### Intermediate Path

7. Configure your first hook
8. Use Plan agent for a feature implementation
9. Set up project-specific CLAUDE.md
10. Launch multiple agents in parallel
11. Integrate with your testing workflow

### Advanced Path

12. Install and configure MCP server
13. Create custom agent configuration
14. Build comprehensive slash command library
15. Set up multi-hook workflow automation
16. Design project-specific AI workflows

### Mastery Checklist

- [ ] Comfortable with all built-in tools
- [ ] Created 5+ custom slash commands
- [ ] Used all agent types appropriately
- [ ] Configured hooks for common tasks
- [ ] Integrated at least one MCP server
- [ ] Written comprehensive CLAUDE.md for project
- [ ] Designed efficient parallel workflows
- [ ] Can troubleshoot common issues independently
- [ ] Contributed to community (commands, patterns, tips)

---

## Additional Resources

### Official Documentation
- Claude Code GitHub: https://github.com/anthropics/claude-code
- Anthropic Documentation: https://docs.anthropic.com
- Claude API Reference: https://docs.anthropic.com/api

### Related Guides in This Repository
- `../patterns/prompt_engineering_patterns.md` - Effective prompting
- `../patterns/project_instructions_template.md` - CLAUDE.md templates
- `../examples/` - Real-world usage examples

### Community Resources
- GitHub Discussions
- Discord channels
- Community slash command libraries
- Shared MCP servers

---

**Remember:** Proficiency comes with practice. Start small, experiment, and gradually build complexity. Claude Code is a powerful tool that becomes more valuable as you learn to leverage its full capabilities.

Happy coding with Claude!
