# Job Search and Application Workflow

## Overview
Comprehensive job search and application automation workflow that aggregates listings from multiple job boards, ranks them by relevance, and generates personalized cover letters using AI.

## Features
- **Multi-Platform Search**: Aggregates jobs from Adzuna, GitHub Jobs, and Indeed
- **Smart Ranking**: AI-powered job matching and scoring
- **Application Generation**: Automated cover letter creation
- **Search Analytics**: Tracks search history and application metrics
- **Supabase Integration**: Persistent storage for searches and applications

## Database Schema (Supabase)

### job_searches Table
```sql
CREATE TABLE job_searches (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id VARCHAR NOT NULL,
  keywords VARCHAR NOT NULL,
  location VARCHAR NOT NULL,
  job_type VARCHAR NOT NULL,
  results_count INTEGER NOT NULL,
  search_date TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_job_searches_user_id ON job_searches(user_id);
CREATE INDEX idx_job_searches_date ON job_searches(search_date);
```

### job_applications Table
```sql
CREATE TABLE job_applications (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id VARCHAR NOT NULL,
  job_id VARCHAR NOT NULL,
  job_title VARCHAR NOT NULL,
  company VARCHAR NOT NULL,
  resume_text TEXT NOT NULL,
  cover_letter TEXT NOT NULL,
  email VARCHAR NOT NULL,
  phone VARCHAR,
  status VARCHAR DEFAULT 'generated',
  application_date TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_job_applications_user_id ON job_applications(user_id);
CREATE INDEX idx_job_applications_status ON job_applications(status);
```

## Workflow Components

### 1. Job Search Pipeline

#### Search Trigger (Webhook)
- **Endpoint**: `/job-search`
- **Method**: POST
- **Parameters**:
  - `keywords`: Job search terms
  - `location`: Preferred location
  - `jobType`: full-time, part-time, contract
  - `experience`: entry-level, mid-level, senior
  - `salary`: Salary range (e.g., "80000-120000")
  - `userId`: User identifier

#### Multi-Platform Job Search
- **Adzuna API**: Comprehensive job listings
- **GitHub Jobs**: Tech-focused positions
- **Indeed API**: Major job board integration

#### AI-Powered Job Ranking
- **Match Scoring**: Calculates relevance based on:
  - Keyword matching in title/description (40 points)
  - Location compatibility (20 points)
  - Salary range alignment (20 points)
  - Posting recency (10 points)
  - Additional factors (10 points)
- **Deduplication**: Removes duplicate listings
- **Top Results**: Returns best 20 matches

#### Search Analytics
- Logs all searches to Supabase
- Tracks user search patterns
- Metrics for optimization

### 2. Application Pipeline

#### Application Trigger (Webhook)
- **Endpoint**: `/job-application`
- **Method**: POST
- **Parameters**:
  - `jobId`: Unique job identifier
  - `userId`: User identifier
  - `resumeText`: Resume content
  - `coverLetter`: Personal notes (optional)
  - `email`: Contact email
  - `phone`: Contact phone

#### AI Cover Letter Generation
- **Model**: OpenAI GPT-4
- **Temperature**: 0.3 (professional tone)
- **Max Tokens**: 1500
- **Customization**: Job-specific, resume-based

#### Application Storage
- Saves complete application data
- Tracks application status
- Maintains application history

## Usage Examples

### Job Search
```bash
curl -X POST http://localhost:5678/webhook/job-search \
  -H "Content-Type: application/json" \
  -d '{
    "keywords": "software engineer",
    "location": "remote",
    "jobType": "full-time",
    "experience": "mid-level",
    "salary": "80000-120000",
    "userId": "user123"
  }'
```

### Job Application
```bash
curl -X POST http://localhost:5678/webhook/job-application \
  -H "Content-Type: application/json" \
  -d '{
    "jobId": "adzuna-12345",
    "userId": "user123",
    "resumeText": "Experienced software engineer with 5 years in full-stack development...",
    "coverLetter": "Interested in this role because of my experience with React and Node.js",
    "email": "john.doe@email.com",
    "phone": "+1-555-0123"
  }'
```

## Required Credentials

### Job Board APIs

#### Adzuna
- **Type**: API Key
- **Setup**: 
  1. Register at [adzuna.com](https://www.adzuna.com)
  2. Get App ID and App Key
  3. Add to n8n credentials

#### Indeed
- **Type**: API Key
- **Setup**:
  1. Register at [indeed.com/publishers](https://ads.indeed.com/jobroll/xmlfeed)
  2. Get Publisher ID
  3. Add to n8n credentials

#### GitHub Jobs
- **Type**: No authentication required
- **Rate Limit**: Public API

### OpenAI
- **Type**: API Key
- **Node**: OpenAI
- **Setup**: Settings > Credentials > Add OpenAI API credential

### Supabase
- **Type**: API Key
- **Node**: Supabase
- **Setup**: Same as chatbot workflow

## API Response Formats

### Job Search Response
```json
{
  "jobs": [
    {
      "id": "adzuna-12345",
      "title": "Senior Software Engineer",
      "company": "Tech Corp",
      "location": "San Francisco, CA",
      "description": "We are looking for a senior software engineer...",
      "salary": "$120000-$150000",
      "type": "full-time",
      "url": "https://www.adzuna.com/jobs/12345",
      "posted": "2024-01-10T00:00:00Z",
      "source": "adzuna",
      "keywords": "software engineer",
      "matchScore": 85
    }
  ],
  "totalResults": 15,
  "searchCriteria": {
    "keywords": "software engineer",
    "location": "remote",
    "jobType": "full-time"
  },
  "timestamp": "2024-01-14T10:00:00Z"
}
```

### Application Response
```json
{
  "applicationId": "app-1234567890",
  "coverLetter": "Dear Hiring Manager,\n\nI am excited to apply for the Senior Software Engineer position...",
  "status": "generated",
  "timestamp": "2024-01-14T10:30:00Z"
}
```

## Advanced Features

### Custom Search Filters
```javascript
// Advanced search criteria
{
  "keywords": "react OR vue OR angular",
  "location": "remote OR 'new york' OR 'san francisco'",
  "jobType": "full-time",
  "excludeKeywords": "internship OR junior OR entry-level",
  "salaryMin": 80000,
  "salaryMax": 150000,
  "postedWithin": "7d", // 7d, 30d, 90d
  "companySize": "medium OR large"
}
```

### Enhanced Match Scoring
- **Skill Matching**: Parses resume skills against job requirements
- **Experience Level**: Matches years of experience
- **Industry Alignment**: Considers industry preferences
- **Culture Fit**: Analyzes company culture indicators

### Application Tracking
- **Status Updates**: Tracks application progress
- **Follow-up Reminders**: Automated follow-up scheduling
- **Response Analytics**: Tracks response rates and timing

## Integration Examples

### Frontend Integration
```javascript
class JobSearchAPI {
  async searchJobs(criteria) {
    const response = await fetch('/webhook/job-search', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(criteria)
    });
    return await response.json();
  }
  
  async applyForJob(applicationData) {
    const response = await fetch('/webhook/job-application', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(applicationData)
    });
    return await response.json();
  }
}
```

### Mobile App Integration
```swift
class JobSearchService {
    func searchJobs(criteria: JobSearchCriteria) async throws -> JobSearchResponse {
        let url = URL(string: "http://localhost:5678/webhook/job-search")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let payload = try JSONEncoder().encode(criteria)
        request.httpBody = payload
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(JobSearchResponse.self, from: data)
    }
}
```

## Performance Optimization

### API Rate Limiting
- **Adzuna**: 100 requests per hour
- **Indeed**: 1000 requests per day
- **GitHub Jobs**: 10 requests per minute
- **OpenAI**: 3500 requests per hour

### Caching Strategy
- **Job Listings**: Cache for 1 hour
- **Search Results**: Cache for 30 minutes
- **User Preferences**: Cache for 24 hours

### Database Optimization
- **Indexed Queries**: Optimized for user-based lookups
- **Connection Pooling**: Supabase handles automatically
- **Data Archival**: Archive old searches and applications

## Security & Privacy

### Data Protection
- **Resume Encryption**: Encrypt sensitive resume data
- **PII Handling**: Secure storage of personal information
- **API Key Security**: Store credentials securely in n8n

### Compliance
- **GDPR**: User data deletion capabilities
- **CCPA**: California privacy compliance
- **Data Retention**: Configurable data retention policies

## Analytics & Insights

### Search Analytics
- **Popular Keywords**: Track trending search terms
- **Location Insights**: Geographic job market analysis
- **Salary Trends**: Compensation market analysis

### Application Metrics
- **Success Rates**: Track application success rates
- **Response Times**: Analyze employer response patterns
- **Conversion Tracking**: Monitor application-to-interview ratios

## Future Enhancements
- [ ] LinkedIn integration
- [ ] Company research automation
- [ ] Interview preparation tools
- [ ] Salary negotiation assistance
- [ ] Network mapping for referrals
- [ ] Skill gap analysis
- [ ] Automated follow-up sequences
- [ ] Video interview preparation
- [ ] Personalized job recommendations
- [ ] Market trend analysis dashboard