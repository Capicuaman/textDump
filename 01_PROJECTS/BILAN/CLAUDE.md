# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

BILAN is a **content and knowledge management repository** for an electrolyte powder brand, NOT a traditional software project. This is a business documentation system organized around Sales, Marketing, Product, and Business functions. The repository contains marketing strategies, sales playbooks, competitive analysis, product information, and AI-ready content systems.

## Repository Architecture

### Core Business Structure

```
BILAN/
├── BUSINESS/          # Financial, pricing, and business strategy
├── SALES/             # 12-part sales playbook and e-commerce setup
├── MARKETING/         # Campaigns, social media, RAG system, VEO prompts
├── PRODUCT/           # Product science and ingredient documentation
└── COMPETITIVEANALYSIS/ # Competitor research (LMNT, SALTT)
```

### Technical/Content Systems

```
├── BLOG/              # Jekyll static site (Carte Noire theme)
├── WEB/               # Website materials and SEO strategies
├── website/           # Static HTML sites (index.html, harumi.html, ventas.html)
├── RAG/               # FAQ database for Retrieval-Augmented Generation
├── METAPROMPTS/       # AI agent instructions and content generation prompts
└── PACKAGING/         # Product label designs (JSON format)
```

### Key Data Structures

- **Marketing OOP Framework** (`MARKETING/OOP/`): Object-oriented marketing structure with base classes, personas, and inheritance patterns
- **FAQ/RAG System** (`MARKETING/RAG/faq.json`): Structured Q&A database for LLM-based customer support
- **VEO Video Prompts** (`MARKETING/VEO/`): AI video generation prompts in JSON format
- **Social Media Blueprints** (`MARKETING/SOCIAL-MEDIA/`): WhatsApp templates, video scripts, status formulas

## Important Files

- `readme.md` - Main project overview and directory guide
- `GEMINI.md` - Comprehensive project documentation
- `nextSteps.md` - Development roadmap and future initiatives
- `consolidated_bilan_report.md` - Executive summary
- `consolidated_sales_manual.md` - Complete sales playbook
- `BUSINESS/bilanMarketingDosier.json` - Detailed marketing plan
- `MARKETING/RAG/faq.json` - FAQ database (hydration, electrolytes, sodium conditions)
- `SALES/1_Introduction_Sales_Playbook.md` through `12_Appendix.md` - 12-part sales guide

## No Traditional Development Setup

**This repository has NO build system, package managers, or test frameworks.**

- No `package.json`, `requirements.txt`, `Gemfile`, or similar
- No compilation, bundling, or testing infrastructure
- No CI/CD pipelines
- Primary formats: Markdown (70+ files), JSON (data), HTML/CSS (static sites)

## Jekyll Blog (Static Site Only)

The blog uses Jekyll with the Carte Noire theme:

**Location:** `BLOG/jekyll/carte-noire-gh-pages/`

**Configuration:** `_config.yml`
- Markdown: kramdown with GitHub Flavored Markdown (GFM)
- Syntax highlighting: Rouge
- URL: richicoffe.com (legacy, may need updating for BILAN brand)

**To work with the blog:**
```bash
cd BLOG/jekyll/carte-noire-gh-pages/
# Note: No Gemfile present - Jekyll dependencies not configured
# If needed, initialize with: bundle init && bundle add jekyll
```

## Content Management Patterns

### When Adding Marketing Content
1. Place campaign-specific content in `MARKETING/campaigns/[campaign-name]/`
2. Add social media templates to `MARKETING/SOCIAL-MEDIA/`
3. Update FAQ system in `MARKETING/RAG/faq.json` for customer-facing information
4. Add AI prompts to `METAPROMPTS/` or `MARKETING/VEO/` for video generation

### When Updating Product Information
1. Technical/science content goes in `PRODUCT/`
2. Update `RAG/` directory with any FAQ-worthy product information
3. Maintain consistency with existing files like `whatareElectrolytes.md`, `naturalFlavors.md`

### When Adding Sales Materials
1. Follow the 12-part playbook structure in `SALES/`
2. E-commerce platform documentation goes in `SALES/ECOMMERCE/`
3. Update `consolidated_sales_manual.md` for comprehensive reference

## Multi-Language Support

Content exists in both English and Spanish:
- Spanish FAQ facts: `MARKETING/RAG/hechos_*.json`
- Spanish glossary: `MARKETING/RAG/glosario.md`
- Bilingual marketing materials throughout the repository

When creating new content, consider whether Spanish versions are needed based on the target audience.

## Git Workflow

**Current branch:** `main` (primary development branch)

Recent activity shows:
- Video content expansion (VEO AI prompts)
- Medical/educational content additions
- Folder reorganization (MARKETING → SALES migration)
- Multi-platform e-commerce setup

When committing, follow existing patterns:
- Descriptive commit messages
- Group related content changes
- Use lowercase for commit messages (per recent history)

## AI Integration Points

This repository is designed for AI-driven operations:

1. **RAG System:** `MARKETING/RAG/faq.json` and `RAG/` directory content can be used for retrieval-augmented generation in customer support
2. **Prompting Framework:** `METAPROMPTS/` contains agent instructions for various business functions
3. **VEO Prompts:** `MARKETING/VEO/` JSON files for AI video generation
4. **OOP Marketing:** `MARKETING/OOP/` provides structured marketing objects for programmatic content generation

## Common Tasks

### View Untracked Files
```bash
git status
```

### Search for Content
```bash
# Use Grep tool for content search within files
# Use Glob tool for finding files by pattern
```

### Add New Campaign
1. Create directory: `MARKETING/campaigns/[campaign-name]/`
2. Add campaign materials (markdown, JSON, images)
3. Update relevant consolidated documents if needed
4. Consider adding FAQ entries to RAG system

### Update Product Science Content
1. Edit or create markdown files in `PRODUCT/`
2. Update `RAG/` with FAQ-worthy information
3. Ensure scientific accuracy with references

### Modify Sales Playbook
1. Edit specific section in `SALES/[1-12]_*.md`
2. Update `consolidated_sales_manual.md` to reflect changes
3. Consider impact on e-commerce documentation in `SALES/ECOMMERCE/`

## Content Organization Principles

1. **Separation of Concerns:** Business, Sales, Marketing, and Product are distinct domains
2. **Modularity:** Campaigns, prompts, and content are self-contained units
3. **AI-Ready Data:** Structured JSON formats enable programmatic access
4. **Multi-Channel:** Content supports web, social media, podcast, blog, app, and e-commerce
5. **Documentation-First:** Markdown documentation is the primary artifact

## Notes for AI Agents

- This is a **business intelligence repository**, not a codebase requiring compilation
- Focus on content accuracy, consistency, and organization
- Respect the existing taxonomy and file structure
- When generating new content, match the tone and style of existing materials
- Always validate scientific claims in product documentation
- Consider both English and Spanish audiences
- Maintain the OOP-inspired structure in marketing frameworks
