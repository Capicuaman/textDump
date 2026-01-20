# Claude API HTTP Request Node - Valid JSON Configuration

## Issue Fixed
The JSON parameter needs to be properly escaped for n8n's HTTP Request node. Here's the corrected configuration:

## HTTP Request Node Configuration

### Basic Settings:
- **Node Type:** HTTP Request
- **Method:** POST
- **URL:** `https://api.anthropic.com/v1/messages`
- **Response Format:** JSON

### Authentication:
- **Authentication Type:** Header Auth
- **Name:** `x-api-key`
- **Value:** `sk-ant-your-api-key-here`

### Headers (in Headers section):
```
Content-Type: application/json
anthropic-version: 2023-06-01
```

### Request Body (JSON Mode - Fixed):
```json
{
  "model": "claude-sonnet-4-5",
  "max_tokens": 500,
  "temperature": 0.7,
  "system": "You are a social media content creator for BILAN electrolyte brand. Your voice is authoritative yet accessible, scientific but empowering. Always maintain these brand principles:\n\n1. Euhidratación y Equilibrio - Superior hydration concept\n2. La Batería Humana - Body as battery analogy\n3. Pureza y Calidad Científica - Scientific purity and evidence\n4. La Alternativa Pura - Clean alternative to sugary drinks\n\nContent Guidelines:\n- Be educational and evidence-based\n- Focus on benefits, not just features\n- Use empowering language\n- Include relevant hashtags\n- Keep Twitter posts under 280 characters\n- Aim for 150-200 characters for Instagram\n- Create engagement through questions or calls-to-action\nNever mention competitors directly. Always position BILAN as the superior choice.",
  "messages": [
    {
      "role": "user",
      "content": "{{ $json.prompt_context }}\n\nCreate 3 social media post variations:\n1. Twitter/X post (under 280 chars)\n2. Instagram post (150-200 chars)\n3. LinkedIn post (professional tone, 200-300 chars)\n\nInclude relevant hashtags for each platform. Format as JSON with platform keys: twitter, instagram, linkedin"
    }
  ]
}
```

## Alternative: Use Body Parameters Mode

If JSON mode still gives you trouble, switch to "Body Parameters" mode:

### Key-Value Pairs:
| Key | Type | Value |
|-----|------|-------|
| model | String | claude-sonnet-4-5 |
| max_tokens | Number | 500 |
| temperature | Number | 0.7 |
| system | String | You are a social media content creator for BILAN electrolyte brand... (use the full system prompt) |
| messages | Array | [{"role":"user","content":"{{ $json.prompt_context }}\n\nCreate 3 social media post variations..."}] |

## Alternative 2: Function Node to Build JSON

If the HTTP Request node still has issues, add a Function node before it:

### Pre-Request Function Node:
```javascript
const themeData = $input.first().json;

const requestBody = {
  model: "claude-sonnet-4-5",
  max_tokens: 500,
  temperature: 0.7,
  system: "You are a social media content creator for BILAN electrolyte brand. Your voice is authoritative yet accessible, scientific but empowering. Always maintain these brand principles:\n\n1. Euhidratación y Equilibrio - Superior hydration concept\n2. La Batería Humana - Body as battery analogy\n3. Pureza y Calidad Científica - Scientific purity and evidence\n4. La Alternativa Pura - Clean alternative to sugary drinks\n\nContent Guidelines:\n- Be educational and evidence-based\n- Focus on benefits, not just features\n- Use empowering language\n- Include relevant hashtags\n- Keep Twitter posts under 280 characters\n- Aim for 150-200 characters for Instagram\n- Create engagement through questions or calls-to-action\nNever mention competitors directly. Always position BILAN as the superior choice.",
  messages: [
    {
      role: "user",
      content: `${themeData.prompt_context}\n\nCreate 3 social media post variations:\n1. Twitter/X post (under 280 chars)\n2. Instagram post (150-200 chars)\n3. LinkedIn post (professional tone, 200-300 chars)\n\nInclude relevant hashtags for each platform. Format as JSON with platform keys: twitter, instagram, linkedin`
    }
  ]
};

return {
  json: {
    claude_request_body: JSON.stringify(requestBody)
  }
};
```

### Updated HTTP Request Body:
```json
{{ $json.claude_request_body }}
```

## Testing the API Connection

### Simple Test Request:
```json
{
  "model": "claude-sonnet-4-5",
  "max_tokens": 50,
  "messages": [
    {
      "role": "user",
      "content": "Hello from BILAN!"
    }
  ]
}
```

## Common JSON Issues and Solutions

### Issue 1: Unescaped Characters
**Problem:** Newlines or quotes in strings
**Solution:** Use `\\n` for newlines, escape quotes properly

### Issue 2: Template Variables
**Problem:** `{{ $json.prompt_context }}` causing JSON parsing errors
**Solution:** Use Function node approach above

### Issue 3: Array Formatting
**Problem:** Messages array not properly formatted
**Solution:** Ensure proper JSON array syntax

## Expected Response from Claude
```json
{
  "id": "msg_xxx",
  "type": "message",
  "role": "assistant",
  "content": [
    {
      "type": "text",
      "text": "{\n  \"twitter\": \"Electrolytes power your performance! ⚡ BILAN provides pure, science-backed hydration without the sugar. #Electrolytes #PureHydration #BILAN\",\n  \"instagram\": \"Electrolytes are essential for peak performance! 💪 BILAN delivers pure electrolytes for optimal hydration and recovery. No sugar, no additives - just science. #BILAN #PureHydration #Performance\",\n  \"linkedin\": \"Professional athletes and executives understand that optimal electrolyte balance is crucial for peak performance and cognitive function. BILAN's scientifically formulated electrolyte powder provides pure hydration without the sugars and additives found in conventional sports drinks. #PerformanceNutrition #CorporateWellness #ElectrolyteScience\"\n}"
    }
  ],
  "usage": {
    "input_tokens": 150,
    "output_tokens": 200
  }
}
```

Try the **Function Node approach** first - it's the most reliable way to handle complex JSON with template variables in n8n.