# Content Formatter - Clean Output Version

## Issue Fixed
The output shows raw JSON structure. Here's a cleaner version that formats the output properly:

## Clean Content Formatter Function

```javascript
// Clean Content Formatter - Better output formatting
const aiResponse = $input.first().json;
const themeData = $input.last().json;

// Extract content from Claude response
let contentPosts = {
  twitter: "Electrolytes power your performance! ⚡ BILAN provides pure hydration. #Electrolytes #BILAN",
  instagram: "Electrolytes are essential for peak performance! 💪 BILAN delivers pure electrolytes. #BILAN #Performance",
  linkedin: "Professional athletes understand electrolyte balance is crucial for peak performance. BILAN provides scientifically formulated electrolytes. #PerformanceNutrition"
};

// Try to parse Claude response
try {
  if (aiResponse && aiResponse.content && aiResponse.content[0] && aiResponse.content[0].text) {
    const parsedContent = JSON.parse(aiResponse.content[0].text);
    if (parsedContent.twitter) contentPosts.twitter = parsedContent.twitter;
    if (parsedContent.instagram) contentPosts.instagram = parsedContent.instagram;
    if (parsedContent.linkedin) contentPosts.linkedin = parsedContent.linkedin;
  }
} catch (error) {
  console.log("Using fallback content due to parsing error");
}

// Helper functions
function extractHashtags(text) {
  if (!text) return [];
  return (text.match(/#\w+/g) || []);
}

function getCharacterCount(text) {
  return (text || "").length;
}

// Create clean, structured output
const formattedContent = {
  // Content identification
  content_id: themeData.content_id || `bilan_${Date.now()}`,
  generated_at: new Date().toISOString(),
  
  // Theme information
  theme: themeData.theme || "Unknown Theme",
  category: themeData.category || "general",
  focus: themeData.focus || "Content generation",
  keywords: Array.isArray(themeData.keywords) ? themeData.keywords : [],
  
  // Generated posts - clean structure
  posts: {
    twitter: {
      content: contentPosts.twitter,
      character_count: getCharacterCount(contentPosts.twitter),
      hashtags: extractHashtags(contentPosts.twitter),
      platform: "Twitter/X"
    },
    instagram: {
      content: contentPosts.instagram,
      character_count: getCharacterCount(contentPosts.instagram),
      hashtags: extractHashtags(contentPosts.instagram),
      platform: "Instagram"
    },
    linkedin: {
      content: contentPosts.linkedin,
      character_count: getCharacterCount(contentPosts.linkedin),
      hashtags: extractHashtags(contentPosts.linkedin),
      platform: "LinkedIn"
    }
  },
  
  // Usage statistics
  usage: {
    input_tokens: aiResponse.usage?.input_tokens || 0,
    output_tokens: aiResponse.usage?.output_tokens || 0,
    total_tokens: (aiResponse.usage?.input_tokens || 0) + (aiResponse.usage?.output_tokens || 0)
  },
  
  // Status
  status: "generated",
  approval_status: "pending"
};

return {
  json: formattedContent
};
```

## Test Your Output

After updating the function, test it again. You should see clean output like this:

```json
{
  "content_id": "bilan_1642234567890",
  "generated_at": "2025-01-15T09:00:00Z",
  "theme": "What Are Electrolytes?",
  "category": "educational",
  "focus": "Basic electrolyte education",
  "keywords": ["electrolytes", "hydration", "minerals", "body function"],
  "posts": {
    "twitter": {
      "content": "Electrolytes power your performance! ⚡ BILAN provides pure hydration. #Electrolytes #BILAN",
      "character_count": 89,
      "hashtags": ["#Electrolytes", "#BILAN"],
      "platform": "Twitter/X"
    },
    "instagram": {
      "content": "Electrolytes are essential for peak performance! 💪 BILAN delivers pure electrolytes. #BILAN #Performance",
      "character_count": 105,
      "hashtags": ["#BILAN", "#Performance"],
      "platform": "Instagram"
    },
    "linkedin": {
      "content": "Professional athletes understand electrolyte balance is crucial for peak performance. BILAN provides scientifically formulated electrolytes. #PerformanceNutrition",
      "character_count": 162,
      "hashtags": ["#PerformanceNutrition"],
      "platform": "LinkedIn"
    }
  },
  "usage": {
    "input_tokens": 284,
    "output_tokens": 347,
    "total_tokens": 631
  },
  "status": "generated",
  "approval_status": "pending"
}
```

## Next Step: Google Docs Integration

Once you have clean output, add the Google Docs node with this configuration:

### Google Docs Node Settings:
- **Operation:** Create Document
- **Document Title:** `BILAN Social Content - {{ $json.theme }} - {{ $json.content_id }}`
- **Content:** Use the template from the previous guide

### Key Template Variables:
- `{{ $json.theme }}` - Theme name
- `{{ $json.content_id }}` - Unique ID
- `{{ $json.posts.twitter.content }}` - Twitter post
- `{{ $json.posts.instagram.content }}` - Instagram post
- `{{ $json.posts.linkedin.content }}` - LinkedIn post
- `{{ $json.usage.total_tokens }}` - Token usage

Try the clean version first and let me know what output you get!