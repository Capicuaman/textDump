# Claude API Credentials Setup Guide

## Overview
Setting up Claude API credentials for n8n workflow automation.

## Prerequisites
- Claude API key from https://console.anthropic.com/account/keys
- n8n environment access
- Basic understanding of n8n credential management

## Step 1: Obtain API Key

1. Visit https://console.anthropic.com/account/keys
2. Click "Create Key"
3. Choose key type (Standard or Custom)
4. Copy and securely store the key
5. Note key ID for reference

## Step 2: Configure in n8n

### Method 1: Environment Variables (Recommended)
1. In n8n settings, go to **Credentials**
2. Add new credential
3. **Name:** `Claude API`
4. **Type:** `Header Auth`
5. **Header Name:** `x-api-key`
6. **Header Value:** `sk-ant-{your-api-key}`

### Method 2: Direct Header Configuration
1. In HTTP Request node settings
2. **Authentication:** `Header Auth`
3. **Headers:**
   ```
   x-api-key: sk-ant-{your-api-key}
   Content-Type: application/json
   ```

### Method 3: n8n Credential Store
1. Go to **Credentials**
2. Add new credential
3. **Name:** `Claude API`
4. **Type:** `Header Auth`
5. **Header Name:** `x-api-key`
6. **Header Value:** `sk-ant-{your-api-key}`

## Step 3: Test API Connectivity

### Simple Test Workflow
1. **HTTP Request** node
2. **Method:** POST
3. **URL:** `https://api.anthropic.com/v1/messages`
4. **Headers:** Configure as above
5. **Body:**
   ```json
   {
     "model": "claude-sonnet-4-5",
     "max_tokens": 100,
     "messages": [
       {"role": "user", "content": "Hello from BILAN!"}
     ]
   }
   ```
6. **Execute** and verify response

### Expected Response
```json
{
  "id": "msg_xxx",
  "type": "message",
  "role": "assistant",
  "content": [
    {
      "type": "text",
      "text": "Hello from BILAN! I'm here to help with your electrolyte needs."
    }
  ],
  "usage": {
    "input_tokens": 15,
    "output_tokens": 25
  }
}
```

## Step 4: Advanced Configuration

### Rate Limiting Considerations
- **Default (Tier 1):** 50 requests/minute
- **Recommended:** Implement retry logic with exponential backoff
- **Monitoring:** Track usage in Claude console dashboard

### Error Handling Setup
1. Add **Error Trigger** node after HTTP Request
2. Configure **Error Routing** for different error types
3. Set **Retry Logic** for rate limits (429, 500, 529)
4. Add **Fallback Actions** for API failures

### Production Best Practices
- Use versioned model IDs for stability
- Implement request logging for debugging
- Set reasonable max_tokens limits
- Cache frequently used prompts
- Monitor usage to optimize costs

## Step 5: Integration with BILAN Content

### Brand Voice Integration
Once connected, your Claude API can:
- Reference brand pillars from `social_media_blueprint_spanish.json`
- Pull content themes from `socialMedia_Object.json`
- Access FAQ data from `RAG/faq.json`
- Generate content consistent with your marketing materials

### Content Generation Prompt Template
```json
{
  "system": "You are a social media content creator for BILAN electrolyte brand. Always maintain the brand voice: authoritative, scientific, but accessible and empowering. Focus on education and pure hydration benefits.",
  "brand_pillars": [
    "Euhidratación y Equilibrio",
    "La Batería Humana", 
    "Pureza y Calidad Científica",
    "La Alternativa Pura"
  ],
  "content_themes": [
    "What Are Electrolytes?",
    "The Role of Electrolytes in Hydration",
    "Electrolytes for Performance and Recovery"
  ]
}
```

## Troubleshooting

### Common Issues
- **401 Authentication Error:** Check API key format and permissions
- **429 Rate Limit:** Implement retry with exponential backoff
- **500 Server Error:** Check network connectivity and API status
- **Invalid Request:** Verify JSON structure and headers

### Debugging Steps
1. Test with simple "Hello" message first
2. Verify API key format (should start with `sk-ant-`)
3. Check n8n credential configuration
4. Review response headers for rate limit information
5. Test with your actual BILAN content prompts

## Next Steps

Once credentials are verified:
1. **Build theme selector function** using your 20+ content themes
2. **Configure AI content generation** with brand-aligned prompts
3. **Set up Google Docs storage** for content review
4. **Test complete workflow** end-to-end
5. **Add error handling** for production reliability

## Security Notes

- Never commit API keys to version control
- Use environment variables in production
- Rotate API keys regularly
- Monitor usage for unusual patterns
- Implement IP restrictions if needed

---
*Status: Ready for n8n integration*