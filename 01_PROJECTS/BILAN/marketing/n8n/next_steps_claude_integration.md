# Next Steps: Using Theme Selector Output for AI Content Generation

## What You Have Now
Your theme selector outputs structured data like:
```json
{
  "theme": "What Are Electrolytes?",
  "focus": "Basic electrolyte education", 
  "keywords": ["electrolytes", "hydration", "minerals", "body function"],
  "category": "educational",
  "content_angle": "Educational foundation post",
  "call_to_action": "Learn more about electrolyte balance",
  "content_id": "bilan_1642234567890",
  "prompt_context": "Create social media content about: What Are Electrolytes?..."
}
```

## Step 1: Configure Claude API HTTP Request Node

### Node Setup:
- **Node Type:** HTTP Request
- **Name:** Claude API Content Generator
- **Method:** POST
- **URL:** `https://api.anthropic.com/v1/messages`

### Authentication:
- **Authentication Type:** Header Auth
- **Header Name:** `x-api-key`
- **Header Value:** Your Claude API key (sk-ant-...)
- **Additional Headers:**
  ```
  Content-Type: application/json
  anthropic-version: 2023-06-01
  ```

### Request Body (JSON Mode):
```json
{
  "model": "claude-sonnet-4-5",
  "max_tokens": 500,
  "temperature": 0.7,
  "system": "You are a social media content creator for BILAN electrolyte brand. Your voice is authoritative yet accessible, scientific but empowering. Always maintain these brand principles:\n\n1. Euhidratación y Equilibrio - Superior hydration concept\n2. La Batería Humana - Body as battery analogy  \n3. Pureza y Calidad Científica - Scientific purity and evidence\n4. La Alternativa Pura - Clean alternative to sugary drinks\n\nContent Guidelines:\n- Be educational and evidence-based\n- Focus on benefits, not just features\n- Use empowering language\n- Include relevant hashtags\n- Keep Twitter posts under 280 characters\n- Aim for 150-200 characters for Instagram\n- Create engagement through questions or calls-to-action\n\nNever mention competitors directly. Always position BILAN as the superior choice.",
  "messages": [
    {
      "role": "user", 
      "content": "{{ $json.prompt_context }}\n\nCreate 3 social media post variations:\n1. Twitter/X post (under 280 chars)\n2. Instagram post (150-200 chars)\n3. LinkedIn post (professional tone, 200-300 chars)\n\nInclude relevant hashtags for each platform. Format as JSON with platform keys: twitter, instagram, linkedin"
    }
  ]
}
```

## Step 2: Add Content Formatter Function

Create another Function node after Claude API to parse the response:

```javascript
// Parse Claude API response
const aiResponse = $input.first().json;
const themeData = $input.all()[1].json;

// Extract content from Claude response
let contentPosts;
try {
  const contentText = aiResponse.content[0].text;
  contentPosts = JSON.parse(contentText);
} catch (error) {
  contentPosts = {
    twitter: "Error parsing AI content",
    instagram: "Error parsing AI content",
    linkedin: "Error parsing AI content"
  };
}

// Format for storage and review
const formattedContent = {
  content_id: themeData.content_id,
  generated_at: new Date().toISOString(),
  theme: themeData.theme,
  category: themeData.category,
  focus: themeData.focus,
  keywords: themeData.keywords,
  posts: {
    twitter: {
      content: contentPosts.twitter || "",
      character_count: (contentPosts.twitter || "").length,
      hashtags: (contentPosts.twitter || "").match(/#\w+/g) || [],
      platform: "Twitter/X"
    },
    instagram: {
      content: contentPosts.instagram || "",
      character_count: (contentPosts.instagram || "").length,
      hashtags: (contentPosts.instagram || "").match(/#\w+/g) || [],
      platform: "Instagram"
    },
    linkedin: {
      content: contentPosts.linkedin || "",
      character_count: (contentPosts.linkedin || "").length,
      hashtags: (contentPosts.linkedin || "").match(/#\w+/g) || [],
      platform: "LinkedIn"
    }
  },
  usage: aiResponse.usage,
  status: "generated",
  approval_status: "pending"
};

return {
  json: formattedContent
};
```

## Step 3: Add Google Docs Storage (Optional but Recommended)

### Google Docs Node Setup:
- **Node Type:** Google Docs
- **Operation:** Create Document
- **Document Title:** `BILAN Social Content - {{ $json.theme }} - {{ $json.content_id }}`

### Document Content:
```
# BILAN Social Media Content - {{ $json.theme }}

**Generated:** {{ $json.generated_at }}
**Content ID:** {{ $json.content_id }}
**Category:** {{ $json.category }}
**Focus:** {{ $json.focus }}
**Keywords:** {{ $json.keywords.join(', ') }}

---

## Twitter/X Post ({{ $json.posts.twitter.character_count }} chars)
{{ $json.posts.twitter.content }}

Hashtags: {{ $json.posts.twitter.hashtags.join(', ') }}

---

## Instagram Post ({{ $json.posts.instagram.character_count }} chars)
{{ $json.posts.instagram.content }}

Hashtags: {{ $json.posts.instagram.hashtags.join(', ') }}

---

## LinkedIn Post ({{ $json.posts.linkedin.character_count }} chars)
{{ $json.posts.linkedin.content }}

Hashtags: {{ $json.posts.linkedin.hashtags.join(', ') }}

---

## Usage Statistics
- **Input Tokens:** {{ $json.usage.input_tokens }}
- **Output Tokens:** {{ $json.usage.output_tokens }}
- **Total Tokens:** {{ $json.usage.input_tokens + $json.usage.output_tokens }}

---

## Approval Checklist
- [ ] Brand voice aligned
- [ ] Scientific accuracy verified
- [ ] Hashtag relevance checked
- [ ] Character count appropriate
- [ ] Call-to-action clear

**Status:** {{ $json.approval_status }}
```

## Step 4: Test Your Complete Workflow

### Testing Sequence:
1. **Manual Test:** Execute workflow manually
2. **Check Theme Selector:** Verify random theme selection
3. **Verify Claude API:** Confirm content generation
4. **Validate Content:** Check for brand alignment and quality
5. **Test Google Docs:** Ensure document creation and formatting

### What to Look For:
- ✅ Random theme selection working
- ✅ Claude API responding correctly
- ✅ Content matches BILAN brand voice
- ✅ Character counts appropriate for each platform
- ✅ Hashtags relevant and well-formatted
- ✅ Google Docs created with proper formatting

## Expected Workflow Flow:
```
Schedule Trigger → Theme Selector → Claude API → Content Formatter → Google Docs
```

## Troubleshooting Common Issues:

### Claude API Errors:
- **401 Authentication:** Check API key format
- **429 Rate Limit:** Wait and retry
- **500 Server Error:** Try again in 30 seconds

### Content Quality Issues:
- **Too generic:** Add more specific context to prompt
- **Wrong tone:** Adjust system prompt
- **Too long/short:** Modify character count instructions

### Google Docs Issues:
- **Authentication:** Set up Google OAuth2 properly
- **Formatting:** Check template syntax
- **Permissions:** Ensure Drive access

## Advanced Options (Once Basic Works):

1. **Add Error Handling:** Error Trigger node for API failures
2. **Add Social Posting:** Twitter API, Instagram Basic Display
3. **Add Content Calendar:** Track published vs scheduled content
4. **Add Analytics:** Track post performance metrics
5. **Add Multi-language:** Spanish content generation

Ready to configure the Claude API node with your theme selector output?