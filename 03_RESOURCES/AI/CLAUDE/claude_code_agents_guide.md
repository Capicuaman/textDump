# Claude Code Agents: Complete Reference Guide

> **Last Updated:** 2026-01-20
> **Purpose:** Comprehensive documentation on Claude Code agents - what they are, how to create them, and best practices for effective use

---

## Table of Contents

1. [Core Concepts](#core-concepts)
2. [Built-In Agent Types](#built-in-agent-types)
3. [Creating Custom Agents](#creating-custom-agents)
4. [Agent Capabilities & Tools](#agent-capabilities--tools)
5. [Permission Modes](#permission-modes)
6. [Practical Patterns](#practical-patterns)
7. [Advanced Features](#advanced-features)
8. [Claude Agent SDK](#claude-agent-sdk)
9. [Real-World Use Cases](#real-world-use-cases)
10. [Best Practices](#best-practices)
11. [Quick Reference](#quick-reference)
12. [Troubleshooting](#troubleshooting)

---

## Core Concepts

### What Are Agents?

**Agents are specialized AI assistants** that handle specific tasks independently within Claude Code. Think of them as expert team members with focused responsibilities.

**Key Characteristics:**
- Run in isolated context windows
- Have custom system prompts tailored to their purpose
- Access only specified tools (controlled by you)
- Can have independent permissions
- Maintain separate conversation histories

### Why Use Agents?

1. **Context Preservation**: Keep verbose exploration output separate from main conversation
2. **Enforce Constraints**: Limit tools per agent (e.g., read-only researcher vs. code editor)
3. **Cost Control**: Route simple tasks to faster, cheaper models like Haiku
4. **Reusability**: Create user-level agents available across all projects
5. **Scale Complexity**: Handle multi-step workflows without context explosion
6. **Parallel Processing**: Run multiple research tasks simultaneously

**Example Scenario:**
Running 500 test failures produces massive output. Instead of consuming your main conversation context, delegate to a "test-fixer" agent. Only the relevant summary returns to you.

### How Agents Work

```
┌─────────────────────────────────────────────┐
│         Main Claude Conversation            │
│  (Full context, all tools available)        │
│                                             │
│  "Use code-reviewer agent to check auth.py"│
└──────────────┬──────────────────────────────┘
               │ Delegates task
               ▼
┌─────────────────────────────────────────────┐
│         Code Reviewer Agent                 │
│  (Isolated context, limited tools)          │
│  - Reads files                              │
│  - Runs analysis                            │
│  - Returns summary only                     │
└──────────────┬──────────────────────────────┘
               │ Returns results
               ▼
┌─────────────────────────────────────────────┐
│      Main Conversation (continued)          │
│  Receives: Concise review summary           │
│  (Agent's verbose work stays isolated)      │
└─────────────────────────────────────────────┘
```

---

## Built-In Agent Types

Claude Code comes with several specialized agents ready to use:

### 1. Explore Agent

**Purpose:** Fast, read-only codebase exploration and analysis

**Characteristics:**
- **Model:** Haiku (low-latency, cost-effective)
- **Tools:** Read, Glob, Grep (no Write/Edit)
- **Thoroughness Levels:** Quick, medium, very thorough
- **Use Case:** File discovery, code searches, architecture understanding

**When Claude Uses It:**
When you ask questions about the codebase without making changes.

**Example Prompts:**
```
"Where are authentication errors handled?"
"What patterns are used for database queries?"
"Find all API endpoints in the codebase"
```

### 2. Plan Agent

**Purpose:** Research and strategy design before implementation

**Characteristics:**
- **Model:** Inherits from main conversation
- **Tools:** Read-only tools (Read, Glob, Grep, Bash)
- **Restriction:** Cannot spawn other subagents
- **Use Case:** Codebase research for planning complex implementations

**When Claude Uses It:**
In Plan Mode when you need to understand before acting.

**Example Workflow:**
1. Enter Plan Mode with `/plan` or EnterPlanMode tool
2. Plan agent explores codebase
3. Designs implementation approach
4. Presents plan for approval
5. Exits plan mode to begin implementation

### 3. General-Purpose Agent

**Purpose:** Multi-step tasks requiring both exploration and modification

**Characteristics:**
- **Model:** Inherits from main conversation
- **Tools:** All tools (Read, Write, Edit, Bash, Glob, Grep)
- **Use Case:** Complex operations with exploration + implementation

**When Claude Uses It:**
Multi-step operations that need research and code changes.

**Example Tasks:**
```
"Refactor the authentication module—add error handling, update tests, verify it works"
"Add caching to the API layer with Redis"
"Implement rate limiting across all endpoints"
```

### 4. Helper Agents

| Agent Name | Model | Purpose | Tools |
|------------|-------|---------|-------|
| **Bash** | Inherits | Run terminal commands separately | Bash only |
| **statusline-setup** | Sonnet | Configure status line settings | Read, Edit |
| **claude-code-guide** | Haiku | Answer questions about Claude Code | Read, WebFetch, WebSearch, Glob, Grep |

---

## Creating Custom Agents

### Method 1: Interactive Creation (Recommended)

**Step-by-step:**

1. **Launch the agent creator:**
   ```
   /agents
   ```

2. **Choose "Create new agent"**

3. **Select scope:**
   - **User-level:** Available in all projects (`~/.claude/agents/`)
   - **Project-level:** Available in current project only (`.claude/agents/`)

4. **Generate with Claude or manual:**
   - **Generate:** Describe what you want, Claude creates the agent
   - **Manual:** Write the agent configuration yourself

5. **Select tools:**
   - Choose which tools the agent can access
   - Use minimal necessary permissions

6. **Choose model:**
   - `haiku` - Fast and cheap for simple tasks
   - `sonnet` - Balanced performance (default)
   - `opus` - Most capable for complex reasoning
   - `inherit` - Uses same model as main conversation

7. **Pick a color:**
   - Helps identify which agent is running in output

8. **Save:**
   - Agent is immediately available for use

**Example Creation:**
```
/agents
→ Create new agent
→ User-level (available everywhere)
→ Generate with Claude
→ "A security auditor that scans code for vulnerabilities like SQL injection, XSS, and exposed secrets"
→ Tools: Read, Glob, Grep, Bash
→ Model: Sonnet
→ Color: Red
→ Save as "security-auditor"
```

### Method 2: Manual File Creation

Agents are Markdown files with YAML frontmatter stored in:
- **Project agents:** `.claude/agents/agent-name.md`
- **User agents:** `~/.claude/agents/agent-name.md`

**Template:**

```markdown
---
name: agent-name
description: Brief description. Claude uses this to decide when to delegate. Be specific about when to use this agent proactively.
tools: Read, Edit, Write, Bash, Glob, Grep
model: inherit
permissionMode: default
---

# Agent System Prompt

You are [role description]. Your specialty is [specific expertise].

## When Invoked

Follow these steps:
1. [First action]
2. [Second action]
3. [Third action]

## Guidelines

- [Guideline 1]
- [Guideline 2]
- [Guideline 3]

## Output Format

Provide results in this format:
- [Format specification]

## Edge Cases

Handle these scenarios:
- [Edge case 1]: [How to handle]
- [Edge case 2]: [How to handle]
```

**Example: Code Reviewer Agent**

```markdown
---
name: code-reviewer
description: Expert code review specialist. Proactively reviews code for quality, security, and maintainability. Use immediately after writing or modifying code.
tools: Read, Grep, Glob, Bash
model: inherit
---

You are a senior code reviewer ensuring high standards of code quality and security.

## When Invoked

1. Run `git diff` to see recent changes
2. Focus on modified files
3. Begin review immediately without asking questions

## Review Checklist

- Code is clear and readable
- Functions and variables are well-named
- No duplicated code exists
- Proper error handling implemented
- No exposed secrets or API keys
- Input validation present
- Test coverage adequate
- Performance considerations addressed

## Output Format

Provide feedback organized by priority:

### Critical Issues (Must Fix Immediately)
- [Issue description]
  - File: `path/to/file.py:123`
  - Problem: [What's wrong]
  - Fix: [How to fix with code example]

### Warnings (Should Fix Soon)
- [Issue description]

### Suggestions (Consider Improving)
- [Enhancement ideas]

## Style

Be direct, constructive, and specific. Always provide code examples for fixes.
```

### Method 3: CLI Flag (Temporary Session)

For one-time agent use without saving:

```bash
claude --agents '{
  "code-reviewer": {
    "description": "Expert code reviewer. Use proactively after code changes.",
    "prompt": "You are a senior code reviewer focusing on quality, security, and best practices.",
    "tools": ["Read", "Grep", "Glob", "Bash"],
    "model": "sonnet"
  }
}'
```

**Note:** This agent only exists for the current session and won't be saved.

---

## Agent Capabilities & Tools

### Available Tools

Agents can use any Claude Code tool. Control access with:
- **`tools`** (allowlist): Only these tools are available
- **`disallowedTools`** (denylist): All tools except these

### Tool Categories

#### Read-Only Tools (Safe for Research)

| Tool | Purpose | Use Case |
|------|---------|----------|
| `Read` | Read file contents | Analyze code, review configurations |
| `Glob` | Find files by pattern | Discover files matching `**/*.py` |
| `Grep` | Search file contents | Find function definitions, error handling |

**Example Configuration:**
```yaml
tools: Read, Grep, Glob
```

#### Modification Tools (Require Care)

| Tool | Purpose | Use Case |
|------|---------|----------|
| `Write` | Create new files | Generate configuration, new modules |
| `Edit` | Modify existing files | Fix bugs, refactor code, update docs |

**Example Configuration:**
```yaml
tools: Read, Edit, Bash, Glob
```

#### Execution Tools (Powerful)

| Tool | Purpose | Use Case |
|------|---------|----------|
| `Bash` | Run terminal commands | Execute tests, run build, git operations |
| `WebSearch` | Search the web | Find documentation, research solutions |
| `WebFetch` | Fetch web pages | Retrieve API docs, read online resources |

**Example Configuration:**
```yaml
tools: Bash, Read, Glob
```

#### Special Tools

| Tool | Purpose | Restrictions |
|------|---------|--------------|
| `Task` | Spawn subagents | **Only in main conversation**, not in agents |
| `AskUserQuestion` | Ask user for input | Available in agents |

### Tool Selection Strategies

**Read-Only Researcher:**
```yaml
name: researcher
tools: Read, Grep, Glob, Bash, WebSearch, WebFetch
```
Safe to run, cannot modify codebase.

**Code Fixer:**
```yaml
name: code-fixer
tools: Read, Edit, Bash, Grep, Glob
```
Can modify existing files but not create new ones.

**Full-Powered Agent:**
```yaml
name: general-helper
tools: Read, Edit, Write, Bash, Glob, Grep
```
Can do everything (use sparingly).

**Database Validator (Restricted):**
```yaml
name: db-reader
tools: Bash
hooks:
  PreToolUse:
    - matcher: "Bash"
      command: "./scripts/validate-readonly-query.sh"
```
Only Bash, but hooks validate queries are read-only.

---

## Permission Modes

Control how agents handle permission requests:

### Available Modes

| Mode | Behavior | Use Case |
|------|----------|----------|
| `default` | Prompts user for approval | Development, careful operations |
| `acceptEdits` | Auto-approves file edits only | Trusted edit workflows |
| `dontAsk` | Auto-denies non-approved tools | Restricted operations |
| `bypassPermissions` | Skips all permission checks | CI/CD pipelines, full automation |
| `plan` | Read-only exploration mode | Safe analysis, planning |

### Examples

**Trusted Code Editor:**
```yaml
name: code-editor
tools: Read, Edit, Bash, Glob
permissionMode: acceptEdits
```
Edits files without asking, but still prompts for Bash commands.

**Fully Automated CI Agent:**
```yaml
name: ci-runner
tools: Bash, Read
permissionMode: bypassPermissions
```
Never prompts, runs all commands automatically.

**Safe Researcher:**
```yaml
name: researcher
tools: Read, Glob, Grep
permissionMode: default
```
Minimal tools, standard prompting (though these tools rarely need permission).

### Configuring Permissions

**In agent frontmatter:**
```yaml
---
permissionMode: acceptEdits
---
```

**Via CLI:**
```bash
claude --permissionMode acceptEdits
```

**In settings file (`.claude/settings.json`):**
```json
{
  "permissionMode": "acceptEdits"
}
```

---

## Practical Patterns

### Pattern 1: Isolate High-Volume Operations

**Problem:** Running tests produces 10,000 lines of output, consuming all your context.

**Solution:** Use a test-runner agent.

**Implementation:**
```
Use a subagent to run the test suite and report only the failing tests with error messages
```

**Result:** Only summary of failures returns to main conversation.

**Agent Configuration:**
```yaml
---
name: test-runner
description: Runs test suites and reports failures concisely
tools: Bash, Read, Grep, Glob
---

You run test suites and report failures concisely.

1. Run the test command
2. Parse output to identify failures
3. For each failure:
   - Test name
   - Error message
   - File and line number
4. Provide summary: "X tests passed, Y failed"

Do not include full test output or passing tests.
```

### Pattern 2: Parallel Research

**Problem:** Need to understand multiple parts of codebase independently.

**Solution:** Spawn multiple agents simultaneously.

**Implementation:**
```
Research the authentication, database, and API modules in parallel using separate agents
```

**What Happens:**
1. Claude spawns 3 agents concurrently
2. Each explores independently
3. All return results
4. Claude synthesizes findings

**Result:** Faster research, comprehensive overview.

### Pattern 3: Sequential Agent Chaining

**Problem:** Multi-step workflow where each step depends on previous results.

**Solution:** Chain agents sequentially.

**Implementation:**
```
Use the security-auditor agent to find vulnerabilities, then use the code-fixer agent to fix them
```

**Workflow:**
1. Security auditor identifies issues → returns results
2. Claude sends results to code fixer
3. Code fixer implements fixes → returns summary
4. Main conversation has full history

### Pattern 4: Background vs. Foreground

#### Foreground Agents (Blocking)

**Use when:**
- Task requires user permission decisions
- Results needed immediately
- High-priority work

**Behavior:**
- Blocks main conversation until complete
- Can ask permission questions
- Shares permission context with main
- Can use MCP tools

**How to use:**
Default behavior when requesting agent work.

#### Background Agents (Concurrent)

**Use when:**
- Long-running operations (tests, builds)
- Independent research tasks
- Parallel exploration

**Behavior:**
- Runs while you continue working
- Auto-denies unprompted permissions (must pre-approve)
- No MCP tool access
- Results available when complete

**How to background an agent:**
- Say: "Run this in the background"
- Press: **Ctrl+B** during execution
- CLI: `--runInBackground` flag

**Example:**
```
Run the test suite in the background while I continue developing
```

### Pattern 5: Resume Agent Work

**Problem:** Need to continue previous agent work with full context.

**Solution:** Resume the same agent instance.

**Implementation:**
```
Use the code-reviewer agent to review auth.py
[Agent completes and returns]

Continue that code review and now analyze authorization.py
[Claude resumes same agent with full history]
```

**Result:** Agent maintains context from previous work, no repeated analysis.

**Explicit Resume:**
```
/resume agent-name
```

---

## Advanced Features

### Agent Scopes (Storage Priority)

Agents can be stored in multiple locations with a priority hierarchy:

| Location | Scope | Priority | Sharing |
|----------|-------|----------|---------|
| `--agents` CLI flag | Session only | **1 (highest)** | Temporary, not saved |
| `.claude/agents/` | Current project | **2** | Shared via git, team access |
| `~/.claude/agents/` | All user projects | **3** | Personal, local only |
| Plugin directory | Installed plugin | **4 (lowest)** | Plugin distributed |

**Best Practice:** Store project-specific agents in `.claude/agents/` and check into version control to share with team.

### Hooks in Agents

Run custom code before/after agent tool usage for validation, logging, or transformation.

#### Hook Types

**PreToolUse:** Runs before tool execution
- Validate input
- Block unsafe operations
- Log tool calls

**PostToolUse:** Runs after tool execution
- Validate output
- Transform results
- Run linters/formatters

#### Example: Read-Only Database Agent

**Agent Configuration:**
```yaml
---
name: db-reader
description: Execute read-only database queries safely
tools: Bash
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/validate-readonly-query.sh"
---

You are a database analyst with read-only access.

Execute SELECT queries to analyze data. You cannot INSERT, UPDATE, DELETE, or modify schema.

When asked:
1. Identify relevant tables
2. Write efficient SELECT queries
3. Present results clearly with context

If asked to modify data, explain you only have read access.
```

**Validation Script (`scripts/validate-readonly-query.sh`):**
```bash
#!/bin/bash
# Validates that Bash commands are read-only SQL queries

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

# Block write operations
if echo "$COMMAND" | grep -iE '\b(INSERT|UPDATE|DELETE|DROP|CREATE|ALTER|TRUNCATE)\b' > /dev/null; then
  echo "❌ Blocked: Write operations not allowed" >&2
  exit 2  # Exit code 2 blocks the tool call
fi

# Allow read operations
exit 0
```

**Result:** Agent can only run read-only queries. Write operations are blocked by hook.

#### Example: Auto-Lint After Edits

```yaml
---
name: code-editor
tools: Read, Edit, Glob
hooks:
  PostToolUse:
    - matcher: "Edit"
      hooks:
        - type: command
          command: "./scripts/run-linter.sh"
---
```

**Linter Script:**
```bash
#!/bin/bash
# Runs linter on edited files

INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [[ -n "$FILE" ]]; then
  echo "🔍 Linting $FILE..."
  eslint "$FILE" --fix
fi
```

### Agent Context Management

#### Auto-Compaction

When an agent's context reaches ~95% capacity, it automatically compacts while preserving:
- Recent tool calls and results
- Important findings
- User instructions

**Override threshold:**
```bash
export CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=50  # Compact at 50% instead
```

#### Separate Transcripts

Agent conversations are stored separately from main conversation:

```
~/.claude/projects/{project}/{sessionId}/subagents/agent-{agentId}.jsonl
```

**Benefits:**
- Agent output doesn't inflate main conversation
- Can review agent work independently
- Better context management

### Disabling Specific Agents

Prevent Claude from automatically using certain agents.

**Method 1: Settings file (`.claude/settings.json`):**
```json
{
  "permissions": {
    "deny": [
      "Task(Explore)",
      "Task(my-custom-agent)"
    ]
  }
}
```

**Method 2: CLI flag:**
```bash
claude --disallowedTools "Task(Explore)"
```

**Use case:** Prevent expensive agent usage or force direct tool usage.

---

## Claude Agent SDK

Build programmatic agents with Python or TypeScript.

### Python Quick Start

**Installation:**
```bash
pip install claude-agent-sdk
```

**Basic Example:**
```python
import asyncio
from claude_agent_sdk import query, ClaudeAgentOptions, AssistantMessage, ResultMessage

async def main():
    # Agentic loop: streams messages as Claude works
    async for message in query(
        prompt="Review utils.py for bugs that would cause crashes. Fix any issues you find.",
        options=ClaudeAgentOptions(
            allowed_tools=["Read", "Edit", "Glob"],
            permission_mode="acceptEdits"  # Auto-approve edits
        )
    ):
        if isinstance(message, AssistantMessage):
            for block in message.content:
                if hasattr(block, "text"):
                    print(block.text)
        elif isinstance(message, ResultMessage):
            print(f"✅ Done: {message.subtype}")

asyncio.run(main())
```

### Key SDK Concepts

1. **`query()`**: Main entry point creating the agentic loop
2. **`prompt`**: Task description for the agent
3. **`options`**: Configuration (tools, permissions, system prompt, model)
4. **Streaming loop**: Yields messages as Claude works
5. **Message types**:
   - `AssistantMessage`: Claude's text responses
   - `ToolUseMessage`: Tool invocations
   - `ToolResultMessage`: Tool results
   - `ResultMessage`: Final completion status

### Common Options

```python
ClaudeAgentOptions(
    allowed_tools=["Read", "Edit", "Glob", "Bash"],
    permission_mode="acceptEdits",
    system_prompt="You are a senior Python developer specializing in security.",
    model="opus",  # or "sonnet", "haiku"
    mcp_servers={
        "my-server": {
            "command": "npx",
            "args": ["-y", "@my-org/mcp-server"]
        }
    }
)
```

### Advanced Example: Custom Tool Validation

```python
import asyncio
from claude_agent_sdk import query, ClaudeAgentOptions, ToolUseMessage

async def validate_tool_use(message: ToolUseMessage) -> bool:
    """Custom validation logic"""
    if message.tool == "Bash":
        command = message.input.get("command", "")
        # Block destructive commands
        if any(keyword in command for keyword in ["rm -rf", "DROP TABLE", "DELETE FROM"]):
            print(f"❌ Blocked unsafe command: {command}")
            return False
    return True

async def main():
    async for message in query(
        prompt="Clean up old log files",
        options=ClaudeAgentOptions(
            allowed_tools=["Bash", "Read", "Glob"],
            permission_mode="default"
        )
    ):
        if isinstance(message, ToolUseMessage):
            if not await validate_tool_use(message):
                # Block execution
                continue

        # Process message...
        print(message)

asyncio.run(main())
```

### TypeScript Example

```typescript
import { query, ClaudeAgentOptions } from '@anthropic-ai/claude-agent-sdk';

async function main() {
  const stream = query({
    prompt: "Analyze the authentication module for security issues",
    options: {
      allowedTools: ["Read", "Glob", "Grep"],
      permissionMode: "default",
      systemPrompt: "You are a security expert specializing in authentication vulnerabilities."
    }
  });

  for await (const message of stream) {
    if (message.type === 'assistant') {
      console.log(message.content);
    }
  }
}

main();
```

### SDK Resources

- **Documentation:** https://platform.claude.com/docs/en/agent-sdk/
- **GitHub:** https://github.com/anthropics/claude-agent-sdk
- **Examples:** https://github.com/anthropics/claude-agent-sdk/tree/main/examples

---

## Real-World Use Cases

### 1. Automated Code Review Pipeline

**Goal:** Review all code changes before commits for quality and security.

**Agent Setup:**
```yaml
---
name: code-reviewer
description: Reviews code for quality, security, and best practices. Use immediately after code changes.
tools: Read, Grep, Glob, Bash
model: sonnet
---

You are a senior code reviewer.

1. Run `git diff` to see changes
2. Review each modified file
3. Check for:
   - Security vulnerabilities
   - Code quality issues
   - Best practice violations
   - Performance concerns

Report findings by severity: Critical, Warnings, Suggestions.
```

**Usage:**
```
review my recent changes before I commit
```

**Integration with Git Hooks:**
```bash
# .git/hooks/pre-commit
#!/bin/bash
claude --agents-file .claude/agents/code-reviewer.md \
      --prompt "Review staged changes for issues" \
      --permissionMode bypassPermissions
```

### 2. Test Failure Investigator

**Goal:** Run tests, identify failures, and fix them automatically.

**Agent Setup:**
```yaml
---
name: test-runner
description: Runs tests and fixes failures
tools: Bash, Read, Edit, Glob
permissionMode: acceptEdits
---

You run tests and fix failures.

1. Run test command
2. Parse failures
3. For each failure:
   - Read failing test
   - Identify cause
   - Fix implementation or test
   - Re-run to verify
4. Report summary
```

**Usage:**
```
run tests and fix any failures
```

**Result:** Clean test suite without manual debugging.

### 3. Documentation Generator

**Goal:** Generate API documentation from code automatically.

**Agent Setup:**
```yaml
---
name: doc-generator
description: Generates documentation from code
tools: Read, Write, Glob
---

You generate comprehensive API documentation.

1. Find all public classes/functions
2. Extract:
   - Function signatures
   - Parameters and types
   - Return values
   - Docstrings
3. Generate markdown documentation
4. Create index and navigation
```

**Usage:**
```
generate API documentation for the auth module
```

### 4. Security Auditor

**Goal:** Continuous security scanning of codebase.

**Agent Setup:**
```yaml
---
name: security-auditor
description: Scans code for security vulnerabilities
tools: Read, Grep, Glob, Bash
---

You are a security expert auditing code.

Check for:
- SQL injection vulnerabilities
- XSS attack vectors
- Exposed secrets/API keys
- Insecure authentication
- CSRF vulnerabilities
- Command injection
- Path traversal

For each issue:
- Severity (Critical/High/Medium/Low)
- File and line number
- Vulnerable code
- Attack scenario
- Remediation steps
```

**Usage:**
```
audit the codebase for security vulnerabilities
```

### 5. Performance Optimizer

**Goal:** Identify and fix performance bottlenecks.

**Agent Chain Setup:**

**Analyzer Agent:**
```yaml
---
name: performance-analyzer
description: Identifies performance bottlenecks
tools: Bash, Read, Glob, Grep
---

You identify performance issues.

1. Run profiler
2. Identify slow functions
3. Find inefficient patterns:
   - N+1 queries
   - Unnecessary loops
   - Large file reads
   - Memory leaks
4. Report findings with metrics
```

**Optimizer Agent:**
```yaml
---
name: performance-optimizer
description: Fixes performance issues
tools: Read, Edit, Bash, Glob
permissionMode: acceptEdits
---

You optimize code based on performance analysis.

For each issue:
1. Understand the problem
2. Implement optimization
3. Verify improvement with benchmarks
4. Document changes
```

**Usage:**
```
Use the performance-analyzer agent to find bottlenecks, then use the performance-optimizer agent to fix them
```

### 6. Database Migration Assistant

**Goal:** Safely create and validate database migrations.

**Agent Setup:**
```yaml
---
name: migration-helper
description: Creates database migrations safely
tools: Read, Write, Bash, Glob
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/validate-migration.sh"
---

You create database migrations.

1. Understand schema changes needed
2. Generate migration file
3. Create rollback migration
4. Test migration on copy of database
5. Verify data integrity
6. Generate documentation
```

---

## Best Practices

### Do's ✓

✓ **Create focused agents** - One specialty per agent
✓ **Write detailed descriptions** - Claude uses this to decide when to delegate
✓ **Limit tool access** - Grant only necessary permissions
✓ **Use meaningful names** - `code-reviewer` not `agent1`
✓ **Check project agents into git** - Share with team in `.claude/agents/`
✓ **Include clear system prompts** - Specify workflow steps and output format
✓ **Name agents with colors** - Helps identify which agent is running
✓ **Resume agents for continuity** - Continue previous work instead of restarting
✓ **Run expensive operations in agents** - Keep main context clean
✓ **Use hooks for validation** - Enforce safety constraints programmatically
✓ **Test agent prompts** - Verify agent behavior matches expectations
✓ **Document agent usage** - Add comments explaining when to use each agent

### Don'ts ✗

✗ **Don't over-empower agents** - Restrict to minimum necessary tools
✗ **Don't create duplicate agents** - Reuse existing ones or rename
✗ **Don't nest agents infinitely** - Agents can't spawn agents; chain instead
✗ **Don't create catch-all agents** - Be specific about purpose
✗ **Don't ignore permissions** - Use `bypassPermissions` only when necessary
✗ **Don't background agents needing user input** - They auto-deny questions
✗ **Don't use vague descriptions** - Be specific about when to use proactively
✗ **Don't skip error handling** - Agents should handle edge cases gracefully
✗ **Don't hardcode paths** - Use dynamic path discovery
✗ **Don't forget to test** - Verify agent behavior before deploying

### Agent Design Checklist

Before creating an agent, ask:

- [ ] **Purpose**: What specific problem does this solve?
- [ ] **Focus**: Does it do one thing well?
- [ ] **Description**: Would Claude know when to use this automatically?
- [ ] **Tools**: Are tools minimally sufficient?
- [ ] **Permissions**: What's the safest permission mode?
- [ ] **Validation**: Do I need hooks for safety?
- [ ] **Model**: Can I use Haiku to save cost?
- [ ] **Reusability**: Should this be user-level or project-level?
- [ ] **Testing**: How will I verify it works correctly?

---

## Quick Reference

### Common Commands

| Task | Command |
|------|---------|
| View all agents | `/agents` |
| Create new agent | `/agents` → Create new |
| Use specific agent | "Use the [agent-name] agent to..." |
| Resume agent | "Continue that work" or `/resume [agent-name]` |
| Disable agent | Add to `permissions.deny` in settings |
| Background task | Press **Ctrl+B** or say "run in background" |
| View agent status | Look for agent name in colored output |
| Find agent files | `.claude/agents/` or `~/.claude/agents/` |
| View transcripts | `~/.claude/projects/{project}/{sessionId}/subagents/` |

### Agent File Structure

```markdown
---
name: agent-name
description: When to use this agent proactively
tools: Read, Edit, Bash, Glob, Grep
model: inherit|haiku|sonnet|opus
permissionMode: default|acceptEdits|dontAsk|bypassPermissions|plan
hooks:
  PreToolUse:
    - matcher: "ToolName"
      hooks:
        - type: command
          command: "./script.sh"
---

# System Prompt

[Agent instructions here]
```

### Permission Modes Quick Reference

| Mode | Behavior | Risk | Use Case |
|------|----------|------|----------|
| `default` | Prompts for approval | Low | Development |
| `acceptEdits` | Auto-approves edits | Medium | Trusted editing |
| `dontAsk` | Auto-denies unknown | Low | Restricted ops |
| `bypassPermissions` | Never prompts | High | CI/CD only |
| `plan` | Read-only | Very Low | Analysis |

### Tool Access Patterns

**Read-Only:**
```yaml
tools: Read, Glob, Grep, Bash, WebSearch
```

**Editor:**
```yaml
tools: Read, Edit, Bash, Glob
```

**Creator:**
```yaml
tools: Read, Write, Edit, Bash, Glob, Grep
```

**Restricted:**
```yaml
tools: Bash
hooks: [validation]
```

---

## Troubleshooting

### Agent Not Being Used Automatically

**Symptom:** You expect Claude to use an agent, but it handles the task directly.

**Causes & Solutions:**

1. **Vague description**
   ```yaml
   # ❌ Bad
   description: Code review

   # ✅ Good
   description: Expert code reviewer. Proactively reviews code for quality, security, and maintainability. Use immediately after writing or modifying code.
   ```

2. **Agent not in search path**
   - Check agent exists in `.claude/agents/` or `~/.claude/agents/`
   - Verify filename ends with `.md`
   - Run `/agents` to see if it's listed

3. **Task doesn't match agent specialty**
   - Agent description must match the task
   - Be more specific in your request: "Use the code-reviewer agent to..."

### Agent Context Getting Too Large

**Symptom:** Agent performance degrades over long sessions.

**Solutions:**

1. **Rely on auto-compaction** (happens at 95% by default)
2. **Start fresh session and resume:**
   ```
   /resume agent-name
   ```
3. **Lower compaction threshold:**
   ```bash
   export CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=50
   ```

### Agent Can't Perform Required Actions

**Symptom:** Agent fails to complete tasks due to missing tools.

**Solutions:**

1. **Add necessary tools:**
   ```yaml
   # If agent needs to edit files
   tools: Read, Edit, Bash, Glob
   ```

2. **Adjust permission mode:**
   ```yaml
   # If agent needs to edit without prompting
   permissionMode: acceptEdits
   ```

3. **Check hooks aren't blocking:**
   - Review `PreToolUse` hooks
   - Temporarily disable hooks to test

### Too Many Redundant Tool Calls

**Symptom:** Agent calls Bash repeatedly when Read would work better.

**Solutions:**

1. **Be more directive in system prompt:**
   ```markdown
   Prefer the Read tool over Bash for reading files.
   Only use Bash when you need to run commands.
   ```

2. **Restrict tools:**
   ```yaml
   # Remove Bash if not needed
   tools: Read, Glob, Grep
   ```

3. **Add hook to guide behavior:**
   ```yaml
   hooks:
     PreToolUse:
       - matcher: "Bash"
         hooks:
           - type: command
             command: "./scripts/suggest-read-tool.sh"
   ```

### Agent Permissions Not Working

**Symptom:** Agent still prompts despite `bypassPermissions` mode.

**Solutions:**

1. **Check permission mode is set:**
   ```yaml
   permissionMode: bypassPermissions
   ```

2. **Verify mode isn't overridden in settings:**
   ```json
   // .claude/settings.json
   {
     "permissionMode": "default"  // ← This overrides agent config
   }
   ```

3. **Check tool isn't in deny list:**
   ```json
   {
     "permissions": {
       "deny": ["Bash"]  // ← This blocks the tool
     }
   }
   ```

### Background Agent Not Progressing

**Symptom:** Background agent appears stuck or not making progress.

**Solutions:**

1. **Check if it's waiting for permission:**
   - Background agents auto-deny unprompted permissions
   - Pre-approve needed permissions before backgrounding

2. **View agent output:**
   - Check task output with `/tasks`
   - Read agent transcript file

3. **Bring to foreground:**
   - Some tasks need foreground mode for user interaction

### Hook Validation Failing

**Symptom:** Hook blocks valid operations.

**Solutions:**

1. **Debug hook script:**
   ```bash
   # Test hook manually
   echo '{"tool_input": {"command": "ls"}}' | ./scripts/validate.sh
   echo $?  # Should be 0 for success, 2 for block
   ```

2. **Add logging to hook:**
   ```bash
   echo "Validating: $COMMAND" >> /tmp/hook-debug.log
   ```

3. **Temporarily disable hook:**
   ```yaml
   # Comment out hook for testing
   # hooks:
   #   PreToolUse: ...
   ```

---

## Additional Resources

### Official Documentation

- **Claude Code Docs:** https://claude.ai/code/docs
- **Agent SDK:** https://platform.claude.com/docs/en/agent-sdk/
- **GitHub:** https://github.com/anthropics/claude-code

### Learning Resources

- **Example Agents:** `.claude/agents/examples/` (if available)
- **Community Agents:** https://github.com/anthropics/claude-agents
- **Best Practices:** https://claude.ai/code/best-practices

### Support

- **GitHub Issues:** https://github.com/anthropics/claude-code/issues
- **Community Forum:** https://discord.gg/anthropic
- **Documentation:** Type `/help` in Claude Code

---

## Appendix: Example Agent Library

### Example 1: Git Commit Message Generator

```yaml
---
name: commit-msg-generator
description: Generates conventional commit messages from staged changes
tools: Bash, Read, Grep
---

You generate conventional commit messages following best practices.

1. Run `git diff --staged` to see changes
2. Analyze changes to understand intent
3. Generate commit message:
   - Format: `type(scope): description`
   - Types: feat, fix, docs, style, refactor, test, chore
   - Keep under 72 characters
   - Add body if needed for context

Example:
```
feat(auth): add password reset functionality

Implements password reset via email token
Includes rate limiting and expiration
```
```

### Example 2: Dependency Updater

```yaml
---
name: dependency-updater
description: Updates dependencies safely with compatibility checks
tools: Bash, Read, Edit
permissionMode: acceptEdits
---

You update dependencies safely.

1. Identify outdated dependencies
2. For each update:
   - Check changelog for breaking changes
   - Update version
   - Run tests
   - Rollback if tests fail
3. Report what was updated
```

### Example 3: Log Analyzer

```yaml
---
name: log-analyzer
description: Analyzes logs to identify errors and patterns
tools: Bash, Read, Grep, Glob
---

You analyze logs to identify issues.

1. Find relevant log files
2. Extract errors and warnings
3. Group by:
   - Error type
   - Frequency
   - Time period
4. Identify patterns
5. Suggest fixes for common issues
```

---

**End of Guide**

For updates and more examples, check the official Claude Code documentation and community resources.