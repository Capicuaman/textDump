# AI Chatbot with Supabase Integration

## Overview
Intelligent chatbot workflow that leverages OpenAI GPT-4 for natural language processing and Supabase for persistent storage, user management, and conversation history.

## Features
- **AI-Powered Conversations**: GPT-4 for intelligent responses
- **Persistent Chat History**: Supabase database storage
- **User Preferences**: Customizable chat experience
- **Session Management**: Track conversation sessions
- **Context Awareness**: Maintains conversation context

## Database Schema (Supabase)

### chat_history Table
```sql
CREATE TABLE chat_history (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id VARCHAR NOT NULL,
  session_id VARCHAR NOT NULL,
  message TEXT NOT NULL,
  response TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_chat_history_user_id ON chat_history(user_id);
CREATE INDEX idx_chat_history_session_id ON chat_history(session_id);
```

### user_preferences Table
```sql
CREATE TABLE user_preferences (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id VARCHAR UNIQUE NOT NULL,
  preferences JSONB DEFAULT '{"tone": "friendly", "context": "general"}',
  context TEXT DEFAULT 'general conversation',
  last_active TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  message_count INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_user_preferences_user_id ON user_preferences(user_id);
```

## Workflow Steps

### 1. Chat Message Trigger (Webhook)
- **Endpoint**: `/chatbot`
- **Method**: POST
- **Parameters**:
  - `message`: User message
  - `userId`: Unique user identifier
  - `sessionId`: Conversation session ID

### 2. Data Extraction
Extracts and validates chat parameters with fallback values for anonymous users.

### 3. Chat History Retrieval
- Fetches last 10 messages from current session
- Maintains conversation context
- Ordered by most recent

### 4. User Preferences Loading
- Loads user-specific settings
- Includes tone preferences and context
- Tracks user activity metrics

### 5. Context Building
Combines chat history, user preferences, and system prompt for AI context.

### 6. AI Response Generation
- **Model**: OpenAI GPT-4
- **Temperature**: 0.7 (balanced creativity)
- **Max Tokens**: 1000
- **Context**: System prompt + chat history

### 7. Chat Storage
Saves both user message and AI response to chat history table.

### 8. User Activity Update
Updates last active timestamp and message count.

### 9. Response Formatting
Structures response with metadata for client applications.

## Usage Examples

### Basic Chat
```bash
curl -X POST http://localhost:5678/webhook/chatbot \
  -H "Content-Type: application/json" \
  -d '{
    "message": "Hello, how can you help me today?",
    "userId": "user123",
    "sessionId": "session456"
  }'
```

### Anonymous Chat
```bash
curl -X POST http://localhost:5678/webhook/chatbot \
  -H "Content-Type: application/json" \
  -d '{
    "message": "Tell me about AI automation"
  }'
```

## Required Credentials

### OpenAI
- **Type**: API Key
- **Node**: OpenAI
- **Setup**: Settings > Credentials > Add OpenAI API credential

### Supabase
- **Type**: API Key
- **Node**: Supabase
- **Setup**: 
  - Supabase Project > Settings > API
  - Copy URL and service role key
  - Enable Row Level Security (RLS)

## Supabase Setup

### 1. Create Project
1. Go to [supabase.com](https://supabase.com)
2. Create new project
3. Choose region and database settings

### 2. Create Tables
Execute the SQL schema provided above in Supabase SQL Editor.

### 3. Configure RLS (Row Level Security)
```sql
-- Enable RLS on tables
ALTER TABLE chat_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_preferences ENABLE ROW LEVEL SECURITY;

-- Create policies
CREATE POLICY "Users can view their own chat history" ON chat_history
  FOR SELECT USING (auth.uid()::text = user_id);

CREATE POLICY "Users can insert their own chat messages" ON chat_history
  FOR INSERT WITH CHECK (auth.uid()::text = user_id);

CREATE POLICY "Users can view their own preferences" ON user_preferences
  FOR SELECT USING (auth.uid()::text = user_id);

CREATE POLICY "Users can update their own preferences" ON user_preferences
  FOR UPDATE USING (auth.uid()::text = user_id);
```

### 4. API Configuration
- Copy Project URL
- Copy service_role key (for server-side operations)
- Add to n8n Supabase credentials

## Advanced Features

### Custom User Preferences
```json
{
  "tone": "professional",
  "context": "business consulting",
  "language": "en",
  "responseLength": "detailed",
  "topics": ["AI", "automation", "business"]
}
```

### Context-Aware Responses
The system maintains conversation context by:
- Loading recent chat history
- Including user preferences in system prompt
- Tracking session continuity
- Adapting responses based on previous interactions

### Multi-Session Support
- Each conversation gets unique session ID
- Users can have multiple concurrent sessions
- Session history is preserved and searchable
- Cross-session context can be maintained

## Integration Examples

### Web Frontend
```javascript
async function sendMessage(message, userId, sessionId) {
  const response = await fetch('/webhook/chatbot', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ message, userId, sessionId })
  });
  return await response.json();
}
```

### Mobile App Integration
```swift
func sendMessage(message: String, userId: String, sessionId: String) async -> ChatResponse {
    let url = URL(string: "http://localhost:5678/webhook/chatbot")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let payload = ["message": message, "userId": userId, "sessionId": sessionId]
    request.httpBody = try? JSONSerialization.data(withJSONObject: payload)
    
    let (data, _) = try! await URLSession.shared.data(for: request)
    return try! JSONDecoder().decode(ChatResponse.self, from: data)
}
```

## Performance Optimization

### Database Indexing
- Indexed on user_id and session_id
- Optimized for fast lookups
- Supports concurrent users

### Caching Strategy
- User preferences cached in memory
- Chat history limited to recent messages
- Session context maintained efficiently

### Scaling Considerations
- Supabase handles connection pooling
- OpenAI API rate limits managed
- Horizontal scaling with multiple n8n instances

## Security Features

### Data Protection
- RLS policies enforce user isolation
- API keys stored securely in n8n
- No sensitive data in logs

### Access Control
- User-based data segregation
- Session-based access control
- Anonymous user support with limitations

### Privacy Compliance
- User data deletion capabilities
- Chat history retention policies
- GDPR-friendly design

## Monitoring & Analytics

### User Metrics
- Message count per user
- Session duration tracking
- Popular conversation topics

### Performance Metrics
- Response time monitoring
- Database query optimization
- API usage tracking

### Error Handling
- Failed request logging
- Database connection errors
- OpenAI API rate limiting

## Future Enhancements
- [ ] Multi-language support
- [ ] File/image sharing
- [ ] Voice integration
- [ ] Sentiment analysis
- [ ] Custom AI model fine-tuning
- [ ] Advanced analytics dashboard
- [ ] Integration with other communication channels