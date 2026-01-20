# AI Customer Support FAQ Bot - Test Suite

## Quick Test for Colleagues

### 1. Direct Testing Commands

Copy these commands into terminal to test different scenarios:

#### Product Questions
```bash
# Basic product question
curl -X POST http://localhost:5678/webhook/customer-support \
  -H "Content-Type: application/json" \
  -d '{"question": "What is BILAN?", "email": "test1@company.com", "name": "Product Tester"}'

# Usage instructions
curl -X POST http://localhost:5678/webhook/customer-support \
  -H "Content-Type: application/json" \
  -d '{"question": "How do I use BILAN powder?", "email": "test2@company.com", "name": "Usage Tester"}'

# Safety question
curl -X POST http://localhost:5678/webhook/customer-support \
  -H "Content-Type: application/json" \
  -d '{"question": "Is BILAN safe for daily use?", "email": "test3@company.com", "name": "Safety Tester"}'
```

#### Medical/Health Questions
```bash
# Medical condition
curl -X POST http://localhost:5678/webhook/customer-support \
  -H "Content-Type: application/json" \
  -d '{"question": "Can I use BILAN if I have high blood pressure?", "email": "medical@company.com", "name": "Medical Concern"}'

# Urgent situation
curl -X POST http://localhost:5678/webhook/customer-support \
  -H "Content-Type: application/json" \
  -d '{"question": "Emergency help! I have severe dehydration symptoms", "email": "urgent@company.com", "name": "Urgent Case", "phone": "+1234567890"}'
```

#### General Questions
```bash
# General hydration
curl -X POST http://localhost:5678/webhook/customer-support \
  -H "Content-Type: application/json" \
  -d '{"question": "How much water should I drink daily?", "email": "general@company.com", "name": "General Inquiry"}'

# Exercise performance
curl -X POST http://localhost:5678/webhook/customer-support \
  -H "Content-Type: application/json" \
  -d '{"question": "How does BILAN improve athletic performance?", "email": "athlete@company.com", "name": "Athlete User"}'
```

### 2. Test Scenarios Matrix

| Question Type | Test Question | Expected Category | Expected Channels |
|---------------|---------------|-------------------|-----------------|
| Product Info | "What ingredients are in BILAN?" | BILAN Electrolyte Product | Email + Slack |
| Medical Safety | "Is BILAN safe for diabetics?" | Medical Conditions | Email + Slack |
| Urgent Help | "Emergency dehydration symptoms" | Emergency | Email + SMS + Slack |
| Usage Help | "How to mix BILAN powder?" | BILAN Electrolyte Product | Email + Slack |
| Comparison | "BILAN vs sports drinks" | BILAN Electrolyte Product | Email + Slack |

### 3. Success Indicators

For each test, check that the response includes:
- ✅ **Correct Classification**: Question categorized properly
- ✅ **Relevant FAQs**: Matching answers from database
- ✅ **Professional Response**: Claude-generated helpful answer
- ✅ **Medical Disclaimers**: Healthcare provider recommendations
- ✅ **Channel Routing**: Email always sent, SMS for urgent
- ✅ **JSON Format**: Proper webhook response structure

### 4. Test Web Interface

If colleague prefers GUI, create this simple HTML file:

```html
<!DOCTYPE html>
<html>
<head>
    <title>BILAN FAQ Bot Test</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        input { margin: 10px 0; padding: 8px; }
        button { padding: 10px 20px; background: #007cba; color: white; border: none; cursor: pointer; }
        #response { margin-top: 20px; padding: 20px; background: #f5f5f5; border-radius: 5px; }
    </style>
</head>
<body>
    <h2>🧪 BILAN Customer Support Bot Test Interface</h2>
    
    <div>
        <label><strong>Question:</strong></label><br>
        <input type="text" id="question" placeholder="Enter your test question..." style="width: 400px;"><br><br>
        
        <label><strong>Email:</strong></label><br>
        <input type="email" id="email" placeholder="test@example.com" style="width: 400px;"><br><br>
        
        <label><strong>Name:</strong></label><br>
        <input type="text" id="name" placeholder="Your name" style="width: 400px;"><br><br>
        
        <label><strong>Phone (optional):</strong></label><br>
        <input type="tel" id="phone" placeholder="+1234567890" style="width: 400px;"><br><br>
        
        <button onclick="testBot()">🚀 Test FAQ Bot</button>
    </div>
    
    <div id="response" style="display: none;">
        <h3>🤖 Bot Response:</h3>
        <pre id="responseText"></pre>
    </div>

    <script>
        function testBot() {
            const question = document.getElementById('question').value;
            const email = document.getElementById('email').value;
            const name = document.getElementById('name').value;
            const phone = document.getElementById('phone').value;
            
            if (!question || !email || !name) {
                alert('Please fill in question, email, and name');
                return;
            }
            
            const requestData = { question, email, name };
            if (phone) requestData.phone = phone;
            
            fetch('http://localhost:5678/webhook/customer-support', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(requestData)
            })
            .then(response => response.json())
            .then(data => {
                document.getElementById('response').style.display = 'block';
                document.getElementById('responseText').textContent = JSON.stringify(data, null, 2);
            })
            .catch(error => {
                document.getElementById('response').style.display = 'block';
                document.getElementById('responseText').textContent = 'Error: ' + error.message;
            });
        }
    </script>
</body>
</html>
```

### 5. Team Testing Instructions

1. **Test Each Category**: Run questions from every FAQ category
2. **Verify Responses**: Check for accuracy and professionalism  
3. **Monitor Logs**: Watch n8n executions for any errors
4. **Performance Check**: Note response times (should be <5 seconds)
5. **Channel Testing**: Confirm email Slack notifications work

### 6. Troubleshooting

If tests fail:
- Check webhook URL is correct
- Verify n8n workflow is published
- Confirm Claude API credits available
- Check network connectivity
- Review n8n execution logs

---

**Ready for colleague testing!** 🧪