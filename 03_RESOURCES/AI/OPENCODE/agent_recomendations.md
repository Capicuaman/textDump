# OpenCode Agent Recommendations for Knowledge Management System

Based on my analysis of the repository structure and content, here are my recommendations for the most useful OpenCode agents to experiment with for this personal knowledge management system.

## Top Recommended OpenCode Agents

### 1. Documentation Agent (Highest Priority)

**Why it's perfect for your system:**
- Your repository is primarily Markdown-based documentation (70+ files)
- You have extensive interconnected knowledge systems (PARA method, BILAN business docs, learning resources)
- The agent can help maintain consistency across documentation styles
- Can automatically generate README files, API docs, and comprehensive guides

**Specific Use Cases:**
- Generate comprehensive documentation for the BILAN project's complex structure
- Create cross-reference tables between related topics
- Maintain consistent formatting across Spanish/English content
- Generate table of contents and navigation structures

### 2. Research Agent (High Priority)

**Why it's valuable:**
- You're constantly learning new technologies (Strudel, n8n, Fabric, Ollama)
- Need to research competitors for BILAN (LMNT, SALTT analysis)
- Generate educational content for ALICIA project
- Stay updated with AI tools and workflow automation

**Specific Use Cases:**
- Research electrolyte science for BILAN product documentation
- Find best practices for live coding music education
- Research marketing strategies for electrolyte business
- Compile learning roadmaps for new technologies

### 3. General Agent (Essential)

**Why it's foundational:**
- Versatile for all your diverse projects (BILAN, MUSIC, ALICIA)
- Can handle both technical (n8n workflows) and content (marketing copy) tasks
- Supports your multi-language requirements (English/Spanish)
- Works well with your existing file organization patterns

**Specific Use Cases:**
- Create n8n automation workflows
- Generate marketing content for BILAN campaigns
- Set up project structures for new initiatives
- Refactor and organize existing documentation

## Secondary Recommendations

### 4. Code Review Agent (Useful for Technical Components)

**When to use:**
- Review n8n workflow configurations
- Validate JSON structures (VEO prompts, FAQ database)
- Check Python scripts for data processing
- Review any custom automation scripts

### 5. Testing Agent (Limited but Valuable)

**Specific applications:**
- Test JSON schema validity for BILAN's structured data
- Validate n8n workflow configurations
- Test markdown links and references
- Verify data integrity in knowledge bases

## Recommended Experimentation Workflow

### Phase 1: Start with Documentation Agent

```bash
# Navigate to your knowledge management repository
cd /Users/ideaopedia/Documents/textDump
opencode
/init  # Let it analyze your structure
```

**First prompts to try:**
1. "Analyze my PARA organizational system and suggest improvements"
2. "Create a comprehensive documentation guide for the BILAN project"
3. "Generate cross-references between related topics across different projects"
4. "Create templates for new project documentation"

### Phase 2: Add Research Agent

**Experiment with:**
1. "Research the latest electrolyte science trends for BILAN marketing"
2. "Find best practices for live coding music education"
3. "Research competitor marketing strategies in the electrolyte space"
4. "Compile learning resources for n8n workflow automation"

### Phase 3: Integrate General Agent

**Test with:**
1. "Reorganize the 00_INBOX folder using PARA principles"
2. "Create a new campaign structure for BILAN marketing"
3. "Set up a documentation system for MUSIC project learning"
4. "Generate content for ALICIA educational materials"

## Why These Agents Fit Your Workflow

### Content-Centric Nature
- 70% of your repository is documentation
- Multi-language support requirements
- Interconnected knowledge systems
- Regular content creation and updates

### Project Diversity
- Business documentation (BILAN)
- Educational content (ALICIA)
- Creative/technical projects (MUSIC/Strudel)
- Learning resources and roadmaps

### Organizational Complexity
- PARA method requires consistent categorization
- Cross-project references and connections
- Multiple file formats (Markdown, JSON, HTML)
- Version control and workflow management

### AI Integration Points
- RAG systems for customer support
- VEO video generation prompts
- n8n workflow automations
- Fabric pattern integration

## Pro Tips for Your Use Case

1. Start with Plan Mode for complex reorganization tasks
2. Use the @ symbol to reference existing files and maintain consistency
3. Commit AGENTS.md to help agents learn your specific patterns
4. Leverage multi-session support - one for documentation, one for research
5. Use image support for design work (BILAN packaging, marketing visuals)

---

The Documentation and Research agents will likely provide the most immediate value for your knowledge management system, followed by the General agent for day-to-day tasks across all your diverse projects.