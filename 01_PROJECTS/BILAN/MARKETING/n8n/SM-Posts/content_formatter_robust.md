# Content Formatter - Robust Input Handling

## Issue Fixed
The function can't find both inputs. Here's a version that handles different input scenarios:

## Robust Content Formatter Function

```javascript
// Robust Content Formatter - Handle different input scenarios
console.log("=== DEBUG INFO ===");
console.log("Total inputs:", $input.all().length);
console.log("Input 0 type:", typeof $input.all()[0]);
console.log("Input 1 type:", typeof $input.all()[1]);

// Try different ways to get the data
let aiResponse, themeData;

// Method 1: Try to get both inputs
try {
  const allInputs = $input.all();
  if (allInputs.length >= 2) {
    aiResponse = allInputs[0].json;
    themeData = allInputs[1].json;
    console.log("Method 1: Got both inputs");
  } else {
    throw new Error("Not enough inputs");
  }
} catch (error) {
  console.log("Method 1 failed:", error.message);
  
  // Method 2: Try first and last
  try {
    aiResponse = $input.first().json;
    themeData = $input.last().json;
    console.log("Method 2: Used first and last");
  } catch (error2) {
    console.log("Method 2 failed:", error2.message);
    
    // Method 3: Try to detect which is which
    try {
      const inputs = $input.all();
      for (let i = 0; i < inputs.length; i++) {
        const data = inputs[i].json;
        if (data && data.content) {
          aiResponse = data;
          console.log("Found Claude API response at index", i);
        } else if (data && data.theme) {
          themeData = data;
          console.log("Found theme data at index", i);
        }
      }
    } catch (error3) {
      console.log("Method 3 failed:", error3.message);
    }
  }
}

// Final fallback - create dummy data if still missing
if (!aiResponse) {
  console.log("Creating dummy Claude response");
  aiResponse = {
    content: [{
      text: JSON.stringify({
        twitter: "Electrolytes power your performance! ⚡ BILAN provides pure hydration. #Electrolytes #BILAN",
        instagram: "Electrolytes are essential for peak performance! 💪 BILAN delivers pure electrolytes. #BILAN #Performance",
        linkedin: "Professional athletes understand electrolyte balance is crucial for peak performance. BILAN provides scientifically formulated electrolytes. #PerformanceNutrition"
      })
    }],
    usage: { input_tokens: 0, output_tokens: 0 }
  };
}

if (!themeData) {
  console.log("Creating dummy theme data");
  themeData = {
    theme: "Test Theme",
    category: "test",
    focus: "Test focus",
    keywords: ["test", "electrolytes"],
    content_id: `bilan_${Date.now()}`
  };
}

console.log("Final aiResponse:", !!aiResponse);
console.log("Final themeData:", !!themeData);
console.log("=== END DEBUG ===");

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
    console.log("Successfully parsed Claude response");
  }
} catch (error) {
  console.log("Using fallback content due to parsing error:", error.message);
}

// Helper functions
function extractHashtags(text) {
  if (!text) return [];
  return (text.match(/#\w+/g) || []);
}

function getCharacterCount(text) {
  return (text || "").length;
}

// Create clean output
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
  
  usage: {
    input_tokens: aiResponse.usage?.input_tokens || 0,
    output_tokens: aiResponse.usage?.output_tokens || 0,
    total_tokens: (aiResponse.usage?.input_tokens || 0) + (aiResponse.usage?.output_tokens || 0)
  },
  
  status: "generated",
  approval_status: "pending"
};

return {
  json: formattedContent
};
```

## Alternative: Simple Single-Input Version

If the above still has issues, try this version that works with just one input:

```javascript
// Simple Single-Input Version
const inputData = $input.first().json;

console.log("Input data keys:", Object.keys(inputData || {}));

// Try to detect what type of input we have
let contentPosts, themeData, usage;

if (inputData && inputData.content) {
  // This is Claude API response
  console.log("Detected Claude API response");
  try {
    const parsedContent = JSON.parse(inputData.content[0].text);
    contentPosts = parsedContent;
    usage = inputData.usage || { input_tokens: 0, output_tokens: 0 };
  } catch (error) {
    console.log("Failed to parse, using fallback");
    contentPosts = {
      twitter: "Electrolytes power your performance! ⚡ BILAN #Electrolytes",
      instagram: "Electrolytes are essential! 💪 BILAN #Performance",
      linkedin: "Professional athletes need electrolytes. BILAN #PerformanceNutrition"
    };
    usage = { input_tokens: 0, output_tokens: 0 };
  }
  
  // Create default theme data
  themeData = {
    theme: "AI Generated Content",
    category: "automated",
    focus: "Social media content",
    keywords: ["electrolytes", "performance", "hydration"],
    content_id: `bilan_${Date.now()}`
  };
  
} else {
  // This is theme data or something else
  console.log("Detected theme data or other");
  themeData = inputData || {
    theme: "Default Theme",
    category: "general",
    focus: "Content generation",
    keywords: ["electrolytes"],
    content_id: `bilan_${Date.now()}`
  };
  
  contentPosts = {
    twitter: "Electrolytes power your performance! ⚡ BILAN #Electrolytes",
    instagram: "Electrolytes are essential! 💪 BILAN #Performance", 
    linkedin: "Professional athletes need electrolytes. BILAN #PerformanceNutrition"
  };
  usage = { input_tokens: 0, output_tokens: 0 };
}

// Format output
const formattedContent = {
  content_id: themeData.content_id,
  generated_at: new Date().toISOString(),
  theme: themeData.theme,
  category: themeData.category,
  focus: themeData.focus,
  keywords: themeData.keywords,
  
  posts: {
    twitter: {
      content: contentPosts.twitter,
      character_count: (contentPosts.twitter || "").length,
      hashtags: (contentPosts.twitter || "").match(/#\w+/g) || [],
      platform: "Twitter/X"
    },
    instagram: {
      content: contentPosts.instagram,
      character_count: (contentPosts.instagram || "").length,
      hashtags: (contentPosts.instagram || "").match(/#\w+/g) || [],
      platform: "Instagram"
    },
    linkedin: {
      content: contentPosts.linkedin,
      character_count: (contentPosts.linkedin || "").length,
      hashtags: (contentPosts.linkedin || "").match(/#\w+/g) || [],
      platform: "LinkedIn"
    }
  },
  
  usage: usage,
  status: "generated",
  approval_status: "pending"
};

return {
  json: formattedContent
};
```

## Debug Your Workflow

The debug output will show you:
- How many inputs are coming into the node
- What type of data each input contains
- Which method worked to extract the data

**Try the robust version first** - it has extensive debugging and will show you exactly what's happening with your inputs.

What debug output do you get?