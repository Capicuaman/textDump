# Content Formatter Function - Fixed Version

## Issue Fixed
The error occurs because the function is trying to read from undefined input. Here's the corrected version that handles n8n input properly:

## Corrected Content Formatter Function

```javascript
// Parse Claude API response and combine with theme data
// Handle n8n input structure properly

// Get the inputs safely
const inputs = $input.all();
if (!inputs || inputs.length < 2) {
  throw new Error("Insufficient input data. Need both Claude API response and theme data.");
}

const aiResponse = inputs[0].json;
const themeData = inputs[1].json;

// Validate input data
if (!aiResponse || !aiResponse.content) {
  throw new Error("Invalid Claude API response format");
}

if (!themeData || !themeData.theme) {
  throw new Error("Invalid theme data format");
}

// Extract content from Claude response
let contentPosts;
try {
  const contentText = aiResponse.content[0].text;
  contentPosts = JSON.parse(contentText);
} catch (error) {
  console.error("Failed to parse Claude response:", error.message);
  // Fallback content if JSON parsing fails
  contentPosts = {
    twitter: "Electrolytes power your performance! ⚡ BILAN provides pure, science-backed hydration. #Electrolytes #BILAN #PureHydration",
    instagram: "Electrolytes are essential for peak performance! 💪 BILAN delivers pure electrolytes for optimal hydration. No sugar, no additives. #BILAN #PureHydration #Performance",
    linkedin: "Professional athletes understand that optimal electrolyte balance is crucial for peak performance. BILAN's scientifically formulated electrolytes provide pure hydration without sugars and additives. #PerformanceNutrition #CorporateWellness #ElectrolyteScience"
  };
}

// Helper function to extract hashtags
function extractHashtags(text) {
  if (!text || typeof text !== 'string') return [];
  const hashtagRegex = /#\w+/g;
  return text.match(hashtagRegex) || [];
}

// Helper function to check character limits
function checkCharacterLimit(content, min, max) {
  if (!content || typeof content !== 'string') return false;
  const length = content.length;
  return min <= length && length <= max;
}

// Format for storage and review
const formattedContent = {
  // Content identification
  content_id: themeData.content_id || `bilan_${Date.now()}`,
  generated_at: new Date().toISOString(),
  
  // Theme information
  theme: themeData.theme || "Unknown Theme",
  category: themeData.category || "general",
  focus: themeData.focus || "Content generation",
  keywords: Array.isArray(themeData.keywords) ? themeData.keywords : [],
  content_angle: themeData.content_angle || "General content",
  call_to_action: themeData.call_to_action || "Learn more about BILAN",
  
  // Generated posts
  posts: {
    twitter: {
      content: contentPosts.twitter || "",
      character_count: (contentPosts.twitter || "").length,
      hashtags: extractHashtags(contentPosts.twitter || ""),
      platform: "Twitter/X",
      within_limit: checkCharacterLimit(contentPosts.twitter || "", 0, 280)
    },
    instagram: {
      content: contentPosts.instagram || "",
      character_count: (contentPosts.instagram || "").length,
      hashtags: extractHashtags(contentPosts.instagram || ""),
      platform: "Instagram",
      within_limit: checkCharacterLimit(contentPosts.instagram || "", 150, 200)
    },
    linkedin: {
      content: contentPosts.linkedin || "",
      character_count: (contentPosts.linkedin || "").length,
      hashtags: extractHashtags(contentPosts.linkedin || ""),
      platform: "LinkedIn",
      within_limit: checkCharacterLimit(contentPosts.linkedin || "", 200, 300)
    }
  },
  
  // Quality metrics
  quality_metrics: {
    total_hashtags: extractHashtags(contentPosts.twitter || "").length + 
                   extractHashtags(contentPosts.instagram || "").length + 
                   extractHashtags(contentPosts.linkedin || "").length,
    platforms_within_limits: [
      checkCharacterLimit(contentPosts.twitter || "", 0, 280),
      checkCharacterLimit(contentPosts.instagram || "", 150, 200),
      checkCharacterLimit(contentPosts.linkedin || "", 200, 300)
    ].filter(Boolean).length,
    keyword_usage: {
      used: (Array.isArray(themeData.keywords) ? themeData.keywords : []).filter(keyword => {
        const keywordLower = keyword.toLowerCase();
        return (contentPosts.twitter || "").toLowerCase().includes(keywordLower) ||
               (contentPosts.instagram || "").toLowerCase().includes(keywordLower) ||
               (contentPosts.linkedin || "").toLowerCase().includes(keywordLower);
      }),
      total: (Array.isArray(themeData.keywords) ? themeData.keywords : []).length
    }
  },
  
  // Usage statistics
  usage: aiResponse.usage || { input_tokens: 0, output_tokens: 0 },
  
  // Status tracking
  status: "generated",
  approval_status: "pending",
  review_priority: "normal"
};

return {
  json: formattedContent
};
```

## Alternative: Simple Version (Less Error Prone)

If you're still getting errors, try this simpler version:

```javascript
// Simple Content Formatter - Less error prone
const aiResponse = $input.first().json;
const themeData = $input.last().json;

// Basic content extraction
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

// Basic hashtag extraction
function extractHashtags(text) {
  if (!text) return [];
  return (text.match(/#\w+/g) || []);
}

// Format output
const formattedContent = {
  content_id: themeData.content_id || `bilan_${Date.now()}`,
  generated_at: new Date().toISOString(),
  theme: themeData.theme || "Unknown Theme",
  category: themeData.category || "general",
  focus: themeData.focus || "Content generation",
  keywords: Array.isArray(themeData.keywords) ? themeData.keywords : [],
  posts: {
    twitter: {
      content: contentPosts.twitter,
      character_count: (contentPosts.twitter || "").length,
      hashtags: extractHashtags(contentPosts.twitter),
      platform: "Twitter/X"
    },
    instagram: {
      content: contentPosts.instagram,
      character_count: (contentPosts.instagram || "").length,
      hashtags: extractHashtags(contentPosts.instagram),
      platform: "Instagram"
    },
    linkedin: {
      content: contentPosts.linkedin,
      character_count: (contentPosts.linkedin || "").length,
      hashtags: extractHashtags(contentPosts.linkedin),
      platform: "LinkedIn"
    }
  },
  usage: aiResponse.usage || { input_tokens: 0, output_tokens: 0 },
  status: "generated",
  approval_status: "pending"
};

return {
  json: formattedContent
};
```

## Debugging Steps

If you're still getting errors, add this debug function first:

```javascript
// Debug Function - Check what inputs you're getting
console.log("Number of inputs:", $input.all().length);
console.log("First input:", JSON.stringify($input.first().json, null, 2));
console.log("Last input:", JSON.stringify($input.last().json, null, 2));

// Just return the inputs to see what you're getting
return {
  json: {
    debug: true,
    input_count: $input.all().length,
    first_input: $input.first().json,
    last_input: $input.last().json
  }
};
```

## Common Issues and Solutions

### Issue 1: Wrong Input Order
**Problem:** Theme selector and Claude API outputs in wrong order
**Solution:** Use `$input.first()` and `$input.last()` instead of index positions

### Issue 2: Missing Data
**Problem:** One of the nodes didn't output data
**Solution:** Add the debug function above to see what you're getting

### Issue 3: Claude API Error
**Problem:** Claude API returned an error instead of content
**Solution:** Check the Claude API response format

Try the **simple version** first - it's more robust and will help you identify any remaining issues.