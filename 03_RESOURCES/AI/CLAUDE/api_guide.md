# Claude API Guide

Comprehensive guide to using the Claude API (formerly Anthropic API) for building AI-powered applications.

## Table of Contents

1. [Getting Started](#getting-started)
2. [Available Models](#available-models)
3. [Authentication](#authentication)
4. [Making API Calls](#making-api-calls)
5. [Streaming Responses](#streaming-responses)
6. [Tool Use (Function Calling)](#tool-use-function-calling)
7. [Vision Capabilities](#vision-capabilities)
8. [Extended Thinking](#extended-thinking)
9. [Prompt Caching](#prompt-caching)
10. [Rate Limits and Pricing](#rate-limits-and-pricing)
11. [Best Practices](#best-practices)
12. [Error Handling](#error-handling)

---

## Getting Started

### Installation

**Python:**
```bash
pip install anthropic
```

**TypeScript/JavaScript:**
```bash
npm install @anthropic-ai/sdk
```

### Quick Start Example

**Python:**
```python
import anthropic

client = anthropic.Anthropic(api_key="your-api-key-here")

message = client.messages.create(
    model="claude-sonnet-4-5",
    max_tokens=1024,
    messages=[
        {"role": "user", "content": "Hello, Claude!"}
    ]
)

print(message.content[0].text)
```

**TypeScript:**
```typescript
import Anthropic from '@anthropic-ai/sdk';

const client = new Anthropic({
  apiKey: process.env.ANTHROPIC_API_KEY
});

const message = await client.messages.create({
  model: 'claude-sonnet-4-5',
  max_tokens: 1024,
  messages: [
    { role: 'user', content: 'Hello, Claude!' }
  ]
});

console.log(message.content[0].text);
```

---

## Available Models

### Current Model Family

| Model | Model ID | Context | Max Output | Pricing (Input/Output per MTok) |
|-------|----------|---------|------------|----------------------------------|
| **Claude Opus 4.5** | `claude-opus-4-5-20251101` | 200K | 64K | $5 / $25 |
| **Claude Sonnet 4.5** | `claude-sonnet-4-5-20250929` | 200K | 64K | $3 / $15 |
| **Claude Haiku 4.5** | `claude-haiku-4-5-20251001` | 200K | 64K | $1 / $5 |

### Model Selection Guide

**Claude Sonnet 4.5 (Recommended for most use cases):**
- Best balance of intelligence, speed, and cost
- Ideal for: Coding, agentic tasks, complex reasoning
- Beta: 1M context window available

**Claude Opus 4.5 (Maximum intelligence):**
- Premium model for highest quality
- Ideal for: Complex reasoning, high-stakes decisions
- Use when quality is paramount

**Claude Haiku 4.5 (Fast and cost-effective):**
- Near-frontier intelligence with fastest speed
- Ideal for: Simple tasks, high-volume processing
- Use for cost optimization

### Versioned vs Aliased Model IDs

**Production: Use versioned IDs**
```python
model="claude-sonnet-4-5-20250929"  # Pinned version
```

**Development: Use aliases**
```python
model="claude-sonnet-4-5"  # Latest version
```

---

## Authentication

### API Key Setup

**Get API Key:**
1. Visit https://console.anthropic.com/account/keys
2. Create new key
3. Copy and store securely

**Environment Variable (Recommended):**
```bash
export ANTHROPIC_API_KEY='your-api-key-here'
```

**Python:**
```python
import anthropic

# From environment (automatic)
client = anthropic.Anthropic()

# Explicit
client = anthropic.Anthropic(api_key="your-key")
```

**TypeScript:**
```typescript
import Anthropic from '@anthropic-ai/sdk';

// From environment
const client = new Anthropic({
  apiKey: process.env.ANTHROPIC_API_KEY
});

// Explicit
const client = new Anthropic({
  apiKey: 'your-key'
});
```

---

## Making API Calls

### Basic Message Creation

**Python:**
```python
response = client.messages.create(
    model="claude-sonnet-4-5",
    max_tokens=1024,
    messages=[
        {"role": "user", "content": "Explain quantum computing in simple terms"}
    ]
)

print(response.content[0].text)
```

**TypeScript:**
```typescript
const response = await client.messages.create({
  model: 'claude-sonnet-4-5',
  max_tokens: 1024,
  messages: [
    { role: 'user', content: 'Explain quantum computing in simple terms' }
  ]
});

console.log(response.content[0].text);
```

### Multi-Turn Conversations

The API is stateless - include full conversation history:

**Python:**
```python
conversation = [
    {"role": "user", "content": "Hello, I need help with Python"},
    {"role": "assistant", "content": "I'd be happy to help! What do you need assistance with?"},
    {"role": "user", "content": "How do I read a CSV file?"}
]

response = client.messages.create(
    model="claude-sonnet-4-5",
    max_tokens=1024,
    messages=conversation
)
```

### System Prompts

Define behavior and context:

**Python:**
```python
response = client.messages.create(
    model="claude-sonnet-4-5",
    max_tokens=1024,
    system="You are a helpful Python expert. Always provide code examples.",
    messages=[
        {"role": "user", "content": "How do I sort a list?"}
    ]
)
```

**Multi-part System Prompts:**
```python
response = client.messages.create(
    model="claude-sonnet-4-5",
    max_tokens=1024,
    system=[
        {
            "type": "text",
            "text": "You are a code reviewer."
        },
        {
            "type": "text",
            "text": large_style_guide,
            "cache_control": {"type": "ephemeral"}  # Cache this part
        }
    ],
    messages=[...]
)
```

---

## Streaming Responses

Stream responses in real-time for better UX:

**Python:**
```python
with client.messages.stream(
    model="claude-sonnet-4-5",
    max_tokens=1024,
    messages=[{"role": "user", "content": "Write a story about a robot"}]
) as stream:
    for text in stream.text_stream:
        print(text, end="", flush=True)
```

**TypeScript:**
```typescript
const stream = await client.messages.stream({
  model: 'claude-sonnet-4-5',
  max_tokens: 1024,
  messages: [{ role: 'user', content: 'Write a story about a robot' }]
});

for await (const event of stream) {
  if (event.type === 'content_block_delta' && event.delta.type === 'text_delta') {
    process.stdout.write(event.delta.text);
  }
}
```

### Stream Event Types

```python
# message_start - Initial message metadata
# content_block_start - Content block begins
# content_block_delta - Incremental content updates
# content_block_stop - Content block complete
# message_delta - Message-level updates
# message_stop - Final message
```

**Handling All Events:**
```python
with client.messages.stream(...) as stream:
    for event in stream:
        if event.type == "text":
            print(event.text, end="")
        elif event.type == "content_block_start":
            print(f"\n[Block started: {event.content_block.type}]")
        elif event.type == "message_stop":
            print("\n[Message complete]")
```

---

## Tool Use (Function Calling)

Enable Claude to call external functions and APIs.

### Defining Tools

**Python:**
```python
tools = [
    {
        "name": "get_weather",
        "description": "Get current weather for a location",
        "input_schema": {
            "type": "object",
            "properties": {
                "location": {
                    "type": "string",
                    "description": "City and state, e.g., San Francisco, CA"
                },
                "unit": {
                    "type": "string",
                    "enum": ["celsius", "fahrenheit"],
                    "description": "Temperature unit"
                }
            },
            "required": ["location"]
        }
    }
]

response = client.messages.create(
    model="claude-sonnet-4-5",
    max_tokens=1024,
    tools=tools,
    messages=[{"role": "user", "content": "What's the weather in NYC?"}]
)
```

### Processing Tool Calls

**Complete Tool Use Loop:**
```python
def execute_tool(tool_name, tool_input):
    """Execute tool and return result"""
    if tool_name == "get_weather":
        # Call your weather API
        return {"temperature": 72, "condition": "sunny"}

conversation = [{"role": "user", "content": "What's the weather in NYC?"}]

while True:
    response = client.messages.create(
        model="claude-sonnet-4-5",
        max_tokens=1024,
        tools=tools,
        messages=conversation
    )

    # Add assistant response to conversation
    conversation.append({
        "role": "assistant",
        "content": response.content
    })

    # Check if tool use requested
    tool_use = next(
        (block for block in response.content if block.type == "tool_use"),
        None
    )

    if not tool_use:
        # No tool use, conversation complete
        final_text = next(
            (block.text for block in response.content if hasattr(block, "text")),
            None
        )
        print(final_text)
        break

    # Execute tool
    tool_result = execute_tool(tool_use.name, tool_use.input)

    # Add tool result to conversation
    conversation.append({
        "role": "user",
        "content": [
            {
                "type": "tool_result",
                "tool_use_id": tool_use.id,
                "content": str(tool_result)
            }
        ]
    })
```

### Server-Side Tools

Claude can use built-in tools:

**Web Search:**
```python
response = client.messages.create(
    model="claude-sonnet-4-5",
    max_tokens=1024,
    tools=["web_search_20250305"],
    messages=[{"role": "user", "content": "What are the latest AI developments in 2025?"}]
)
```

**Code Execution:**
```python
response = client.messages.create(
    model="claude-sonnet-4-5",
    max_tokens=1024,
    tools=[{"type": "code_execution"}],
    messages=[{"role": "user", "content": "Calculate the first 10 Fibonacci numbers"}]
)
```

---

## Vision Capabilities

Claude can analyze images in JPEG, PNG, GIF, and WebP formats.

### Image from Base64

**Python:**
```python
import base64
import httpx

# Load and encode image
image_url = "https://example.com/image.jpg"
image_data = base64.standard_b64encode(
    httpx.get(image_url).content
).decode("utf-8")

response = client.messages.create(
    model="claude-sonnet-4-5",
    max_tokens=1024,
    messages=[
        {
            "role": "user",
            "content": [
                {
                    "type": "image",
                    "source": {
                        "type": "base64",
                        "media_type": "image/jpeg",
                        "data": image_data
                    }
                },
                {
                    "type": "text",
                    "text": "Describe this image in detail"
                }
            ]
        }
    ]
)
```

### Multiple Images

```python
response = client.messages.create(
    model="claude-sonnet-4-5",
    max_tokens=1024,
    messages=[
        {
            "role": "user",
            "content": [
                {"type": "image", "source": {"type": "base64", "media_type": "image/jpeg", "data": image1_data}},
                {"type": "image", "source": {"type": "base64", "media_type": "image/jpeg", "data": image2_data}},
                {"type": "text", "text": "Compare these two images"}
            ]
        }
    ]
)
```

### Image Best Practices

- **Maximum size:** 5MB per image (API), 10MB (claude.ai)
- **Recommended max dimension:** 1568px (1.15 megapixels)
- **Token calculation:** ~1 token per 750 pixels
- **Maximum images:** 100 per request (API), 20 per turn (claude.ai)
- **Optimization:** Resize large images to save tokens

---

## Extended Thinking

Enable enhanced reasoning for complex problems:

**Python:**
```python
response = client.messages.create(
    model="claude-sonnet-4-5",
    max_tokens=20000,
    thinking={
        "type": "enabled",
        "budget_tokens": 16000
    },
    messages=[
        {"role": "user", "content": "Solve this complex mathematical proof..."}
    ]
)

# Access thinking process
for block in response.content:
    if block.type == "thinking":
        print(f"Reasoning: {block.thinking}")
    elif block.type == "text":
        print(f"Answer: {block.text}")
```

**When to Use:**
- Complex mathematical problems
- Multi-step reasoning tasks
- Code debugging requiring deep analysis
- Strategic planning
- Ambiguous problem solving

---

## Prompt Caching

Reduce costs by caching large, repeated content.

### Basic Caching

**Python:**
```python
response = client.messages.create(
    model="claude-sonnet-4-5",
    max_tokens=1024,
    system=[
        {
            "type": "text",
            "text": "You are a helpful assistant."
        },
        {
            "type": "text",
            "text": large_document_content,  # This will be cached
            "cache_control": {"type": "ephemeral"}
        }
    ],
    messages=[
        {"role": "user", "content": "Summarize the key points"}
    ]
)
```

### Cache Duration

- **Standard:** 5 minutes
- **Extended (Beta):** 1 hour

### Cost Savings

| Scenario | Without Caching | With Caching (80% hit rate) | Savings |
|----------|-----------------|----------------------------|---------|
| 100K tokens, 10 requests | $3.00 | $0.78 | 74% |
| 200K tokens, 100 requests | $60.00 | $15.00 | 75% |

**Cached Token Pricing (Sonnet):**
- 5-minute cache: $0.30/MTok (90% discount)
- 1-hour cache: $6/MTok (50% discount)

### What to Cache

**Good Candidates:**
- Large system prompts
- Documentation
- Code libraries
- Style guides
- Knowledge bases
- Few-shot examples

**Poor Candidates:**
- User messages (changes every request)
- Dynamic content
- Small content (< 1024 tokens)

---

## Rate Limits and Pricing

### Tier System

| Tier | Entry Cost | Max Monthly | Advancement |
|------|-----------|-------------|-------------|
| Tier 1 | $5 | $100 | Automatic |
| Tier 2 | $40 | $500 | Automatic |
| Tier 3 | $200 | $1,000 | Automatic |
| Tier 4 | $400 | Custom (5K+) | Request |

### Rate Limits (Tier 1 Example - Sonnet)

- **Requests per minute (RPM):** 50
- **Input tokens per minute (ITPM):** 30,000
- **Output tokens per minute (OTPM):** 8,000

**Note:** Cached tokens don't count toward ITPM limits.

### Pricing (Per Million Tokens)

**Standard Models:**
- Opus 4.5: $5 input / $25 output
- Sonnet 4.5: $3 input / $15 output
- Haiku 4.5: $1 input / $5 output

**Batch API (50% discount):**
- Sonnet 4.5: $1.50 input / $7.50 output
- Results within 24 hours

**Additional Features:**
- Web search: $10 per 1,000 searches
- Code execution: $0.05/hour (50 free hours/day)

### Monitoring Usage

**Check Response Headers:**
```python
response = client.messages.create(...)

# Available in response headers
print(response.usage.input_tokens)
print(response.usage.output_tokens)
```

**Console Dashboard:**
- Usage: https://platform.claude.com/settings/usage
- Limits: https://platform.claude.com/settings/limits

---

## Best Practices

### 1. Be Clear and Direct

**Good:**
```python
prompt = """Your task is to extract contact information from customer emails.

Instructions:
1. Extract name, email, and phone number
2. Validate email format
3. Format phone as (xxx) xxx-xxxx
4. Return as JSON

Email: {email_text}"""
```

**Bad:**
```python
prompt = "Can you maybe look at this email and try to find some contact info?"
```

### 2. Use XML Tags for Structure

```python
prompt = """<document>
{large_document}
</document>

<question>
Summarize the key findings about climate change from the document.
</question>

<constraints>
- Maximum 500 words
- Include specific data points
- Use bullet points for clarity
</constraints>"""
```

### 3. Provide Examples (Few-Shot Learning)

```python
system = """You extract structured data from text.

Examples:

Input: "John Smith, age 30, works at Google"
Output: {"name": "John Smith", "age": 30, "company": "Google"}

Input: "Alice Johnson, 25, employed by Microsoft"
Output: {"name": "Alice Johnson", "age": 25, "company": "Microsoft"}

Now process the following:"""

messages = [{"role": "user", "content": "Bob Williams, age 40, works at Apple"}]
```

### 4. Chain-of-Thought Prompting

```python
prompt = """Before answering, think through this step-by-step:

1. What information do I have?
2. What information do I need?
3. How can I solve this?
4. What's my final answer?

Question: {question}"""
```

### 5. Optimize Token Usage

```python
# Use prompt caching for repeated content
# Choose appropriate model (Haiku for simple tasks)
# Set reasonable max_tokens
# Use batch API for high-volume, non-urgent requests

response = client.messages.create(
    model="claude-haiku-4-5",  # Cheaper for simple tasks
    max_tokens=500,  # Not more than needed
    messages=[...]
)
```

### 6. Handle Rate Limits with Retry

**Python with Exponential Backoff:**
```python
import time
from anthropic import RateLimitError

def call_with_retry(max_retries=3):
    for attempt in range(max_retries):
        try:
            return client.messages.create(
                model="claude-sonnet-4-5",
                max_tokens=1024,
                messages=[{"role": "user", "content": "Hello"}]
            )
        except RateLimitError as e:
            if attempt == max_retries - 1:
                raise

            wait_time = 2 ** attempt  # Exponential backoff
            print(f"Rate limited. Waiting {wait_time}s...")
            time.sleep(wait_time)
```

### 7. Structured Outputs with JSON Schema

```python
response = client.messages.create(
    model="claude-sonnet-4-5",
    max_tokens=1024,
    tools=[
        {
            "name": "extract_data",
            "description": "Extract user data",
            "input_schema": {
                "type": "object",
                "properties": {
                    "name": {"type": "string"},
                    "age": {"type": "integer"},
                    "email": {"type": "string", "format": "email"}
                },
                "required": ["name", "age", "email"]
            },
            "strict": True  # Guarantees schema conformance
        }
    ],
    tool_choice={"type": "tool", "name": "extract_data"},
    messages=[{"role": "user", "content": "Extract: John Doe, 30, john@example.com"}]
)
```

---

## Error Handling

### Common Error Codes

| Code | Error | Meaning | Solution |
|------|-------|---------|----------|
| 400 | Invalid Request | Malformed request | Check request format |
| 401 | Authentication Error | Bad API key | Verify API key |
| 429 | Rate Limit | Too many requests | Implement retry with backoff |
| 500 | Server Error | Internal error | Retry request |
| 529 | Overloaded | API temporarily overloaded | Retry with exponential backoff |

### Error Handling Example

**Python:**
```python
from anthropic import (
    APIError,
    RateLimitError,
    APIConnectionError,
    AuthenticationError
)

try:
    response = client.messages.create(...)

except AuthenticationError as e:
    print(f"Authentication failed: {e}")
    print("Check your API key")

except RateLimitError as e:
    print(f"Rate limited: {e}")
    retry_after = e.retry_after if hasattr(e, 'retry_after') else 60
    print(f"Retry after {retry_after} seconds")

except APIConnectionError as e:
    print(f"Network error: {e}")
    print("Check your internet connection")

except APIError as e:
    print(f"API error: {e}")
    print(f"Request ID: {e._request_id}")

except Exception as e:
    print(f"Unexpected error: {e}")
```

**TypeScript:**
```typescript
import { APIError, RateLimitError } from '@anthropic-ai/sdk';

try {
  const response = await client.messages.create(...);

} catch (error) {
  if (error instanceof RateLimitError) {
    console.log('Rate limited:', error.message);
  } else if (error instanceof APIError) {
    console.log('API error:', error.status, error.message);
  } else {
    console.log('Unexpected error:', error);
  }
}
```

---

## Quick Reference

### Python SDK

```python
import anthropic

# Initialize
client = anthropic.Anthropic(api_key="your-key")

# Simple message
response = client.messages.create(
    model="claude-sonnet-4-5",
    max_tokens=1024,
    messages=[{"role": "user", "content": "Hello"}]
)

# Streaming
with client.messages.stream(...) as stream:
    for text in stream.text_stream:
        print(text, end="")

# With tools
response = client.messages.create(
    model="claude-sonnet-4-5",
    max_tokens=1024,
    tools=[{...}],
    messages=[...]
)
```

### TypeScript SDK

```typescript
import Anthropic from '@anthropic-ai/sdk';

// Initialize
const client = new Anthropic({ apiKey: 'your-key' });

// Simple message
const response = await client.messages.create({
  model: 'claude-sonnet-4-5',
  max_tokens: 1024,
  messages: [{ role: 'user', content: 'Hello' }]
});

// Streaming
const stream = await client.messages.stream({...});
for await (const event of stream) {
  console.log(event);
}
```

---

## Additional Resources

- **Platform Console:** https://platform.claude.com
- **API Reference:** https://platform.claude.com/docs/api
- **Community Forum:** https://anthropic.com/community
- **Status Page:** https://status.anthropic.com
- **Rate Limits:** https://platform.claude.com/settings/limits
- **Usage Tracking:** https://platform.claude.com/settings/usage

---

**Last Updated:** December 16, 2025
