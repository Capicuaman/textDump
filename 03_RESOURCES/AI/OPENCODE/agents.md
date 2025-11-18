# OpenCode Agents Guide

Comprehensive guide to how AI agents work within OpenCode and how to leverage them effectively.

---

## 🤖 What Are OpenCode Agents?

OpenCode agents are specialized AI assistants designed to handle specific tasks and workflows within the OpenCode ecosystem. Each agent has unique capabilities, tools, and areas of expertise.

### Agent Types
- **General Agent** - All-purpose coding and development tasks
- **Research Agent** - Information gathering and analysis
- **Code Review Agent** - Code quality and best practices
- **Documentation Agent** - Technical writing and API docs
- **Testing Agent** - Test creation and quality assurance

---

## 🎯 Agent Capabilities

### Core Functions
Each agent can perform:
- **File Operations**: Read, write, edit, and manage files
- **Code Analysis**: Understand, review, and refactor code
- **Search & Navigation**: Find files, search content, explore codebases
- **Command Execution**: Run bash commands, scripts, and tools
- **Web Access**: Fetch documentation, APIs, and online resources
- **Task Management**: Create and manage todo lists
- **Multi-tool Coordination**: Use multiple tools simultaneously

### Specialized Skills
- **Pattern Recognition**: Identify code patterns and architectures
- **Language Expertise**: Deep knowledge of programming languages
- **Framework Knowledge**: Understanding of libraries and frameworks
- **Best Practices**: Apply industry standards and conventions
- **Problem Solving**: Debug issues and propose solutions

---

## 🔄 Agent Workflow Process

### 1. Task Analysis
When you give a task, the agent:
```
1. Parse and understand the request
2. Identify required tools and information
3. Plan the approach (if in Plan mode)
4. Execute the task step by step
5. Verify results and provide feedback
```

### 2. Tool Selection
Agents automatically choose appropriate tools:
- **Read Tool**: For file analysis and understanding
- **Write Tool**: For creating new content
- **Edit Tool**: For modifying existing files
- **Bash Tool**: For system operations
- **WebFetch Tool**: For online research
- **Grep/Glob Tools**: For code searching
- **Task Tool**: For complex multi-step operations

### 3. Context Management
Agents maintain context through:
- **Project Structure**: Understanding file organization
- **Code Patterns**: Recognizing your coding style
- **Conversation History**: Remembering previous interactions
- **AGENTS.md**: Using project-specific configuration

---

## 🎮 Agent Modes

### Plan Mode
**Purpose**: Analyze and plan without making changes

**When Used**:
- Complex tasks requiring careful planning
- When you want to review approach before execution
- Multi-step projects where sequence matters

**Behavior**:
- Observes and analyzes only
- Creates detailed step-by-step plans
- Cannot modify files or run commands
- Must switch to Build mode to execute

**Example**:
```
User: "Add authentication to our React app"
Agent: [Plan Mode] I'll analyze your current auth setup,
        create a plan for implementing JWT authentication,
        and outline the required components before making changes.
```

### Build Mode
**Purpose**: Execute tasks and make changes

**When Used**:
- Straightforward implementation tasks
- After planning is complete
- Routine coding and file operations

**Behavior**:
- Can read, write, and edit files
- Execute commands and run tools
- Make actual changes to your project
- Provides real-time feedback

**Example**:
```
User: "Create a new component"
Agent: [Build Mode] I'll create the component file,
        implement the required functionality,
        and add it to your project structure.
```

---

## 🛠️ Agent Tools & Usage

### File Operations
**Read Tool**:
```bash
# Agent reads file to understand content
read /path/to/file.js
```

**Write Tool**:
```bash
# Agent creates new files
write /path/to/new-file.js "content here"
```

**Edit Tool**:
```bash
# Agent modifies existing files
edit /path/to/file.js "old text" "new text"
```

### Search & Discovery
**Grep Tool**:
```bash
# Search for patterns in files
grep "function.*auth" --include="*.js"
```

**Glob Tool**:
```bash
# Find files by pattern
glob "**/*.test.js"
```

**List Tool**:
```bash
# Explore directory structure
list /path/to/directory
```

### System Operations
**Bash Tool**:
```bash
# Execute system commands
bash "npm install package-name"
bash "git status"
bash "python script.py"
```

### External Research
**WebFetch Tool**:
```bash
# Get online documentation
webfetch "https://docs.example.com" "markdown"
```

### Task Management
**TodoWrite Tool**:
```bash
# Create task lists
todowrite [{"task": "Implement auth", "status": "pending"}]
```

---

## 🧠 Agent Intelligence Features

### Code Understanding
Agents can:
- **Parse Syntax**: Understand programming language structure
- **Identify Patterns**: Recognize design patterns and architectures
- **Trace Dependencies**: Follow imports and relationships
- **Analyze Logic**: Understand code flow and algorithms

### Context Awareness
Agents maintain:
- **Project Context**: Understanding of your project structure
- **Coding Style**: Adapting to your preferences
- **Framework Knowledge**: Knowing your tech stack
- **Best Practices**: Applying industry standards

### Problem Solving
Agents excel at:
- **Debugging**: Identifying and fixing bugs
- **Refactoring**: Improving code structure
- **Optimization**: Enhancing performance
- **Integration**: Connecting different components

---

## 🎯 Working with Agents Effectively

### Provide Clear Context
**Good Example**:
```
"I need to add user authentication to our React app.
We use JWT tokens, have an auth service at src/services/auth.js,
and need to protect the /dashboard route."
```

**Poor Example**:
```
"Add auth to app"
```

### Use Plan Mode for Complex Tasks
**When to Use Plan Mode**:
- Multi-step implementations
- Architectural changes
- When you want to review the approach
- Risky modifications to critical code

**Benefits**:
- Review approach before execution
- Catch potential issues early
- Understand the agent's reasoning
- Modify the plan if needed

### Leverage Agent Specialization
**Different Agents for Different Tasks**:
- **Code Review**: Use for quality checks and best practices
- **Research**: Use for documentation and information gathering
- **Testing**: Use for test creation and coverage
- **Documentation**: Use for API docs and technical writing

### Provide Feedback and Iteration
**Effective Feedback Loop**:
1. Agent proposes solution
2. You review and provide feedback
3. Agent adjusts based on feedback
4. Iterate until satisfactory

---

## 🔧 Advanced Agent Features

### Multi-Tool Coordination
Agents can use multiple tools simultaneously:
```bash
# Agent runs these in parallel
read package.json
glob "**/*.js"
grep "TODO" --include="*.js"
```

### Error Recovery
When things go wrong, agents:
- **Identify Issues**: Recognize errors and failures
- **Propose Solutions**: Suggest fixes and workarounds
- **Rollback Changes**: Use undo operations when needed
- **Learn from Mistakes**: Improve future responses

### Custom Agent Configuration
You can customize agent behavior through:
- **AGENTS.md**: Project-specific instructions
- **Mode Preferences**: Default to Plan or Build mode
- **Tool Preferences**: Specify preferred tools and approaches
- **Style Guidelines**: Define coding standards

---

## 📊 Agent Performance Metrics

### Efficiency Indicators
Good agent interactions show:
- **Fast Response Times**: Quick tool execution
- **Accurate Results**: Correct code and solutions
- **Context Retention**: Remembering previous context
- **Tool Efficiency**: Using appropriate tools for tasks

### Quality Measures
High-quality agent work includes:
- **Clean Code**: Following best practices
- **Proper Error Handling**: Robust error management
- **Documentation**: Clear comments and explanations
- **Testing**: Including appropriate tests

---

## 🚀 Best Practices for Agent Interaction

### Before Starting
1. **Clear Goals**: Know what you want to accomplish
2. **Provide Context**: Share relevant project information
3. **Set Expectations**: Define success criteria
4. **Choose Right Mode**: Plan vs. Build mode

### During Interaction
1. **Be Specific**: Detailed requests get better results
2. **Provide Feedback**: Correct and guide the agent
3. **Ask Questions**: Clarify when unsure
4. **Monitor Progress**: Review changes as they happen

### After Completion
1. **Review Changes**: Check what was modified
2. **Test Results**: Verify functionality works
3. **Request Refinements**: Ask for improvements if needed
4. **Save Context**: Update AGENTS.md with learnings

---

## 🔗 Integration with Development Workflow

### Git Integration
Agents work seamlessly with Git:
- **Commit Messages**: Generate meaningful commit messages
- **Branch Management**: Handle feature branches
- **Merge Conflicts**: Help resolve conflicts
- **Code Review**: Provide PR suggestions

### IDE Integration
Use agents alongside your favorite editor:
- **Complementary**: Agents handle tasks IDEs don't
- **File Sync**: Changes appear in your IDE
- **Workflow Enhancement**: Automate repetitive tasks
- **Focus Time**: Let agents handle boilerplate

### CI/CD Pipeline
Agents can help with:
- **Script Generation**: Create build and deploy scripts
- **Configuration**: Set up pipeline files
- **Debugging**: Troubleshoot pipeline issues
- **Optimization**: Improve build performance

---

## 🎓 Learning from Agents

### Code Education
Agents can teach you:
- **New Languages**: Learn syntax and patterns
- **Best Practices**: Understand industry standards
- **Design Patterns**: Learn architectural approaches
- **Problem-Solving**: See different solution approaches

### Skill Development
Working with agents helps develop:
- **Technical Communication**: Better requirement articulation
- **Code Review Skills**: Learn to spot issues
- **Project Planning**: Break down complex tasks
- **Tool Mastery**: Learn efficient workflows

---

## 🔮 Future of OpenCode Agents

### Evolving Capabilities
Agents are continuously improving:
- **More Languages**: Expanded programming language support
- **Better Context**: Enhanced memory and understanding
- **New Tools**: Additional specialized capabilities
- **Improved Learning**: Better adaptation to user preferences

### Community Contributions
The agent ecosystem benefits from:
- **User Feedback**: Real-world usage data
- **Feature Requests**: Community-driven development
- **Open Source**: Collaborative improvement
- **Documentation**: Community knowledge sharing

---

*This guide provides a comprehensive understanding of how OpenCode agents work and how to effectively collaborate with them for enhanced productivity and development workflows.*