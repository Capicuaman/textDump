# Claude Code Context Management

Understanding how Claude Code manages context is crucial for efficient and effective use. This guide explains context windows, token usage, optimization strategies, and best practices.

## Understanding Context

### What is Context?

Context is the information Claude Code has access to when responding to your requests:
- **Conversation History:** Previous messages in the current session
- **System Prompts:** Instructions defining Claude's behavior
- **Project Files:** Referenced files via `@` mentions
- **CLAUDE.md Content:** Project-specific instructions
- **Tool Use History:** Previous tool calls and their results
- **MCP Server Data:** Data from Model Context Protocol integrations

### Context Window Sizes

| Model | Standard Context | Extended Context (Beta) |
|-------|------------------|-------------------------|
| Claude Sonnet 4.5 | 200K tokens | 1M tokens |
| Claude Opus 4.5 | 200K tokens | - |
| Claude Haiku 4.5 | 200K tokens | - |

**Approximate Conversions:**
- 200K tokens ≈ 150K words ≈ 500 pages of text
- 1M tokens ≈ 750K words ≈ 2,500 pages of text

## Viewing Context Usage

### Visual Context Grid

```bash
> /context
```

Displays a visual grid showing:
- Total tokens used
- Breakdown by message type (user, assistant, system)
- Percentage of context window filled
- Individual message sizes

**Example Output:**
```
Context Usage: 45,234 / 200,000 tokens (22.6%)

System Prompt:    ████░░░░░░  3,451 tokens (1.7%)
User Messages:    ████████░░  15,782 tokens (7.9%)
Assistant:        ████████████░  24,501 tokens (12.3%)
Tool Results:     ███░░░░░░░  1,500 tokens (0.8%)

Remaining: 154,766 tokens (77.4%)
```

### Token Statistics

```bash
> /cost
```

Shows detailed usage statistics:
- Total tokens used (input + output)
- Cached tokens (if prompt caching enabled)
- Cost breakdown by model
- Request count
- Average tokens per request

**Example Output:**
```
Session Statistics
==================
Total Input Tokens:    45,234 ($0.136)
Cached Input Tokens:   12,000 ($0.036)
Total Output Tokens:   23,456 ($0.352)
Total Cost:            $0.524

Requests:             15
Avg Tokens/Request:   4,579
```

## Context Management Strategies

### 1. Conversation Compaction

When context grows too large, use `/compact` to summarize:

```bash
# Basic compaction
> /compact
```

Claude will:
- Analyze the conversation
- Extract key decisions and information
- Create a concise summary
- Replace old messages with summary
- Preserve recent messages for continuity

**Focused Compaction:**
```bash
# Compact but preserve specific context
> /compact focus on the authentication changes we discussed
```

**When to Compact:**
- Context usage > 60-70%
- Starting a new major task
- Before switching topics
- After completing a feature
- When responses become slow

### 2. Session Management

**Export Session:**
```bash
> /export my-feature-work.json
# Saves entire conversation to file

> /export
# Copies to clipboard
```

**Resume Session:**
```bash
> /resume my-feature-work.json
# Continues from exported session

claude -r "session-id"
# Resume by session ID
```

**Fork Session:**
```bash
claude --fork-session -r "session-id"
# Creates new session based on existing one
```

**Benefits:**
- Work on multiple features in parallel
- Return to previous work without context loss
- Share context with teammates
- Archive important conversations

### 3. Selective File Reading

**Instead of:**
```bash
> Read all files in src/
```

**Do:**
```bash
> Find files related to authentication in src/
> Read only @src/auth/index.js and @src/auth/middleware.js
```

**Why:** Reading only necessary files conserves context for conversation.

### 4. Prompt Caching

Prompt caching automatically caches large, repeated content:

**What gets cached:**
- System prompts (if unchanged)
- Large file contents read multiple times
- Project instructions (CLAUDE.md)
- Tool definitions

**Benefits:**
- 90% cost reduction for cached content
- Faster response times
- Doesn't count toward rate limits
- Automatic (no configuration needed)

**Cache Duration:**
- 5 minutes default
- 1 hour for long-context scenarios

**Example Savings:**
```
Without Caching:
- Read 50K token file: $0.15

With Caching (80% cache hits):
- First read: $0.15
- Next 4 reads: $0.015 each = $0.06
- Total: $0.21 vs $0.75 (72% savings)
```

## Optimizing Context Usage

### Best Practices

#### 1. Reference Files Efficiently

**Good:**
```bash
# Reference specific files
> Explain the authentication flow in @src/auth/login.js

# Use glob patterns
> Find and summarize all *.config.js files
```

**Avoid:**
```bash
# Reading entire directories
> Read everything in src/
```

#### 2. Progressive Exploration

**Good Pattern:**
```bash
# Step 1: Find relevant files
> Find all files related to database connection

# Step 2: Read specific files
> Read @src/database/connection.js

# Step 3: Focused question
> How does the connection pool handle errors?
```

**Avoid:**
```bash
# Reading everything upfront
> Read all database files and explain everything
```

#### 3. Clear, Concise Prompts

**Good:**
```bash
> Add error handling to the login function in @src/auth/login.js
> Use try/catch and return appropriate HTTP status codes
```

**Avoid:**
```bash
> So I was thinking maybe we should probably add some kind of error handling, you know, like maybe try/catch or something, to the login function, and also maybe we should think about what to return when there's an error...
```

#### 4. Use Subagents for Large Tasks

**Good:**
```bash
# Delegate to specialized agent
> Use the Explore agent to map out our entire API structure
> Summary: [agent's findings]

# Now work with summary
> Based on that structure, where should I add the new endpoint?
```

**Benefit:** Subagent's full context doesn't persist in main conversation.

### Token-Saving Techniques

#### Use Grep Instead of Reading

**Inefficient:**
```bash
> Read all files in src/ and find uses of 'authenticate'
```

**Efficient:**
```bash
> Search for 'authenticate' in src/** and show me the locations
> Now read @src/auth/index.js lines 45-60
```

#### Summarize Long Outputs

**After long output:**
```bash
> Summarize the key points from that output in bullet format
```

#### Clean Up Todo Lists

```bash
> Remove all completed todos from the list
> Show only in-progress and pending items
```

## Advanced Context Techniques

### 1. Hierarchical Exploration

```bash
# Level 1: High-level overview
> What are the main modules in this project?

# Level 2: Module deep-dive
> Explain the authentication module in detail

# Level 3: Specific implementation
> Show me how JWT tokens are validated in @src/auth/jwt.js
```

### 2. Context Anchoring

**Use # to add to CLAUDE.md:**
```bash
> #This project uses PostgreSQL, not MySQL
> #All API responses must include request_id in headers
> #Run tests before every commit
```

**Why:** These persist across sessions without consuming conversation context.

### 3. Explicit Forgetting

```bash
> We're done with the authentication work. You can forget those details now.
> Let's start fresh on the payment processing feature.
> /compact focus on keeping only payment-related context
```

### 4. Reference Documentation

**Instead of pasting entire docs:**
```bash
# Bad: Pasting 10K token documentation
> Here's our entire API documentation: [massive paste]

# Good: Link + specific question
> Our API docs are at https://docs.example.com
> Fetch the authentication section and explain how OAuth works
```

## Context Preservation Strategies

### What to Keep

**Essential Context:**
- Current task objective
- Recent decisions and their rationale
- Active file references
- Unresolved issues or blockers
- Specific constraints or requirements

**Can be Compressed:**
- Completed tasks
- Historical discussion
- Code that was read but isn't actively being modified
- Exploration results (keep summary only)

### What to Remove

**Safe to Remove:**
- Duplicate information
- Superseded decisions
- Failed attempts (unless learning from them)
- Tangential discussions
- Verbose outputs (keep summaries)

## Model Selection for Context

### Use Haiku for Simple, Context-Light Tasks

```bash
> /model haiku

# Good Haiku tasks:
> Fix this typo
> Run tests
> What does this error mean?
> Format this code
```

**Benefits:**
- Faster responses
- Lower cost
- Conserves context budget

### Use Sonnet (Default) for Most Work

```bash
> /model sonnet

# Good Sonnet tasks:
> Implement this feature
> Debug this issue
> Refactor this code
> Review this PR
```

### Use Opus for Complex, Context-Heavy Tasks

```bash
> /model opus

# Good Opus tasks:
> Design this system architecture
> Debug this complex race condition
> Analyze this entire codebase
> Make critical architectural decisions
```

## Monitoring Context Health

### Signs Context is Too Large

**Symptoms:**
- Slower responses
- Repeated questions about things previously discussed
- Hallucinations or inconsistencies
- "I don't have access to that information" when it was provided earlier
- High token costs

**Solutions:**
1. `/compact` to summarize
2. Start new session for new topic
3. Export and fork for parallel work
4. Remove irrelevant history

### Signs Context is Well-Managed

**Indicators:**
- Fast responses
- Consistent behavior
- Remembers important decisions
- Reasonable token costs
- Clean, focused conversations

## Real-World Context Management

### Example: Feature Development Session

```bash
# Session Start
claude

> I'm working on adding email notifications. Create a todo list:
1. Design email templates
2. Implement sending service
3. Add queue system
4. Write tests
5. Update documentation

# Work through tasks...
# After tasks 1-3 complete:

> /compact Keep the email notification context but compress completed tasks

# Continue with remaining tasks...

# Before ending session:
> /export email-notifications-progress.json

# Next day:
> /resume email-notifications-progress.json
> Show me the todo list. Let's continue with testing.
```

### Example: Codebase Exploration

```bash
# Efficient exploration pattern
> Use Explore agent with medium thoroughness:
  Find all API endpoints and explain the routing structure

# Agent returns summary (doesn't fill main context)

> Based on that, I want to add a new endpoint for user preferences
> Show me the pattern used in @src/api/users.js
> Now create a similar endpoint for preferences
```

## CLI Flags for Context Control

```bash
# Limit conversation turns
claude -p "your query" --max-turns 5

# Set specific model
claude --model haiku "simple task"

# Start with clean context
claude --session-id "$(uuidgen)"

# Resume with specific context
claude -r "session-id" "continue task"
```

## Best Practices Summary

### DO:
✅ Use `/context` regularly to monitor usage
✅ Compact conversations when reaching 60-70% capacity
✅ Export important sessions for later reference
✅ Use `@` to reference files instead of copying content
✅ Start new sessions for unrelated work
✅ Add persistent facts to CLAUDE.md with `#`
✅ Use appropriate model for task complexity
✅ Leverage prompt caching for repeated content
✅ Use subagents for large exploratory tasks
✅ Remove completed todos from lists

### DON'T:
❌ Let context grow to 90%+ before compacting
❌ Read entire large directories at once
❌ Paste massive blocks of text when a link will do
❌ Keep completed work in active context
❌ Mix unrelated topics in one session
❌ Ignore context warnings
❌ Use Opus for simple tasks
❌ Repeat the same large file reads
❌ Include irrelevant history in exports
❌ Forget to compact after major milestones

## Troubleshooting

### Problem: "Context limit reached"

**Solutions:**
```bash
> /compact focus on current task
> /export backup.json
> /clear   # Start fresh if needed
```

### Problem: Slow responses

**Check context:**
```bash
> /context
# If > 70%, compact:
> /compact
```

###Problem: Inconsistent behavior

**Refresh context:**
```bash
> /compact Preserve technical decisions and current task
> #[Re-state critical requirements]
```

### Problem: Forgetting earlier decisions

**Use memory:**
```bash
> #We decided to use JWT, not sessions
> #API rate limit is 1000 requests/hour
> #All dates must be in UTC
```

---

**Last Updated:** December 16, 2025
