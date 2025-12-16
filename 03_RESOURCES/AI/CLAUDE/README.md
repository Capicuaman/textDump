# Claude Documentation Hub

A comprehensive reference collection for working with Claude AI tools and services, including Claude.ai, Claude Code CLI, Claude API, and the Claude Agent SDK.

## Purpose

This directory serves as a centralized knowledge base for Claude-related documentation, organized for quick reference and practical application. It supports AI-assisted workflows by maintaining reusable patterns, step-by-step guides, and proven examples.

## Directory Structure

### `how-to/`
**Step-by-step guides and tutorials**

Store actionable, procedural documentation here:
- Setting up Claude Code CLI
- Configuring Claude API integrations
- Installing and managing MCP servers
- Writing custom slash commands
- Implementing Claude hooks
- Using Claude with other tools (n8n, Fabric, Ollama)
- Troubleshooting common issues

**Format:** Task-oriented guides with clear steps and expected outcomes

**Example filenames:**
- `setup_claude_code_cli.md`
- `create_custom_slash_command.md`
- `integrate_claude_with_n8n.md`

### `patterns/`
**Usage patterns and best practices**

Document recurring patterns and proven approaches:
- Prompt engineering techniques for Claude
- Conversation structuring strategies
- Project instruction patterns (CLAUDE.md templates)
- Multi-agent workflows
- Code review patterns
- Documentation generation patterns
- RAG system integration patterns

**Format:** Reusable templates and conceptual frameworks

**Example filenames:**
- `prompt_engineering_patterns.md`
- `project_instructions_template.md`
- `code_review_workflow.md`
- `rag_integration_pattern.md`

### `examples/`
**Real-world implementation examples**

Store concrete examples and case studies:
- Sample prompts with outputs
- Complete project configurations
- Working agent implementations
- API integration examples
- Successful automation workflows
- Before/after refactoring examples

**Format:** Actual code, configurations, and transcripts

**Example filenames:**
- `bilan_marketing_agent.md`
- `api_integration_example.py`
- `fabric_claude_pipeline.md`
- `conversation_transcript_analysis.md`

## Organization Guidelines

### What Goes Where?

| Content Type | Location | Example |
|-------------|----------|---------|
| "How do I...?" | `how-to/` | "How do I set up Claude Code hooks?" |
| "What's the best way to...?" | `patterns/` | "What's the best way to structure project instructions?" |
| "Show me a working example of..." | `examples/` | "Show me a working n8n + Claude integration" |

### Naming Conventions

- Use lowercase with underscores: `setup_claude_hooks.md`
- Be descriptive and specific: `create_rag_system_for_customer_support.md`
- Include version numbers when relevant: `claude_api_v2_migration.md`
- Date time-sensitive content: `claude_code_features_2025.md`

### Cross-Referencing

Create wiki-style links between related documents:
- Link how-to guides to relevant patterns
- Reference examples from patterns and guides
- Connect to related AI tools (Fabric, Ollama, n8n) in `../` directories

Example:
```markdown
For prompt engineering patterns, see [[patterns/prompt_engineering_patterns.md]]
Working example: [[examples/bilan_marketing_agent.md]]
Integration with Fabric: [[../fabric/claude_fabric_integration.md]]
```

## Integration with Other AI Tools

Claude documentation connects with:
- **Fabric** (`../fabric/`) - AI command framework integration
- **Ollama** (`../OLLAMA/`) - Local LLM comparison and hybrid workflows
- **n8n workflows** (`../../Workflow_Automation/n8n/`) - Automation pipelines
- **OpenCode** (`../../Knowledge_Management/OPENCODE/`) - Second brain integration

## Quick Start

1. **Need to do something?** Check `how-to/`
2. **Need a template or pattern?** Check `patterns/`
3. **Need to see it in action?** Check `examples/`

## Contributing Notes

When adding new documentation:
1. Choose the appropriate subdirectory
2. Use clear, descriptive filenames
3. Include frontmatter with date and topic tags (optional)
4. Create bidirectional links to related content
5. Keep content actionable and practical

## Related Resources

- **Claude Code CLI:** Official tool for AI-assisted development
- **Claude API:** Programmatic access to Claude models
- **Claude Agent SDK:** Framework for building custom agents
- **BILAN Project:** Extensive Claude integration example at `01_PROJECTS/BILAN/`

## Version Notes

- **Current Model:** Claude Sonnet 4.5 (claude-sonnet-4-5-20250929)
- **Latest Frontier Model:** Claude Opus 4.5 (claude-opus-4-5-20251101)
- **Knowledge Cutoff:** January 2025

---

**Last Updated:** December 16, 2025
