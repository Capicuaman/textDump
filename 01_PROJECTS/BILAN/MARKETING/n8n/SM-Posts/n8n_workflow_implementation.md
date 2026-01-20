# BILAN AI Social Media Content Generator - n8n Workflow Implementation

## Overview
Complete n8n workflow for automated social media content generation using Claude API with BILAN brand consistency.

## Workflow Architecture

```
Schedule Trigger → Theme Selector → Claude API → Content Formatter → Google Docs → Error Handler
```

## Phase 1: Core Workflow Setup

### Node 1: Schedule Trigger
**Purpose:** Automate content generation on regular intervals

**Configuration:**
- **Node Type:** Schedule Trigger
- **Trigger Mode:** Cron Expression
- **Schedule Options:**
  - **Daily Posts:** `0 9 * * *` (9:00 AM daily)
  - **Weekly Posts:** `0 9 * * 1` (9:00 AM Monday)
  - **Testing:** `*/5 * * * *` (every 5 minutes for testing)

**Settings:**
```
Mode: Cron
Cron Expression: 0 9 * * * 
Timezone: America/New_York (or your local timezone)
```

**Output Data:**
```json
{
  "timestamp": "2025-01-15T09:00:00Z",
  "run_id": "schedule_20250115_0900"
}
```

### Node 2: Theme Selector Function
**Purpose:** Randomly select content themes from BILAN's brand materials

**Configuration:**
- **Node Type:** Function (JavaScript)
- **Function Name:** `selectRandomTheme`

**JavaScript Code:**
```javascript
// BILAN Content Themes Database
const contentThemes = {
  educational: [
    {
      theme: "What Are Electrolytes?",
      focus: "Basic electrolyte education",
      keywords: ["electrolytes", "hydration", "minerals", "body function"]
    },
    {
      theme: "The Role of Electrolytes in Hydration",
      focus: "Hydration science",
      keywords: ["hydration", "water balance", "fluid retention", "cellular hydration"]
    },
    {
      theme: "Electrolytes for Performance and Recovery",
      focus: "Athletic performance",
      keywords: ["performance", "recovery", "athletics", "endurance", "muscle function"]
    },
    {
      theme: "Sodium: The Misunderstood Electrolyte",
      focus: "Sodium education",
      keywords: ["sodium", "salt", "blood pressure", "essential mineral"]
    },
    {
      theme: "Potassium: The Heart Mineral",
      focus: "Potassium benefits",
      keywords: ["potassium", "heart health", "muscle cramps", "nervous system"]
    }
  ],
  brand_pillars: [
    {
      theme: "Euhidratación y Equilibrio",
      focus: "Superior hydration concept",
      keywords: ["euhidratación", "balance", "optimal hydration", "electrolyte balance"]
    },
    {
      theme: "La Batería Humana",
      focus: "Body as battery analogy",
      keywords: ["batería", "energy", "cellular energy", "power", "vitality"]
    },
    {
      theme: "Pureza y Calidad Científica",
      focus: "Scientific purity",
      keywords: ["pureza", "calidad", "científico", "libre de aditivos", "evidencia"]
    },
    {
      theme: "La Alternativa Pura",
      focus: "Clean alternative to sugary drinks",
      keywords: ["alternativa", "sin azúcar", "limpio", "natural", "saludable"]
    }
  ],
  seasonal: [
    {
      theme: "Summer Hydration Essentials",
      focus: "Hot weather hydration",
      keywords: ["verano", "calor", "deshidratación", "clima cálido", "sol"]
    },
    {
      theme: "Winter Indoor Hydration",
      focus: "Cold weather hydration",
      keywords: ["invierno", "calefacción", "clima seco", "interior", "humedad"]
    },
    {
      theme: "Holiday Health & Hydration",
      focus: "Seasonal wellness",
      keywords: ["fiestas", "salud", "celebración", "equilibrio", "moderación"]
    }
  ],
  product_focus: [
    {
      theme: "BILAN vs Sports Drinks",
      focus: "Product comparison",
      keywords: ["comparación", "bebidas deportivas", "azúcar", "aditivos", "limpio"]
    },
    {
      theme: "The Science Behind BILAN",
      focus: "Product formulation",
      keywords: ["ciencia", "formulación", "ingredientes", "investigación", "eficacia"]
    },
    {
      theme: "How to Use BILAN Daily",
      focus: "Usage instructions",
      keywords: ["cómo usar", "dosificación", "diario", "rutina", "mejor momento"]
    }
  ]
};

// Random selection function
function selectRandomTheme() {
  const categories = Object.keys(contentThemes);
  const randomCategory = categories[Math.floor(Math.random() * categories.length)];
  const themesInCategory = contentThemes[randomCategory];
  const selectedTheme = themesInCategory[Math.floor(Math.random() * themesInCategory.length)];
  
  return {
    ...selectedTheme,
    category: randomCategory,
    selected_at: new Date().toISOString(),
    content_id: `bilan_${Date.now()}`
  };
}

// Execute selection
const selectedTheme = selectRandomTheme();

// Output for next node
return [{
  json: {
    theme: selectedTheme.theme,
    focus: selectedTheme.focus,
    keywords: selectedTheme.keywords,
    category: selectedTheme.category,
    content_id: selectedTheme.content_id,
    selected_at: selectedTheme.selected_at,
    prompt_context: `Create social media content about: ${selectedTheme.theme}. Focus: ${selectedTheme.focus}. Include keywords: ${selectedTheme.keywords.join(', ')}. Category: ${selectedTheme.category}.`
  }
}];
```

**Output Data:**
```json
{
  "theme": "What Are Electrolytes?",
  "focus": "Basic electrolyte education",
  "keywords": ["electrolytes", "hydration", "minerals", "body function"],
  "category": "educational",
  "content_id": "bilan_1642234567890",
  "selected_at": "2025-01-15T09:00:00Z",
  "prompt_context": "Create social media content about: What Are Electrolytes?. Focus: Basic electrolyte education. Include keywords: electrolytes, hydration, minerals, body function. Category: educational."
}
```

## Phase 2: AI Content Generation

### Node 3: Claude API HTTP Request
**Purpose:** Generate brand-aligned social media content using Claude API

**Configuration:**
- **Node Type:** HTTP Request
- **Method:** POST
- **URL:** `https://api.anthropic.com/v1/messages`
- **Authentication:** Header Auth
- **Headers:**
  ```
  x-api-key: {{ $credentials.ClaudeAPI.headerValue }}
  Content-Type: application/json
  anthropic-version: 2023-06-01
  ```

**Request Body (JSON):**
```json
{
  "model": "claude-sonnet-4-5",
  "max_tokens": 500,
  "temperature": 0.7,
  "system": "You are a social media content creator for BILAN electrolyte brand. Your voice is authoritative yet accessible, scientific but empowering. Always maintain these brand principles:\n\n1. Euhidratación y Equilibrio - Superior hydration concept\n2. La Batería Humana - Body as battery analogy\n3. Pureza y Calidad Científica - Scientific purity and evidence\n4. La Alternativa Pura - Clean alternative to sugary drinks\n\nContent Guidelines:\n- Be educational and evidence-based\n- Focus on benefits, not just features\n- Use empowering language\n- Include relevant hashtags\n- Keep posts under 280 characters for Twitter compatibility\n- Aim for 150-200 characters for Instagram\n- Create engagement through questions or calls-to-action\n\nNever mention competitors directly. Always position BILAN as the superior choice.",
  "messages": [
    {
      "role": "user",
      "content": "{{ $json.prompt_context }}\n\nCreate 3 social media post variations:\n1. Twitter/X post (under 280 chars)\n2. Instagram post (150-200 chars)\n3. LinkedIn post (professional tone, 200-300 chars)\n\nInclude relevant hashtags for each platform. Format as JSON with platform keys."
    }
  ]
}
```

**Expected Response:**
```json
{
  "id": "msg_xxx",
  "type": "message",
  "role": "assistant",
  "content": [
    {
      "type": "text",
      "text": "{\n  \"twitter\": \"Electrolytes are your body's essential minerals! ⚡ They regulate hydration, nerve signals, and muscle function. Most people don't get enough. #Electrolytes #Hydration #Health\",\n  \"instagram\": \"Electrolytes are the unsung heroes of your body! 💪 These essential minerals power everything from hydration to muscle function. Are you getting enough? #BILAN #ElectrolyteBalance #PureHydration\",\n  \"linkedin\": \"Electrolyte optimization is crucial for peak performance and recovery. These essential minerals regulate cellular hydration, nerve transmission, and muscle contraction. Professional athletes understand that proper electrolyte balance can be the difference between good and great performance. #ElectrolyteScience #PerformanceNutrition #CorporateWellness\"\n}"
    }
  ],
  "usage": {
    "input_tokens": 150,
    "output_tokens": 200
  }
}
```

## Phase 3: Content Processing & Storage

### Node 4: Content Formatter Function
**Purpose:** Parse AI response and format for storage

**Configuration:**
- **Node Type:** Function (JavaScript)
- **Function Name:** `formatContentForStorage`

**JavaScript Code:**
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
  // Fallback if JSON parsing fails
  contentPosts = {
    twitter: "Error parsing content",
    instagram: "Error parsing content", 
    linkedin: "Error parsing content"
  };
}

// Format for Google Docs
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
      hashtags: extractHashtags(contentPosts.twitter || ""),
      platform: "Twitter/X"
    },
    instagram: {
      content: contentPosts.instagram || "",
      character_count: (contentPosts.instagram || "").length,
      hashtags: extractHashtags(contentPosts.instagram || ""),
      platform: "Instagram"
    },
    linkedin: {
      content: contentPosts.linkedin || "",
      character_count: (contentPosts.linkedin || "").length,
      hashtags: extractHashtags(contentPosts.linkedin || ""),
      platform: "LinkedIn"
    }
  },
  usage: aiResponse.usage,
  status: "generated",
  approval_status: "pending"
};

// Helper function to extract hashtags
function extractHashtags(text) {
  const hashtagRegex = /#\w+/g;
  return text.match(hashtagRegex) || [];
}

return [{
  json: formattedContent
}];
```

### Node 5: Google Docs Create
**Purpose:** Store generated content in Google Docs for review

**Configuration:**
- **Node Type:** Google Docs
- **Operation:** Create Document
- **Authentication:** Google OAuth2 Credential
- **Document Title:** `BILAN Social Content - {{ $json.theme }} - {{ $json.content_id }}`

**Document Content Template:**
```
# BILAN Social Media Content - {{ $json.theme }}

**Generated:** {{ $json.generated_at }}
**Content ID:** {{ $json.content_id }}
**Category:** {{ $json.category }}
**Focus:** {{ $json.focus }}
**Keywords:** {{ $json.keywords.join(', ') }}
**Status:** {{ $json.status }}
**Approval:** {{ $json.approval_status }}

---

## Twitter/X Post ({{ $json.posts.twitter.character_count }} chars)
{{ $json.posts.twitter.content }}

**Hashtags:** {{ $json.posts.twitter.hashtags.join(', ') }}

---

## Instagram Post ({{ $json.posts.instagram.character_count }} chars)
{{ $json.posts.instagram.content }}

**Hashtags:** {{ $json.posts.instagram.hashtags.join(', ') }}

---

## LinkedIn Post ({{ $json.posts.linkedin.character_count }} chars)
{{ $json.posts.linkedin.content }}

**Hashtags:** {{ $json.posts.linkedin.hashtags.join(', ') }}

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
- [ ] Competitor references avoided

**Approved for Posting:** _____
**Reviewed By:** _____
**Date:** _____
```

## Phase 4: Error Handling & Monitoring

### Node 6: Error Handler
**Purpose:** Catch and handle API errors gracefully

**Configuration:**
- **Node Type:** Error Trigger
- **Execute Once Per Workflow:** Yes
- **Continue On Fail:** Yes

**Error Processing Function:**
```javascript
const error = $input.first().json;
const workflowData = $input.all()[1]?.json || {};

// Log error details
console.error('BILAN Content Generator Error:', {
  timestamp: new Date().toISOString(),
  error: error.message,
  workflow_id: workflowData.content_id || 'unknown',
  theme: workflowData.theme || 'unknown'
});

// Determine error type
let errorType = 'unknown';
if (error.message.includes('429')) {
  errorType = 'rate_limit';
} else if (error.message.includes('401')) {
  errorType = 'authentication';
} else if (error.message.includes('500')) {
  errorType = 'server_error';
} else if (error.message.includes('timeout')) {
  errorType = 'timeout';
}

// Create error report
const errorReport = {
  error_id: `error_${Date.now()}`,
  timestamp: new Date().toISOString(),
  error_type: errorType,
  error_message: error.message,
  workflow_context: workflowData,
  retry_recommended: ['rate_limit', 'timeout', 'server_error'].includes(errorType),
  resolution_steps: getResolutionSteps(errorType)
};

function getResolutionSteps(type) {
  const steps = {
    rate_limit: [
      'Wait 60 seconds before retry',
      'Check API usage limits',
      'Consider reducing request frequency'
    ],
    authentication: [
      'Verify API key is valid',
      'Check credential configuration',
      'Ensure proper header format'
    ],
    server_error: [
      'Check Claude API status',
      'Retry after 30 seconds',
      'Monitor for ongoing issues'
    ],
    timeout: [
      'Increase timeout settings',
      'Check network connectivity',
      'Reduce prompt complexity'
    ]
  };
  return steps[type] || ['Contact support', 'Check logs', 'Verify configuration'];
}

return [{
  json: errorReport
}];
```

## Testing & Deployment

### Test Workflow Steps:
1. **Manual Trigger:** Test with "Execute Workflow" button
2. **Schedule Test:** Set to 5-minute intervals for validation
3. **Error Scenarios:** Test with invalid API keys, network issues
4. **Content Quality:** Review generated posts for brand alignment
5. **End-to-End:** Verify Google Docs creation and formatting

### Production Deployment:
1. **Update Schedule:** Change to daily/weekly production schedule
2. **Add Monitoring:** Set up alerts for workflow failures
3. **Content Review:** Establish manual approval process
4. **Performance Tracking:** Monitor token usage and costs
5. **Backup Plans:** Create fallback content for API failures

## Next Steps

Once core workflow is tested:
1. **Add social media posting nodes** (Twitter API, Instagram Basic Display, LinkedIn API)
2. **Implement content calendar management**
3. **Create analytics tracking for post performance**
4. **Build A/B testing capabilities for content variations**
5. **Add multi-language support for Spanish content**

---

*Status: Ready for n8n implementation and testing*