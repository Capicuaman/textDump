# n8n Primer: Workflow Automation Made Easy

## What is n8n?

n8n is an open-source, fair-code workflow automation platform that allows you to automate business processes and integrate applications without writing code. It's like Zapier or Make, but self-hosted and extensible.

## Key Features

- **No-Code Workflow Builder**: Visual interface to create complex automations
- **500+ Integrations**: Connect to popular apps like Slack, Salesforce, GitHub, Stripe, and more
- **Self-Hosted**: Deploy on your own servers for full control and privacy
- **Open Source**: Community-driven with active development
- **Custom Code**: Add JavaScript nodes when you need advanced logic
- **Webhooks & APIs**: Trigger workflows from external systems
- **Data Transformation**: Built-in nodes for JSON, CSV, and data manipulation

## Core Concepts

### Workflows
A workflow is a series of connected nodes that execute in sequence or conditionally. Workflows can be triggered manually, on a schedule, or by incoming events.

### Nodes
Nodes are the building blocks of workflows. Each node represents an action or data transformation. Types include:
- **Trigger Nodes**: Start a workflow (Webhook, Schedule, Manual)
- **Action Nodes**: Interact with external services (Slack, Email, HTTP)
- **Logic Nodes**: Control flow (If/Else, Loop, Merge, Split)
- **Data Nodes**: Transform data (Set, Function, Code)

### Connections
Nodes are connected with edges that define data flow. Output from one node becomes input to the next.

### Credentials
Secure storage for API keys, passwords, and authentication details needed to connect to external services.

## Getting Started

### Installation

**Using Docker (Recommended)**:
```bash
docker run -it --rm \
  -p 5678:5678 \
  -e DB=sqlite \
  n8nio/n8n
```

**Using npm**:
```bash
npm install -g n8n
n8n start
```

Then access n8n at `http://localhost:5678`

### Creating Your First Workflow

1. Click "New" → "New Workflow"
2. Click the "+" icon to add a trigger node (e.g., "Manual Trigger")
3. Click the "+" icon again to add an action node (e.g., "Send Email", "Send Slack Message")
4. Configure the nodes with required parameters
5. Click "Execute Workflow" to test
6. Click "Save" and "Activate" to enable

## Common Use Cases

### Send Slack Notifications
Trigger: Webhook or Schedule → Action: Slack "Send a message"

### Database Backups
Trigger: Schedule (daily) → Action: Query database → Action: Send to Cloud Storage

### Lead Generation Pipeline
Trigger: Webhook (new lead form) → Action: Add to CRM → Action: Send welcome email → Action: Create task

### Data Synchronization
Trigger: Schedule → Action: Query source app → Action: Transform data → Action: Update destination app

## Working with Data

### Accessing Data
Use dot notation to access properties:
- `{{ $node["Node Name"].json.propertyName }}`
- `{{ $json.email }}`

### Transformations
Use the "Set" node or "Function" node to transform data:

**Set Node Example**:
```
Field: output
Value: {{ $json.first_name }} {{ $json.last_name }}
```

**Function Node** (JavaScript):
```javascript
return [
  {
    json: {
      fullName: data[0].json.firstName + ' ' + data[0].json.lastName,
      email: data[0].json.email.toLowerCase()
    }
  }
];
```

## Advanced Features

### Conditional Logic
Use "If" node to execute different branches based on conditions:
- Input: Check if `$json.status === "active"`
- True path: Process active records
- False path: Skip or handle differently

### Loops
Use "Loop" node to process multiple items:
```
Loop over: {{ $json.items }}
For each item, trigger connected nodes
```

### Error Handling
- **Try-Catch**: Wrap nodes to catch errors
- **Error Output**: Send failed items to error handler
- **Continue on Fail**: Don't stop workflow on error

### Scheduling
Set workflows to run on intervals:
- Every minute/hour/day/week/month
- At specific times (e.g., 9 AM daily)
- On cron expressions

## Tips & Best Practices

1. **Test Incrementally**: Execute and verify each node works before adding more
2. **Use Variables**: Store values in "Set" nodes for reuse and clarity
3. **Add Comments**: Use "Note" nodes to document complex sections
4. **Organize Nodes**: Use spacing and alignment for readability
5. **Handle Errors**: Always plan for failed API calls or invalid data
6. **Monitor Execution**: Check the "Executions" tab to debug failures
7. **Version Control**: Export workflows as JSON and commit to Git
8. **Use Environment Variables**: Keep sensitive data secure with credentials

## Resources

- **Official Docs**: https://docs.n8n.io/
- **Community Forum**: https://community.n8n.io/
- **GitHub**: https://github.com/n8n-io/n8n
- **Workflow Templates**: https://n8n.io/workflows/
- **YouTube Channel**: n8n channel with tutorials

## Next Steps

1. Install n8n locally
2. Build a simple workflow (e.g., Slack notification on schedule)
3. Explore available nodes in your domain
4. Join the community for support
5. Consider advanced workflows with data transformation and error handling
