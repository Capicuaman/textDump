# OpenCode Learning Plan for Intermediate Developer

## 1. Core Concepts and Fundamentals

### What is OpenCode?
- **AI Coding Agent**: An AI assistant that runs directly in your terminal
- **Open Source**: Full control over providers, models, and editors
- **Privacy-First**: No code or context data storage
- **LSP Integration**: Automatic Language Server Protocol support
- **Multi-Session**: Run multiple agents simultaneously

### Key Architecture
- **Terminal UI**: Native interface within your terminal
- **Model Agnostic**: Works with 75+ LLM providers
- **Project Context**: Understands your entire codebase
- **File Operations**: Read, write, edit files through natural language

## 2. Essential Commands/Basic Syntax

### Installation
```bash
curl -fsSL https://opencode.ai/install | bash
```

### Basic Usage
```bash
# Start OpenCode in current directory
opencode

# Start with specific file
opencode README.md

# Start with specific directory
opencode ./src

# Show help
opencode --help

# Check version
opencode --version
```

### In-Session Commands
- `/help` - Show available commands
- `/exit` - Exit the session
- `/clear` - Clear conversation history
- `/save` - Save current session
- `/load <session>` - Load previous session

## 3. Simple "Hello World" Starter Project

### Project Setup
```bash
# Create a new project directory
mkdir opencode-hello-world
cd opencode-hello-world

# Initialize a simple project
echo "# Hello World Project" > README.md

# Start OpenCode
opencode
```

### First OpenCode Session
Once in OpenCode, try these prompts:
```
Create a simple JavaScript file that logs "Hello, OpenCode!" to the console.
```

```
Create a basic HTML file with a "Hello World" heading and some styling.
```

```
Add a package.json file for this project with basic scripts.
```

## 4. Progressive Practice Exercises

### Exercise 1: File Management (Beginner)
**Goal**: Learn basic file operations with OpenCode

```bash
# Create practice directory
mkdir file-practice
cd file-practice
opencode
```

**Prompts to try**:
```
Create three files: notes.txt, todo.md, and config.json with appropriate content.
```

```
Read the contents of notes.txt and summarize what's in it.
```

```
Update todo.md to add a new high-priority task at the top.
```

### Exercise 2: Code Refactoring (Intermediate)
**Goal**: Use OpenCode to improve existing code

```bash
# Create a sample JavaScript file
cat > old-code.js << 'EOF'
function calculateTotal(items) {
    var total = 0;
    for (var i = 0; i < items.length; i++) {
        total = total + items[i].price;
    }
    return total;
}

function getUserInfo(user) {
    var name = user.name;
    var email = user.email;
    return name + " (" + email + ")";
}
EOF

opencode old-code.js
```

**Prompts to try**:
```
Refactor this JavaScript code to use modern ES6+ syntax and better practices.
```

```
Add JSDoc comments to document these functions.
```

```
Create unit tests for these functions using Jest.
```

### Exercise 3: Documentation Generation (Intermediate)
**Goal**: Generate and maintain documentation

```bash
mkdir docs-project
cd docs-project
opencode
```

**Prompts to try**:
```
Create a comprehensive README.md for a hypothetical web application project.
```

```
Generate API documentation for a REST API with endpoints for users, posts, and comments.
```

```
Create a CHANGELOG.md file following semantic versioning conventions.
```

### Exercise 4: Project Setup (Advanced)
**Goal**: Set up a complete project structure

```bash
mkdir full-project
cd full-project
opencode
```

**Prompts to try**:
```
Set up a complete React TypeScript project with proper folder structure, linting, and testing.
```

```
Create a Node.js Express API project with authentication, database models, and API routes.
```

```
Generate a complete documentation site using a static site generator for this project.
```

### Exercise 5: Code Review and Optimization (Advanced)
**Goal**: Analyze and optimize existing codebase

```bash
# Clone a simple open-source project or use your own
cd your-project-directory
opencode
```

**Prompts to try**:
```
Analyze this codebase for performance issues and suggest optimizations.
```

```
Review the code for security vulnerabilities and suggest fixes.
```

```
Identify code smells and refactor suggestions for better maintainability.
```

## 5. Common Pitfalls and How to Avoid Them

### Pitfall 1: Vague Prompts
**Problem**: "Fix my code" or "Make it better"
**Solution**: Be specific about what you want
```
❌ Bad: Fix this function
✅ Good: Refactor this function to use async/await and add error handling
```

### Pitfall 2: Missing Context
**Problem**: Not providing enough background information
**Solution**: Always include relevant context
```
❌ Bad: Create a user login
✅ Good: Create a user login using JWT tokens for a Node.js Express app with MongoDB
```

### Pitfall 3: Ignoring File Structure
**Problem**: Asking for changes without considering project organization
**Solution**: Mention file locations and structure
```
❌ Bad: Add validation
✅ Good: Add form validation to the user registration component in src/components/Auth/Register.js
```

### Pitfall 4: Not Verifying Output
**Problem**: Accepting AI-generated code without testing
**Solution**: Always review and test generated code
```bash
# After OpenCode generates code
npm test
npm run build
npm start
```

### Pitfall 5: Over-reliance on AI
**Problem**: Using OpenCode for every small task
**Solution**: Use it for complex tasks, learn the patterns, then apply them manually

## 6. Best Practices and Conventions

### Prompt Engineering Best Practices
1. **Be Specific**: Include technology stack, file names, and exact requirements
2. **Provide Context**: Share relevant code, error messages, and project details
3. **Iterative Approach**: Start simple, then add complexity
4. **Code Review**: Always review generated code before committing
5. **Version Control**: Commit changes in logical chunks

### Session Management
```bash
# Save important sessions
opencode --save-session project-setup

# Load previous sessions
opencode --load-session project-setup

# Use multiple sessions for different tasks
# Terminal 1: opencode (for coding)
# Terminal 2: opencode (for documentation)
```

### File Organization for Documents
```
documents/
├── business/
│   ├── contracts/
│   ├── proposals/
│   └── reports/
├── personal/
│   ├── notes/
│   ├── journal/
│   └── projects/
└── templates/
    ├── meeting-notes.md
    ├── project-proposal.md
    └── status-report.md
```

### Workflow Integration
1. **Morning Planning**: Use OpenCode to review daily tasks
2. **Coding Sessions**: Active development with AI assistance
3. **Documentation**: Generate and maintain project docs
4. **Code Review**: Use OpenCode as a second pair of eyes
5. **Learning**: Ask for explanations of complex concepts

## 7. Next Steps for Deeper Learning

### Advanced Techniques
1. **Custom Prompts**: Create reusable prompt templates
2. **Multi-File Operations**: Work across multiple files simultaneously
3. **Debugging Assistance**: Use OpenCode to troubleshoot issues
4. **Performance Optimization**: Analyze and improve code performance
5. **Security Audits**: Regular security reviews with AI assistance

### Integration with Other Tools
```bash
# Combine with Git workflow
git add .
opencode "Review these changes and suggest improvements"
git commit -m "Changes based on AI review"

# Use with testing frameworks
opencode "Write comprehensive tests for this component"
npm test

# Integrate with CI/CD
opencode "Generate a GitHub Actions workflow for automated testing"
```

### Community and Resources
- **GitHub Repository**: [sst/opencode](https://github.com/sst/opencode)
- **Documentation**: [opencode.ai/docs](https://opencode.ai/docs)
- **Discord Community**: Join for tips and tricks
- **Contributing**: Open source contributions welcome

### Continuous Improvement
1. **Weekly Review**: Assess how OpenCode improved your productivity
2. **Prompt Refinement**: Keep a list of effective prompts
3. **Knowledge Sharing**: Share techniques with your team
4. **Stay Updated**: Follow OpenCode releases and new features
5. **Feedback Loop**: Provide feedback to improve the tool

---

## Quick Reference Commands

```bash
# Daily workflow
opencode                    # Start session
/help                      # Show commands
/clear                     # Clear history
/exit                      # Exit session

# Project management
opencode ./src             # Start in specific directory
opencode package.json       # Start with specific file

# Learning and exploration
opencode "Explain this code: $(cat file.js)"
opencode "How does this work?"
opencode "Show me examples of..."
```

Remember: OpenCode is a tool to augment your skills, not replace them. Use it to learn faster, code better, and maintain high-quality documentation for both personal and business needs.