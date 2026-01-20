# AI Customer Support FAQ Bot - Test Cases

## Test Data Set

### Test Case 1: Basic Product Information
```json
{
  "question": "What is BILAN electrolyte powder?",
  "email": "customer1@example.com",
  "name": "Sarah Johnson"
}
```

### Test Case 2: Usage Instructions
```json
{
  "question": "How do I use BILAN and when should I take it?",
  "email": "customer2@example.com",
  "name": "Mike Chen"
}
```

### Test Case 3: Medical Safety Question
```json
{
  "question": "I have high blood pressure, is BILAN safe for me?",
  "email": "customer3@example.com",
  "name": "Robert Davis"
}
```

### Test Case 4: Exercise Performance
```json
{
  "question": "How does BILAN help with athletic performance and endurance?",
  "email": "customer4@example.com",
  "name": "Athlete User"
}
```

### Test Case 5: Comparison Question
```json
{
  "question": "What's the difference between BILAN and regular sports drinks?",
  "email": "customer5@example.com",
  "name": "Curious Shopper"
}
```

### Test Case 6: Urgent Medical Situation
```json
{
  "question": "Emergency! I'm experiencing severe dehydration and muscle cramps",
  "email": "urgent@example.com",
  "name": "Emergency Contact",
  "phone": "+1234567890"
}
```

### Test Case 7: Diet-Specific Question
```json
{
  "question": "Can I use BILAN on a keto diet?",
  "email": "keto@example.com",
  "name": "Keto Dieter"
}
```

### Test Case 8: Ingredient Question
```json
{
  "question": "What are the ingredients in BILAN? Does it contain sugar?",
  "email": "health@example.com",
  "name": "Health Conscious"
}
```

### Test Case 9: General Hydration
```json
{
  "question": "How much water should I drink daily and what are the signs of dehydration?",
  "email": "general@example.com",
  "name": "General User"
}
```

### Test Case 10: Children Usage
```json
{
  "question": "Can my 12-year-old use BILAN for soccer practice?",
  "email": "parent@example.com",
  "name": "Concerned Parent"
}
```

## Expected Response Analysis

### Classification Testing
Each test case should be correctly classified:
- Test Case 1-2, 5, 7-8: "BILAN Electrolyte Product"
- Test Case 3, 6, 10: "Medical Conditions & Electrolytes" (high urgency for 6)
- Test Case 4: "Exercise & Athletic Performance"
- Test Case 9: "Fluid Balance & Hydration Basics"

### FAQ Matching Validation
- High confidence matches (>80%) for direct product questions
- Medium confidence (60-80%) for related topics
- Low confidence (<60%) for general questions

### Response Quality Checks
- Professional tone maintained
- Medical disclaimers included where appropriate
- Accurate product information
- Helpful next steps provided

## Testing Procedure

### 1. Manual Testing
Use n8n's "Execute Workflow" feature with each test case:
1. Copy test data to webhook node
2. Execute workflow
3. Review each node's output
4. Verify final response quality

### 2. Automated Testing
Create test script to send POST requests:
```bash
curl -X POST http://localhost:5678/webhook/customer-support \
  -H "Content-Type: application/json" \
  -d '{"question":"What is BILAN?","email":"test@example.com","name":"Test User"}'
```

### 3. Channel Testing
Verify multi-channel output:
- Email content formatting
- SMS message length (160 chars)
- Slack notification structure

## Performance Benchmarks

### Response Time Targets
- Classification: < 500ms
- FAQ Search: < 300ms
- Claude API: < 3000ms
- Total Workflow: < 5000ms

### Accuracy Metrics
- Question Classification: > 90%
- FAQ Matching: > 80%
- Response Quality: > 85% satisfaction

## Error Testing

### Invalid Input Tests
```json
{
  "question": "",
  "email": "invalid-email",
  "name": ""
}
```

### Edge Cases
- Very long questions (>500 chars)
- Special characters in questions
- Missing required fields
- Malformed JSON

### API Failure Testing
- Claude API timeout simulation
- FAQ database unavailable
- Email service failure
- SMS service failure

## Success Criteria

### Functional Requirements
✅ All test cases process successfully
✅ Appropriate FAQ matches found
✅ Professional responses generated
✅ Multi-channel routing works
✅ Error handling functions correctly

### Non-Functional Requirements
✅ Response time under 5 seconds
✅ 100% webhook success rate
✅ Proper error messages
✅ Secure data handling
✅ Scalable architecture

---

**Testing Complete**: Move to Project 3 - AI Email Auto-Responder