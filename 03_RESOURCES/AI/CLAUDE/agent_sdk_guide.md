# Claude Agent SDK Guide

Comprehensive guide to building production AI agents using the Claude Agent SDK.

## Table of Contents

1. [Overview](#overview)
2. [Installation & Setup](#installation--setup)
3. [Core Concepts](#core-concepts)
4. [Quick Start](#quick-start)
5. [Building Agents](#building-agents)
6. [Tool Integration](#tool-integration)
7. [Multi-Turn Conversations](#multi-turn-conversations)
8. [MCP Server Integration](#mcp-server-integration)
9. [Advanced Patterns](#advanced-patterns)
10. [Production Deployment](#production-deployment)
11. [Best Practices](#best-practices)
12. [Examples](#examples)

---

## Overview

### What is the Claude Agent SDK?

The Claude Agent SDK enables building production AI agents that operate autonomously using Claude's capabilities. It provides:

- **Same tools as Claude Code CLI:** Read, Write, Edit, Bash, Grep, Glob, etc.
- **Automatic tool loop:** No manual tool execution needed
- **Programmatic control:** Python and TypeScript SDKs
- **Enterprise features:** For CI/CD, automation, and custom applications

### SDK vs CLI vs API

| Feature | Claude Code CLI | Agent SDK | Claude API |
|---------|----------------|-----------|------------|
| **Interface** | Interactive shell | Programmatic | HTTP REST |
| **Tool Loop** | Manual (user) | Automatic | Manual |
| **Use Case** | Development | Production automation | Custom integrations |
| **Deployment** | Local | CI/CD, cloud, Docker | Any HTTP client |
| **Multi-turn** | Per session | Via ClaudeSDKClient | Manual state management |

### When to Use the Agent SDK

✅ **Use Agent SDK for:**
- Building production AI agents
- CI/CD pipeline integration
- Automated code reviews
- Email assistants
- Research agents
- Data processing pipelines
- Custom applications with AI
- Autonomous multi-step tasks

❌ **Use Claude API instead for:**
- Simple single-turn completions
- Chatbots without file access
- Custom tool implementations
- Maximum flexibility and control

---

## Installation & Setup

### Prerequisites

- **Node.js:** 18+ (for SDK runtime)
- **Python:** 3.10+ (Python SDK)
- **Anthropic API key**

### Step 1: Install Claude Code

The SDK requires Claude Code as its runtime:

**macOS/Linux/WSL:**
```bash
curl -fsSL https://claude.ai/install.sh | bash
```

**Homebrew:**
```bash
brew install --cask claude-code
```

**npm:**
```bash
npm install -g @anthropic-ai/claude-code
```

### Step 2: Install SDK

**Python:**
```bash
# Using uv (recommended)
uv init && uv add claude-agent-sdk

# Using pip
python3 -m venv .venv
source .venv/bin/activate
pip3 install claude-agent-sdk
```

**TypeScript:**
```bash
npm install @anthropic-ai/claude-agent-sdk
```

### Step 3: Authenticate

**Option 1: Interactive (Recommended for development)**
```bash
claude
# Follow authentication prompts
```

**Option 2: API Key (Recommended for production)**
```bash
export ANTHROPIC_API_KEY=your-api-key
```

**Verify Installation:**
```bash
claude --version
```

---

## Core Concepts

### 1. Agents

Agents are AI-powered entities that can:
- Receive tasks via prompts
- Use tools autonomously
- Return results

**Types:**
- **Single-Turn Agents:** Process one task, return result
- **Multi-Turn Agents:** Maintain conversation state
- **Subagents:** Specialized agents for focused tasks

### 2. Tools

Built-in tools available to agents:

| Tool | Purpose |
|------|---------|
| **Read** | Read files |
| **Write** | Create files |
| **Edit** | Modify files |
| **Bash** | Execute commands |
| **Glob** | Find files by pattern |
| **Grep** | Search file contents |
| **WebSearch** | Search the web |
| **WebFetch** | Fetch web content |
| **Task** | Spawn subagents |

### 3. Options

Configure agent behavior:

- **allowed_tools:** Which tools agent can use
- **permission_mode:** How permissions are handled
- **system_prompt:** Define agent behavior
- **mcp_servers:** External integrations
- **model:** Which Claude model to use
- **max_turns:** Limit conversation length
- **max_budget_usd:** Set spending limit

---

## Quick Start

### Python: Simple Agent

```python
import asyncio
from claude_agent_sdk import query, ClaudeAgentOptions

async def main():
    # Create an agent that reads and explains a file
    async for message in query(
        prompt="Read @src/utils.py and explain what it does",
        options=ClaudeAgentOptions(
            allowed_tools=["Read", "Glob"]
        )
    ):
        print(message)

asyncio.run(main())
```

### TypeScript: Simple Agent

```typescript
import { query } from "@anthropic-ai/claude-agent-sdk";

for await (const message of query({
  prompt: "Read @src/utils.ts and explain what it does",
  options: { allowedTools: ["Read", "Glob"] }
})) {
  console.log(message);
}
```

---

## Building Agents

### Single-Turn Agent (Stateless)

**Python:**
```python
import asyncio
from claude_agent_sdk import query, ClaudeAgentOptions, AssistantMessage, TextBlock

async def bug_fixer():
    """Agent that finds and fixes bugs"""

    async for message in query(
        prompt="""
        Review @src/auth.py for bugs that would cause crashes.
        Fix any issues you find using the Edit tool.
        """,
        options=ClaudeAgentOptions(
            allowed_tools=["Read", "Edit", "Glob"],
            permission_mode="acceptEdits"  # Auto-approve file edits
        )
    ):
        # Handle different message types
        if isinstance(message, AssistantMessage):
            for block in message.content:
                if isinstance(block, TextBlock):
                    print(f"Claude: {block.text}")

asyncio.run(bug_fixer())
```

**TypeScript:**
```typescript
import { query, AssistantMessage, TextBlock } from "@anthropic-ai/claude-agent-sdk";

async function bugFixer() {
  for await (const message of query({
    prompt: "Review @src/auth.ts for bugs and fix them",
    options: {
      allowedTools: ["Read", "Edit", "Glob"],
      permissionMode: "acceptEdits"
    }
  })) {
    if (message.type === "assistant") {
      for (const block of message.content) {
        if (block.type === "text") {
          console.log(`Claude: ${block.text}`);
        }
      }
    }
  }
}

bugFixer();
```

### Multi-Turn Agent (Stateful)

**Python:**
```python
import asyncio
from claude_agent_sdk import ClaudeSDKClient, ClaudeAgentOptions

async def interactive_agent():
    """Agent that remembers conversation context"""

    async with ClaudeSDKClient() as client:
        # First question
        await client.query("What files are in the src/ directory?")

        async for message in client.receive_response():
            print(message)

        # Follow-up - Claude remembers the previous context
        await client.query("Read the largest file you found")

        async for message in client.receive_response():
            print(message)

        # Another follow-up
        await client.query("Summarize what that file does")

        async for message in client.receive_response():
            print(message)

asyncio.run(interactive_agent())
```

### Custom System Prompts

**Python:**
```python
options = ClaudeAgentOptions(
    system_prompt="""You are a senior Python developer with expertise in:
    - Writing clean, maintainable code
    - Following PEP 8 style guidelines
    - Comprehensive error handling
    - Security best practices

    When reviewing code:
    1. Check for security vulnerabilities
    2. Identify performance issues
    3. Suggest improvements
    4. Provide specific examples
    """
)
```

**Using Claude Code Preset:**
```python
options = ClaudeAgentOptions(
    system_prompt={
        "type": "preset",
        "preset": "claude_code",
        "append": "Always add type hints to Python functions."
    }
)
```

---

## Tool Integration

### Restricting Tools

**Read-Only Agent:**
```python
options = ClaudeAgentOptions(
    allowed_tools=["Read", "Glob", "Grep"]  # Cannot modify files
)
```

**Full Access Agent:**
```python
options = ClaudeAgentOptions(
    allowed_tools=["Read", "Write", "Edit", "Bash", "Glob", "Grep"]
)
```

### Custom Tool Approval

**Python:**
```python
async def can_use_tool(tool: str, input: dict, context: dict) -> bool:
    """Custom authorization logic"""

    # Block dangerous commands
    if tool == "Bash":
        command = input.get("command", "")
        if "rm -rf /" in command or "sudo" in command:
            print(f"Blocked dangerous command: {command}")
            return False

    # Block access to secrets
    if tool in ["Read", "Edit"]:
        path = input.get("file_path", "")
        if ".env" in path or "secrets" in path:
            print(f"Blocked access to sensitive file: {path}")
            return False

    return True

options = ClaudeAgentOptions(
    allowed_tools=["Read", "Write", "Edit", "Bash"],
    can_use_tool=can_use_tool
)
```

### Permission Modes

| Mode | Behavior | Use Case |
|------|----------|----------|
| `default` | Prompts on first use per session | Interactive development |
| `acceptEdits` | Auto-approves file changes | Trusted workflows |
| `bypassPermissions` | No prompts (use with caution) | CI/CD pipelines |
| `plan` | Read-only analysis | Planning mode |

**Example:**
```python
options = ClaudeAgentOptions(
    permission_mode="acceptEdits",  # Auto-approve file edits
    allowed_tools=["Read", "Edit"]
)
```

---

## Multi-Turn Conversations

### Using ClaudeSDKClient

**Python:**
```python
import asyncio
from claude_agent_sdk import ClaudeSDKClient, ClaudeAgentOptions

async def research_agent():
    """Multi-turn research agent"""

    async with ClaudeSDKClient(
        options=ClaudeAgentOptions(
            allowed_tools=["Read", "Glob", "Grep", "WebSearch"]
        )
    ) as client:

        # Question 1
        await client.query("Find all Python files in this project")
        async for msg in client.receive_response():
            print(msg)

        # Question 2 (remembers previous context)
        await client.query("Which file is the largest?")
        async for msg in client.receive_response():
            print(msg)

        # Question 3
        await client.query("Analyze that file for code quality issues")
        async for msg in client.receive_response():
            print(msg)

asyncio.run(research_agent())
```

### Session Management

**Resuming Sessions:**
```python
import asyncio
from claude_agent_sdk import query, ClaudeAgentOptions

async def resumable_agent():
    session_id = None

    # First query - capture session ID
    async for message in query(
        prompt="Read the authentication module",
        options=ClaudeAgentOptions(allowed_tools=["Read", "Glob"])
    ):
        if hasattr(message, 'subtype') and message.subtype == 'init':
            session_id = message.data.get('session_id')

    print(f"Session ID: {session_id}")

    # Resume with full context
    async for message in query(
        prompt="Now find all places that call functions from that module",
        options=ClaudeAgentOptions(resume=session_id)
    ):
        print(message)

asyncio.run(resumable_agent())
```

---

## MCP Server Integration

MCP (Model Context Protocol) extends agent capabilities with external tools.

### Adding MCP Servers

**Via CLI:**
```bash
# HTTP server
claude mcp add --transport http github https://mcp.github.com/mcp

# Local stdio server
claude mcp add --transport stdio postgres \
  --env DATABASE_URL=postgresql://... \
  -- npx -y postgres-mcp-server
```

**In Agent Code (Python):**
```python
options = ClaudeAgentOptions(
    mcp_servers={
        "github": {
            "command": "npx",
            "args": ["-y", "@modelcontextprotocol/server-github"],
            "env": {"GITHUB_TOKEN": "your-token"}
        },
        "postgres": {
            "command": "npx",
            "args": ["-y", "@modelcontextprotocol/server-postgres"],
            "env": {"DATABASE_URL": "postgresql://..."}
        }
    }
)

async for message in query(
    prompt="List all open GitHub issues",
    options=options
):
    print(message)
```

### Creating Custom MCP Servers

**Python:**
```python
from claude_agent_sdk import tool, create_sdk_mcp_server

@tool("calculate", "Perform calculations", {"expression": str})
async def calculate(args):
    """Custom calculator tool"""
    result = eval(args["expression"])  # Note: Use safe eval in production
    return {
        "content": [{
            "type": "text",
            "text": f"Result: {result}"
        }]
    }

# Create MCP server
calculator_server = create_sdk_mcp_server(
    name="calculator",
    version="1.0.0",
    tools=[calculate]
)

# Use in agent
options = ClaudeAgentOptions(
    mcp_servers={"calculator": calculator_server}
)
```

**TypeScript:**
```typescript
import { tool, createSdkMcpServer } from "@anthropic-ai/claude-agent-sdk";
import { z } from "zod";

const calculate = tool(
  "calculate",
  "Perform calculations",
  { expression: z.string() },
  async (args) => ({
    content: [{
      type: "text",
      text: `Result: ${eval(args.expression)}`
    }]
  })
);

const calculatorServer = createSdkMcpServer({
  name: "calculator",
  version: "1.0.0",
  tools: [calculate]
});
```

---

## Advanced Patterns

### 1. Error Handling

**Python:**
```python
from claude_agent_sdk import (
    query,
    CLINotFoundError,
    ProcessError,
    CLIJSONDecodeError
)

try:
    async for message in query(prompt="Your task"):
        print(message)

except CLINotFoundError:
    print("Claude Code not installed. Run: npm install -g @anthropic-ai/claude-code")

except ProcessError as e:
    print(f"Process failed with exit code {e.exit_code}")
    print(f"Stderr: {e.stderr}")

except CLIJSONDecodeError as e:
    print(f"Failed to parse response: {e}")

except Exception as e:
    print(f"Unexpected error: {e}")
```

### 2. Budget Control

```python
options = ClaudeAgentOptions(
    max_budget_usd=5.0,  # Stop after $5 spent
    max_turns=10  # Limit conversation turns
)
```

### 3. Hooks for Auditing

**Python:**
```python
from claude_agent_sdk import HookMatcher

async def audit_log(input_data, tool_use_id, context):
    """Log all tool usage"""
    tool = input_data.get('tool_name', 'unknown')
    print(f"[AUDIT] {tool} used with ID {tool_use_id}")
    return {}

options = ClaudeAgentOptions(
    hooks={
        'PostToolUse': [
            HookMatcher(hooks=[audit_log])
        ]
    }
)
```

### 4. Parallel Agent Execution

```python
import asyncio
from claude_agent_sdk import query

async def parallel_agents():
    """Run multiple agents in parallel"""

    tasks = [
        query(prompt="Find all TODOs in the codebase", options=...),
        query(prompt="Find all FIXME comments", options=...),
        query(prompt="Find all deprecated API usage", options=...)
    ]

    results = await asyncio.gather(*tasks)

    return results

asyncio.run(parallel_agents())
```

### 5. Structured Output

```python
options = ClaudeAgentOptions(
    output_format={
        "type": "json_schema",
        "schema": {
            "type": "object",
            "properties": {
                "bugs": {
                    "type": "array",
                    "items": {
                        "type": "object",
                        "properties": {
                            "file": {"type": "string"},
                            "line": {"type": "integer"},
                            "severity": {"type": "string", "enum": ["low", "medium", "high"]},
                            "description": {"type": "string"}
                        }
                    }
                }
            }
        }
    }
)

async for message in query(
    prompt="Find all security bugs and return as JSON",
    options=options
):
    print(message)
```

---

## Production Deployment

### 1. Environment Configuration

**Python:**
```python
import os

options = ClaudeAgentOptions(
    cwd="/path/to/project",
    env={
        "DATABASE_URL": os.getenv("DATABASE_URL"),
        "API_KEY": os.getenv("API_KEY"),
        "NODE_ENV": "production"
    },
    allowed_tools=["Read", "Edit", "Bash"]
)
```

### 2. CI/CD Integration

**GitHub Actions Example:**
```yaml
name: Code Review

on: [pull_request]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Install Claude Code
        run: npm install -g @anthropic-ai/claude-code

      - name: Install SDK
        run: pip install claude-agent-sdk

      - name: Run Code Review
        env:
          ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
        run: python review_agent.py
```

**review_agent.py:**
```python
import asyncio
from claude_agent_sdk import query, ClaudeAgentOptions

async def main():
    async for message in query(
        prompt="Review the changes in this PR for security and code quality",
        options=ClaudeAgentOptions(
            allowed_tools=["Read", "Glob", "Grep", "Bash"],
            permission_mode="bypassPermissions"  # No interactive prompts
        )
    ):
        print(message)

asyncio.run(main())
```

### 3. Docker Deployment

**Dockerfile:**
```dockerfile
FROM node:18-alpine

# Install Claude Code
RUN npm install -g @anthropic-ai/claude-code

# Install Python
RUN apk add --no-cache python3 py3-pip

# Install SDK
RUN pip3 install claude-agent-sdk

# Copy agent code
COPY agent.py /app/agent.py

# Set environment
ENV ANTHROPIC_API_KEY=""

# Run agent
CMD ["python3", "/app/agent.py"]
```

### 4. Rate Limiting

```python
import asyncio
from anthropic import RateLimitError

async def rate_limited_agent(prompt, max_retries=3):
    """Agent with rate limit handling"""

    for attempt in range(max_retries):
        try:
            async for message in query(prompt=prompt, options=...):
                print(message)
            return

        except RateLimitError as e:
            if attempt == max_retries - 1:
                raise

            wait_time = 2 ** attempt
            print(f"Rate limited. Waiting {wait_time}s...")
            await asyncio.sleep(wait_time)
```

---

## Best Practices

### 1. Principle of Least Privilege

```python
# ✅ Good: Only grant needed tools
options = ClaudeAgentOptions(
    allowed_tools=["Read", "Grep"]  # Analysis only
)

# ❌ Bad: Granting all tools
options = ClaudeAgentOptions(
    allowed_tools=None  # Inherits all tools
)
```

### 2. Explicit Prompts

```python
# ✅ Good: Clear, specific task
prompt = """Review @src/auth.py for security vulnerabilities.
Focus on:
1. SQL injection risks
2. XSS vulnerabilities
3. Authentication bypass
4. Weak password validation

Return a list of issues with severity levels."""

# ❌ Bad: Vague task
prompt = "Check the auth file"
```

### 3. Test Agents Thoroughly

```python
import pytest
from claude_agent_sdk import query

@pytest.mark.asyncio
async def test_bug_fixing_agent():
    """Test that agent can fix bugs"""

    # Create file with bug
    with open("test_bug.py", "w") as f:
        f.write("def divide(a, b):\n    return a / b")

    # Run agent
    async for message in query(
        prompt="Add error handling to divide function in @test_bug.py",
        options=...
    ):
        pass

    # Verify fix
    with open("test_bug.py", "r") as f:
        content = f.read()
        assert "except" in content
        assert "ZeroDivisionError" in content
```

### 4. Monitor and Log

```python
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

async def logged_agent(prompt):
    """Agent with comprehensive logging"""

    logger.info(f"Starting agent with prompt: {prompt}")

    try:
        async for message in query(prompt=prompt, options=...):
            logger.debug(f"Received message: {message}")

        logger.info("Agent completed successfully")

    except Exception as e:
        logger.error(f"Agent failed: {e}", exc_info=True)
        raise
```

### 5. Handle Secrets Securely

```python
import os

# ✅ Good: From environment
options = ClaudeAgentOptions(
    env={"API_KEY": os.getenv("API_KEY")}
)

# ❌ Bad: Hardcoded
options = ClaudeAgentOptions(
    env={"API_KEY": "sk-1234567890"}  # NEVER DO THIS
)
```

---

## Examples

### Example 1: Automated Code Reviewer

**Python:**
```python
import asyncio
from claude_agent_sdk import query, ClaudeAgentOptions

async def code_reviewer(pr_number):
    """Reviews a pull request for code quality"""

    async for message in query(
        prompt=f"""
        Review PR #{pr_number}:

        1. Check out the PR branch
        2. Analyze changed files for:
           - Code quality issues
           - Security vulnerabilities
           - Performance problems
           - Missing tests
        3. Generate a review summary with specific suggestions
        """,
        options=ClaudeAgentOptions(
            allowed_tools=["Bash", "Read", "Grep", "Glob"],
            permission_mode="acceptEdits"
        )
    ):
        print(message)

asyncio.run(code_reviewer(123))
```

### Example 2: Documentation Generator

```python
async def documentation_generator():
    """Generates comprehensive documentation"""

    async for message in query(
        prompt="""
        Generate API documentation:

        1. Find all API route files in @src/api/
        2. Extract endpoints, parameters, and responses
        3. Create OpenAPI/Swagger specification
        4. Write human-readable guides
        5. Add code examples

        Save to @docs/api-reference.md
        """,
        options=ClaudeAgentOptions(
            allowed_tools=["Read", "Write", "Glob", "Grep"]
        )
    ):
        print(message)
```

### Example 3: Database Migration Helper

```python
async def migration_helper():
    """Helps create database migrations"""

    async with ClaudeSDKClient(
        options=ClaudeAgentOptions(
            allowed_tools=["Read", "Write", "Edit", "Bash", "Grep"]
        )
    ) as client:

        # Analyze schema
        await client.query("Analyze current database schema in @src/models/")
        async for msg in client.receive_response():
            print(msg)

        # Get user requirements
        await client.query("""
        I need to add:
        - email_verified (boolean)
        - verification_token (string)
        - verified_at (timestamp)

        to the users table. Create a migration.
        """)
        async for msg in client.receive_response():
            print(msg)

        # Update models
        await client.query("Update the User model to include these fields")
        async for msg in client.receive_response():
            print(msg)
```

### Example 4: Test Generator

```python
async def test_generator():
    """Generates comprehensive tests"""

    async for message in query(
        prompt="""
        Generate tests for @src/utils/parser.py:

        1. Read the file
        2. Identify all public functions
        3. For each function, create tests for:
           - Happy path
           - Edge cases
           - Error conditions
           - Boundary values
        4. Save to @tests/utils/test_parser.py
        5. Run pytest to verify tests pass
        """,
        options=ClaudeAgentOptions(
            allowed_tools=["Read", "Write", "Bash", "Glob"],
            permission_mode="acceptEdits"
        )
    ):
        print(message)
```

---

## Troubleshooting

### Common Issues

**Issue: CLINotFoundError**
```
Solution: Install Claude Code
npm install -g @anthropic-ai/claude-code
```

**Issue: Authentication Failed**
```
Solution: Set API key
export ANTHROPIC_API_KEY=your-key
```

**Issue: Agent Stuck in Loop**
```
Solution: Set max_turns
options = ClaudeAgentOptions(max_turns=10)
```

**Issue: Rate Limited**
```
Solution: Implement retry logic with exponential backoff
```

---

## Additional Resources

- **Agent SDK Docs:** https://platform.claude.com/docs/en/agent-sdk
- **Quickstart:** https://platform.claude.com/docs/en/agent-sdk/quickstart
- **Python Reference:** https://platform.claude.com/docs/en/agent-sdk/python
- **TypeScript Reference:** https://platform.claude.com/docs/en/agent-sdk/typescript
- **Example Agents:** https://github.com/anthropics/claude-agent-sdk-demos
- **MCP Documentation:** https://modelcontextprotocol.io

---

**Last Updated:** December 16, 2025
