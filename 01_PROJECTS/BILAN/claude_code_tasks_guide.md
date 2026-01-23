# Claude Code Tasks Guide for BILAN

**Project:** BILAN Electrolyte Business
**Purpose:** Leverage Claude Code's background tasks and parallel agents for content generation, research, and marketing workflows
**Last Updated:** January 23, 2026

## Overview

Claude Code's tasks feature enables parallel and background execution of AI agents. For BILAN, this is particularly powerful because:

1. **Content is king** - Most work involves generating marketing materials, documentation, and creative content
2. **Multi-channel approach** - Content needs to be created across blogs, social media, emails, and web
3. **Bilingual requirements** - English and Spanish content often needed simultaneously
4. **Research-intensive** - Product claims require scientific backing and competitive analysis
5. **Time-sensitive campaigns** - Marketing campaigns often need rapid execution

## Core Concepts

### Background Tasks
Tasks that run autonomously while you continue working. Perfect for:
- Long-form content generation
- Research and analysis
- Batch operations
- Monitoring and observation

### Parallel Agents
Multiple agents working simultaneously on different aspects of the same project. Ideal for:
- Multi-channel campaigns
- Simultaneous content creation
- Competitive analysis across multiple competitors
- Translation workflows

### Task Monitoring
Use `/tasks` command to:
- View all active background tasks
- Check progress on running agents
- Teleport into tasks to provide guidance
- See completion status

## BILAN-Specific Use Cases

### 1. Content Generation Workflows

#### Blog Content Pipeline
**Scenario:** Need multiple blog posts quickly
**Implementation:**
- Spawn 5 background agents, each writing a different post
- Each agent researches from `PRODUCT/` directory
- Posts saved to `BLOG/src/content/blog/`
- Review and edit when all complete

**Benefits:**
- 5 posts in parallel vs. sequential
- Consistent quality across posts
- Research happens once, shared context

#### Social Media Campaigns
**Scenario:** Week-long Instagram campaign
**Implementation:**
- Background task generates 7 days of content
- Pulls product info from `MARKETING/RAG/faq.json`
- Creates captions, hashtags, and CTAs
- Saves to `MARKETING/SOCIAL-MEDIA/instagram/`

**Benefits:**
- Campaign ready in minutes
- Consistent messaging
- Time to focus on strategy

### 2. Marketing Material Creation

#### Multi-Channel Campaign Launch
**Scenario:** Launch new product flavor
**Implementation:**
- **Agent 1 (Background):** Email sequence → `MARKETING/EMAIL/`
- **Agent 2 (Background):** Social media content → `MARKETING/SOCIAL-MEDIA/`
- **Agent 3 (Background):** Blog announcement → `BLOG/`
- **Agent 4 (Background):** VEO video scripts → `MARKETING/VEO/`
- **Agent 5 (Background):** Update FAQ → `MARKETING/RAG/faq.json`

**Benefits:**
- Complete campaign in one session
- Consistent messaging across channels
- All materials ready for review simultaneously

#### Sales Material Updates
**Scenario:** Update sales playbook with new objection handling
**Implementation:**
- Background agent reviews `SALES/consolidated_sales_manual.md`
- Generates new objection responses
- Updates relevant sections
- Creates training materials

**Benefits:**
- Sales team equipped quickly
- Consistent approach
- Evidence-based responses from product docs

### 3. Research & Analysis

#### Competitive Intelligence
**Scenario:** Analyze 5 top competitors
**Implementation:**
- Spawn 5 parallel agents
- Each analyzes one competitor (pricing, positioning, claims)
- Generate reports in `COMPETITIVEANALYSIS/`
- Consolidated findings presented together

**Benefits:**
- Comprehensive analysis in fraction of time
- Side-by-side comparison ready
- Strategic insights immediately actionable

#### Scientific Research
**Scenario:** Deep dive into electrolyte science
**Implementation:**
- Background agent researches latest studies
- Updates `PRODUCT/ingredients/` documentation
- Generates FAQ entries for `MARKETING/RAG/`
- Creates blog post drafts

**Benefits:**
- Product claims backed by research
- Marketing materials always current
- Educational content ready

### 4. Translation Workflows

#### Bilingual Content Creation
**Scenario:** Create product page in English and Spanish
**Implementation:**
- **Agent 1 (Background):** Write English version
- **Agent 2 (Background):** Write Spanish version (not just translation, but culturally adapted)
- Both save to respective directories
- Review both simultaneously

**Benefits:**
- True localization, not just translation
- Simultaneous launch in both markets
- Cultural nuances respected

#### Documentation Maintenance
**Scenario:** Update all product docs in both languages
**Implementation:**
- Background task identifies outdated content
- Updates English versions
- Creates Spanish equivalents
- Flags items needing human review

**Benefits:**
- Documentation stays current
- No language gets neglected
- Consistency across languages

### 5. SEO & Web Development

#### SEO Optimization Campaign
**Scenario:** Optimize 20 blog posts for search
**Implementation:**
- Background agent analyzes each post
- Identifies keyword opportunities
- Suggests meta descriptions
- Updates internal linking
- Generates report with recommendations

**Benefits:**
- Site-wide SEO in one pass
- Data-driven optimizations
- Focus on content creation

#### Content Audit
**Scenario:** Audit all marketing materials
**Implementation:**
- Background task scans all markdown files
- Checks for broken links
- Verifies product claims match current formulation
- Identifies outdated statistics
- Generates audit report

**Benefits:**
- Brand consistency maintained
- Accuracy ensured
- Issues caught early

### 6. Automation & n8n Workflows

#### Workflow Testing
**Scenario:** Test n8n workflows before deployment
**Implementation:**
- Background agent runs workflow scenarios
- Monitors for errors
- Documents edge cases
- Generates test report

**Benefits:**
- Confidence in automation
- Issues found before production
- Documentation created automatically

## Common Task Patterns

### Pattern 1: Batch Content Generation
```
Input: List of content topics
Process: Spawn one agent per topic
Output: Multiple pieces ready for review
Time Saved: 5x faster than sequential
```

### Pattern 2: Research + Application
```
Input: Research topic
Process:
  - Agent 1: Research in background
  - Agent 2: Apply findings to marketing (waits for Agent 1)
Output: Research-backed marketing materials
Time Saved: Parallel research + application
```

### Pattern 3: Multi-Channel Coordination
```
Input: Campaign theme
Process: Parallel agents for each channel
Output: Coordinated campaign across all channels
Time Saved: All channels ready simultaneously
```

### Pattern 4: Iterative Improvement
```
Input: Existing content
Process: Background analysis + recommendations
Output: Optimized content + improvement roadmap
Time Saved: Analysis doesn't block new creation
```

## Best Practices

### When to Use Background Tasks

✅ **DO use background tasks for:**
- Long-form content generation (blog posts, guides)
- Research and competitive analysis
- Batch operations (updating multiple files)
- SEO audits and optimization
- Translation workflows
- Documentation generation

❌ **DON'T use background tasks for:**
- Quick edits or changes
- Tasks requiring frequent human input
- Highly iterative creative work
- When you need to review each step

### Task Organization

1. **Name tasks descriptively** - "Generate 5 blog posts about hydration"
2. **Monitor progress** - Use `/tasks` to check on long-running tasks
3. **Review together** - Let all parallel tasks complete before final review
4. **Iterate in main session** - Use background for generation, iterate in main thread

### Quality Control

1. **Set clear parameters** - Provide detailed prompts for background agents
2. **Reference source materials** - Point agents to `PRODUCT/`, `MARKETING/RAG/`
3. **Review before publishing** - Background tasks generate drafts, you finalize
4. **Maintain brand voice** - Provide style guides and examples

## Task Templates

See `claude_code_task_templates.md` for ready-to-use prompts.

## Workflow Definitions

See `claude_code_task_workflows.md` for specific workflow implementations.

## Monitoring & Management

### Checking Task Status
```bash
/tasks
```

### Teleporting Into a Task
From `/tasks` interface, press `t` to jump into a specific task

### Task Completion
You'll receive notification when background tasks complete

### Error Handling
If a task encounters issues, teleport in to provide guidance or context

## Integration with BILAN Structure

### Directory Mapping
- **Content generation** → Save to appropriate `MARKETING/`, `BLOG/`, `WEB/` subdirectories
- **Research** → Save to `COMPETITIVEANALYSIS/`, `PRODUCT/`
- **Sales materials** → Save to `SALES/`
- **AI configurations** → Save to `METAPROMPTS/`, `.claude/agents/`

### File Naming Conventions
Follow BILAN's existing patterns:
- Blog posts: `YYYY-MM-DD-post-title.md`
- Social media: `YYYY-MM-DD-platform-campaign.md`
- Research: `competitor-name-analysis-YYYY-MM-DD.md`

## Measuring Success

### Time Savings
Track how long tasks would take sequentially vs. in parallel

### Output Quality
Review generated content quality - aim for 80% ready, 20% refinement

### Consistency
Ensure background-generated content maintains brand voice

### Throughput
Measure content output increase week-over-week

## Troubleshooting

### Task Won't Start
- Check prompt clarity
- Verify file paths exist
- Ensure sufficient context provided

### Task Stuck
- Use `/tasks` to teleport in
- Check if waiting for input
- Provide additional context

### Quality Issues
- Refine prompts with more examples
- Point to specific brand guidelines
- Review and iterate in main session

## Examples in Action

### Example 1: Product Launch
**Goal:** Launch new flavor in 24 hours
**Tasks:**
1. Background: Generate product page copy
2. Background: Create 2-week social media calendar
3. Background: Write launch email sequence
4. Background: Generate FAQ entries
5. Background: Create VEO video scripts
**Result:** Complete launch package ready for review

### Example 2: Content Sprint
**Goal:** 10 blog posts in one session
**Tasks:**
- Spawn 10 background agents
- Each writes on different topic from content calendar
- All reference `PRODUCT/` for accuracy
- Save to `BLOG/src/content/blog/`
**Result:** Month of blog content in under 2 hours

### Example 3: Market Research
**Goal:** Comprehensive competitive analysis
**Tasks:**
1. Background: Analyze Competitor A
2. Background: Analyze Competitor B
3. Background: Analyze Competitor C
4. Background: Analyze Competitor D
5. Background: Analyze Competitor E
6. Background: Synthesize findings into strategy doc
**Result:** Strategic insights ready for decision-making

## Next Steps

1. Review task templates in `claude_code_task_templates.md`
2. Try a simple background task (e.g., single blog post)
3. Scale to parallel tasks (e.g., 3 social media posts)
4. Implement full workflow (e.g., complete campaign)
5. Optimize based on results

---

*For more information on Claude Code tasks, see: `03_RESOURCES/AI/CLAUDE/claude_code_2.1_features.md`*