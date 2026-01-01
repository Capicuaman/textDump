# Content Formatter Function - Parse Claude API Response

## Add This Function Node After Claude API

Copy this code into a new Function node named "Content Formatter":

```javascript
// Parse Claude API response and combine with theme data
const aiResponse = $input.first().json;
const themeData = $input.all()[1].json;

// Extract content from Claude response
let contentPosts;
try {
  const contentText = aiResponse.content[0].text;
  contentPosts = JSON.parse(contentText);
} catch (error) {
  // Fallback content if JSON parsing fails
  contentPosts = {
    twitter: "Electrolytes power your performance! ⚡ BILAN provides pure, science-backed hydration. #Electrolytes #BILAN #PureHydration",
    instagram: "Electrolytes are essential for peak performance! 💪 BILAN delivers pure electrolytes for optimal hydration. No sugar, no additives. #BILAN #PureHydration #Performance",
    linkedin: "Professional athletes understand that optimal electrolyte balance is crucial for peak performance. BILAN's scientifically formulated electrolytes provide pure hydration without sugars and additives. #PerformanceNutrition #CorporateWellness #ElectrolyteScience"
  };
}

// Helper function to extract hashtags
function extractHashtags(text) {
  const hashtagRegex = /#\w+/g;
  return text.match(hashtagRegex) || [];
}

// Format for storage and review
const formattedContent = {
  // Content identification
  content_id: themeData.content_id,
  generated_at: new Date().toISOString(),
  
  // Theme information
  theme: themeData.theme,
  category: themeData.category,
  focus: themeData.focus,
  keywords: themeData.keywords,
  content_angle: themeData.content_angle,
  call_to_action: themeData.call_to_action,
  
  // Generated posts
  posts: {
    twitter: {
      content: contentPosts.twitter || "",
      character_count: (contentPosts.twitter || "").length,
      hashtags: extractHashtags(contentPosts.twitter || ""),
      platform: "Twitter/X",
      within_limit: (contentPosts.twitter || "").length <= 280
    },
    instagram: {
      content: contentPosts.instagram || "",
      character_count: (contentPosts.instagram || "").length,
      hashtags: extractHashtags(contentPosts.instagram || ""),
      platform: "Instagram",
      within_limit: (contentPosts.instagram || "").length >= 150 && (contentPosts.instagram || "").length <= 200
    },
    linkedin: {
      content: contentPosts.linkedin || "",
      character_count: (contentPosts.linkedin || "").length,
      hashtags: extractHashtags(contentPosts.linkedin || ""),
      platform: "LinkedIn",
      within_limit: (contentPosts.linkedin || "").length >= 200 && (contentPosts.linkedin || "").length <= 300
    }
  },
  
  // Quality metrics
  quality_metrics: {
    total_hashtags: extractHashtags(contentPosts.twitter || "").length + extractHashtags(contentPosts.instagram || "").length + extractHashtags(contentPosts.linkedin || "").length,
    platforms_within_limits: [
      (contentPosts.twitter || "").length <= 280,
      (contentPosts.instagram || "").length >= 150 && (contentPosts.instagram || "").length <= 200,
      (contentPosts.linkedin || "").length >= 200 && (contentPosts.linkedin || "").length <= 300
    ].filter(Boolean).length,
    keyword_usage: {
      used: themeData.keywords.filter(keyword => 
        (contentPosts.twitter || "").toLowerCase().includes(keyword.toLowerCase()) ||
        (contentPosts.instagram || "").toLowerCase().includes(keyword.toLowerCase()) ||
        (contentPosts.linkedin || "").toLowerCase().includes(keyword.toLowerCase())
      ),
      total: themeData.keywords.length
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

## Google Docs Node Configuration

### Node Setup:
- **Node Type:** Google Docs
- **Operation:** Create Document
- **Authentication:** Google OAuth2 Credential
- **Document Title:** `BILAN Social Content - {{ $json.theme }} - {{ $json.content_id }}`

### Document Content Template:
```
# BILAN Social Media Content - {{ $json.theme }}

## Content Information
**Generated:** {{ $json.generated_at }}
**Content ID:** {{ $json.content_id }}
**Category:** {{ $json.category }}
**Focus:** {{ $json.focus }}
**Content Angle:** {{ $json.content_angle }}
**Keywords:** {{ $json.keywords.join(', ') }}
**Call to Action:** {{ $json.call_to_action }}

**Status:** {{ $json.status }}
**Approval Status:** {{ $json.approval_status }}
**Review Priority:** {{ $json.review_priority }}

---

## Platform Posts

### Twitter/X Post ({{ $json.posts.twitter.character_count }} chars)
{{ $json.posts.twitter.content }}

**Within Limit:** {{ $json.posts.twitter.within_limit ? '✅ Yes' : '❌ No' }}
**Hashtags:** {{ $json.posts.twitter.hashtags.join(', ') }}

---

### Instagram Post ({{ $json.posts.instagram.character_count }} chars)
{{ $json.posts.instagram.content }}

**Within Limit:** {{ $json.posts.instagram.within_limit ? '✅ Yes' : '❌ No' }}
**Hashtags:** {{ $json.posts.instagram.hashtags.join(', ') }}

---

### LinkedIn Post ({{ $json.posts.linkedin.character_count }} chars)
{{ $json.posts.linkedin.content }}

**Within Limit:** {{ $json.posts.linkedin.within_limit ? '✅ Yes' : '❌ No' }}
**Hashtags:** {{ $json.posts.linkedin.hashtags.join(', ') }}

---

## Quality Metrics

### Character Limits
- **Twitter:** {{ $json.posts.twitter.within_limit ? '✅' : '❌' }} ({{ $json.posts.twitter.character_count }}/280)
- **Instagram:** {{ $json.posts.instagram.within_limit ? '✅' : '❌' }} ({{ $json.posts.instagram.character_count }}/150-200)
- **LinkedIn:** {{ $json.posts.linkedin.within_limit ? '✅' : '❌' }} ({{ $json.posts.linkedin.character_count }}/200-300)

### Hashtag Strategy
- **Total Hashtags:** {{ $json.quality_metrics.total_hashtags }}
- **Distribution:** {{ Math.round($json.quality_metrics.total_hashtags / 3) }} average per platform

### Keyword Usage
- **Keywords Used:** {{ $json.quality_metrics.keyword_usage.used.length }}/{{ $json.quality_metrics.keyword_usage.total }}
- **Used Keywords:** {{ $json.quality_metrics.keyword_usage.used.join(', ') }}
- **Missed Keywords:** {{ $json.keywords.filter(k => !$json.quality_metrics.keyword_usage.used.includes(k)).join(', ') }}

---

## API Usage Statistics
- **Input Tokens:** {{ $json.usage.input_tokens }}
- **Output Tokens:** {{ $json.usage.output_tokens }}
- **Total Tokens:** {{ $json.usage.input_tokens + $json.usage.output_tokens }}
- **Estimated Cost:** ${{ (($json.usage.input_tokens + $json.usage.output_tokens) * 0.003).toFixed(4) }}

---

## Content Approval Checklist

### Brand Voice Alignment
- [ ] Authoritative yet accessible tone
- [ ] Scientific but empowering language
- [ ] Educational and evidence-based
- [ ] Focus on benefits, not just features
- [ ] Empowering language used

### Content Quality
- [ ] Scientific accuracy verified
- [ ] Claims are supported
- [ ] No competitor mentions
- [ ] Call-to-action clear
- [ ] Hashtag relevance checked

### Technical Requirements
- [ ] Character counts appropriate
- [ ] Hashtags properly formatted
- [ ] Platform-specific formatting correct
- [ ] No spelling/grammar errors

### Approval Decision
**Ready for Posting:** _____
**Approved By:** _____
**Date:** _____
**Notes:** _________________________________

---

## Posting Instructions
1. Copy content from platform-specific sections
2. Verify hashtags are relevant and trending
3. Check platform-specific formatting
4. Schedule posts during optimal engagement times
5. Monitor engagement and respond to comments

**Next Review Date:** {{ new Date(Date.now() + 7 * 24 * 60 * 60 * 1000).toISOString().split('T')[0] }}
```

## Complete Workflow Flow:
```
Schedule Trigger → Theme Selector → Claude API → Content Formatter → Google Docs
```

## Testing the Complete Workflow:

1. **Manual Test:** Execute workflow manually
2. **Verify Theme Selection:** Check random theme generation
3. **Check Claude Response:** Confirm content quality
4. **Validate Formatting:** Ensure all data fields populated
5. **Test Google Docs:** Verify document creation and content
6. **Review Quality Metrics:** Check character counts, hashtags, keywords

## Expected Google Docs Output:
- Professional document with theme-based content
- Quality metrics and character count validation
- Approval checklist for content review
- Usage statistics and cost tracking
- Clear posting instructions

Your workflow is now complete! Ready to test it end-to-end?