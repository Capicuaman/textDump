# Best Practices for Working with CLAUDE.md

The `CLAUDE.md` file is a powerful tool for guiding Claude Code and providing project-specific context. Here are best practices to get the most out of it.

## What is CLAUDE.md?

`CLAUDE.md` is a project-specific instruction file that customizes how Claude Code behaves when working in your repository. It serves as:

- **Project Context:** Explains your project's purpose, architecture, and conventions
- **Behavioral Guide:** Defines how Claude should approach tasks in this project
- **Memory System:** Stores important information Claude should always remember
- **Team Documentation:** Helps onboard new developers and maintain consistency

## Creating CLAUDE.md

### Quick Start

```bash
# In your project root
claude

> /init
# This creates a starter CLAUDE.md file
```

### File Location

Claude searches for `CLAUDE.md` files in this order:
1. Current directory (`.claude/CLAUDE.md`)
2. Parent directories (walking up the tree)
3. Project root
4. User home directory (`~/.claude/CLAUDE.md`)

**Recommendation:** Place project-specific `CLAUDE.md` in project root for team sharing.

## Structure and Organization

### Recommended Sections

```markdown
# Project Name

Brief one-liner description of what this project does.

## Project Overview

- **Purpose:** What problem does this solve?
- **Tech Stack:** Languages, frameworks, libraries
- **Architecture:** High-level structure (monorepo, microservices, etc.)

## Development Guidelines

### Coding Conventions
- Style guide (PEP 8, Airbnb, Google)
- Naming conventions
- File organization patterns
- Comment standards

### Testing Requirements
- Test frameworks used
- Coverage requirements
- Where tests should be located
- How to run tests

### Git Workflow
- Branch naming conventions
- Commit message format
- PR requirements
- Review process

## Important Files and Directories

- `src/` - Main source code
- `tests/` - Test files
- `docs/` - Documentation
- `config/` - Configuration files

## Key Architectural Decisions

Document important "why" decisions:
- Why microservices over monolith?
- Why PostgreSQL over MySQL?
- Why REST over GraphQL?

## Common Tasks

### Running the Project
```bash
npm install
npm run dev
```

### Running Tests
```bash
npm test
npm run test:coverage
```

### Building for Production
```bash
npm run build
```

## Claude-Specific Instructions

When working in this project, Claude should:
- Always run tests after making changes
- Follow TypeScript strict mode
- Prefer functional components over class components
- Use async/await instead of callbacks
- Write tests for all new features

## Troubleshooting

Common issues and solutions...
```

## Best Practices

### 1. Keep It Concise and Relevant

**Good:**
```markdown
## Coding Style
- Use TypeScript strict mode
- Prefer `const` over `let`
- All functions must have return type annotations
```

**Bad:**
```markdown
## Coding Style
TypeScript is a superset of JavaScript that adds static typing.
It was created by Microsoft in 2012... [long explanation]
Use strict mode, const, let, var, types, interfaces, classes...
```

### 2. Be Specific and Actionable

**Good:**
```markdown
## Testing
- Run `pytest tests/` before committing
- Minimum 80% code coverage required
- Place tests in `tests/` directory matching `src/` structure
- Example: `src/auth/login.py` → `tests/auth/test_login.py`
```

**Bad:**
```markdown
## Testing
We use tests. Make sure to test your code.
```

### 3. Provide Examples

**Good:**
```markdown
## Commit Messages
Follow conventional commits format:

```
feat(auth): add OAuth2 support
fix(api): resolve race condition in user creation
docs(readme): update installation instructions
```

**Bad:**
```markdown
## Commit Messages
Use good commit messages.
```

### 4. Define Claude's Persona

**Good:**
```markdown
## Claude's Behavior in This Project

You are a senior full-stack developer with expertise in:
- React and modern JavaScript/TypeScript
- Node.js backend development
- PostgreSQL database design
- AWS cloud infrastructure

When suggesting changes:
1. Always consider backward compatibility
2. Prioritize code readability over cleverness
3. Include error handling for edge cases
4. Write comprehensive tests
5. Ask for clarification if requirements are ambiguous
```

**Bad:**
```markdown
Be helpful and answer questions.
```

### 5. Document Domain-Specific Knowledge

**Good:**
```markdown
## Business Logic

### User Types
- **Free Users:** 10 requests/day, basic features
- **Pro Users:** 1000 requests/day, advanced features, priority support
- **Enterprise:** Unlimited, custom features, SLA

### Payment Flow
1. User selects plan on `/pricing`
2. Redirected to Stripe checkout
3. Webhook receives `checkout.session.completed`
4. Update user tier in database
5. Send welcome email via SendGrid
```

**Bad:**
```markdown
We have different user types and a payment system.
```

### 6. Update Regularly

**When to update:**
- New technology added to stack
- Architectural decisions change
- New coding conventions adopted
- Common issues discovered
- Team processes evolve

**How to update:**
```bash
# Quick additions during sessions
> #Always use UTC for all timestamps

# Manual editing
> /memory
# Opens CLAUDE.md in your editor
```

### 7. Version Control

**DO:**
- ✅ Commit CLAUDE.md to version control
- ✅ Share with team via git
- ✅ Review changes in PRs
- ✅ Keep synchronized across team

**DON'T:**
- ❌ Put secrets in CLAUDE.md (API keys, passwords)
- ❌ Include personal preferences that differ from team standards
- ❌ Make it so long Claude can't process it effectively

### 8. Use Project-Specific Terminology

**Good:**
```markdown
## Terminology

- **Widget:** A customizable UI component that users can add to their dashboard
- **Flow:** A series of automated actions triggered by an event
- **Recipe:** A pre-configured flow template
- **Connector:** Integration with a third-party service
```

This helps Claude use your team's language consistently.

### 9. Security and Sensitive Information

**DO Include:**
```markdown
## Security Guidelines

- Never log sensitive user data
- Always sanitize user input
- Use parameterized SQL queries
- Validate file uploads
- Files matching `.env*` should never be committed
```

**DON'T Include:**
```markdown
## API Keys
STRIPE_KEY=sk_live_... ❌ NEVER DO THIS
DATABASE_URL=postgresql://user:pass@... ❌ NEVER DO THIS
```

### 10. Onboarding New Team Members

A well-maintained CLAUDE.md serves as excellent onboarding documentation:

```markdown
## New Developer Setup

Welcome to the team! Here's how to get started:

1. **Prerequisites**
   - Node.js 18+
   - PostgreSQL 14+
   - Docker (for local services)

2. **First Time Setup**
   ```bash
   git clone repo-url
   cd project
   npm install
   cp .env.example .env  # Add your values
   npm run db:migrate
   npm run dev
   ```

3. **Your First Task**
   - Pick an issue labeled "good first issue"
   - Create a branch: `git checkout -b feature/issue-number`
   - Make changes, write tests
   - Push and create PR

4. **Getting Help**
   - Ask in #dev-help Slack channel
   - Tag @senior-dev for code review questions
   - Check our wiki: [wiki-url]
```

## Common Patterns

### Multi-Language Projects

```markdown
## Language-Specific Guidelines

### Python (Backend)
- Python 3.10+
- Follow PEP 8
- Use type hints
- Tests with pytest

### TypeScript (Frontend)
- TypeScript 5+
- React 18 with hooks
- Tests with Jest and React Testing Library
- Airbnb ESLint config

### SQL (Database)
- PostgreSQL 14+
- Use migrations (Alembic)
- Always add indexes for foreign keys
- Comment complex queries
```

### Monorepo Projects

```markdown
## Repository Structure

This is a monorepo with multiple packages:

- `packages/web/` - React web app
  - Entry: `src/App.tsx`
  - Tests: `src/**/__tests__/`

- `packages/api/` - Express API server
  - Entry: `src/index.ts`
  - Tests: `src/**/*.test.ts`

- `packages/shared/` - Shared utilities
  - Used by both web and api
  - Must have 100% test coverage

When making changes:
- If changing `shared/`, update both `web` and `api` if needed
- Run tests in all affected packages
- Update root `README.md` if adding new packages
```

### Open Source Projects

```markdown
## Contributing

This is an open source project. When helping with contributions:

- Follow our [Code of Conduct](CODE_OF_CONDUCT.md)
- Check [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines
- All code must be licensed under MIT
- Sign commits with GPG key
- Reference issue numbers in commits

### PR Requirements
- Tests pass (`npm test`)
- Linting passes (`npm run lint`)
- Documentation updated
- Changelog entry added
- Signed CLA (for first-time contributors)
```

## Template: Minimal CLAUDE.md

```markdown
# Project Name

One-line description.

## Stack
- Language/Framework
- Database
- Key libraries

## Conventions
- Style guide
- Testing approach
- Git workflow

## Running
```bash
# Install, run, test commands
```

## Claude Instructions
- Always [specific instruction]
- Never [specific restriction]
- Prefer [specific pattern] over [alternative]
```

## Template: Comprehensive CLAUDE.md

```markdown
# Project Name

Comprehensive description.

## Table of Contents
- [Overview](#overview)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Development](#development)
- [Testing](#testing)
- [Deployment](#deployment)
- [Claude Instructions](#claude-instructions)

## Overview
Purpose, goals, key features.

## Architecture
System design, data flow, component interaction.

## Tech Stack
### Frontend
- React 18
- TypeScript 5
- Tailwind CSS

### Backend
- Node.js 18
- Express
- PostgreSQL

### Infrastructure
- AWS (EC2, RDS, S3)
- Docker
- GitHub Actions

## Development
### Setup
[Detailed setup steps]

### Coding Standards
[Comprehensive standards]

### Project Structure
[File organization]

## Testing
### Unit Tests
[Framework, patterns, coverage]

### Integration Tests
[Approach, tools]

### E2E Tests
[Cypress/Playwright setup]

## Deployment
[Build, deploy, CI/CD process]

## Claude Instructions
[Detailed behavioral guidelines]

## Troubleshooting
[Common issues and solutions]

## Resources
- [Link to wiki]
- [Link to API docs]
- [Link to design system]
```

## Maintenance

### Review Schedule

**Monthly:**
- Review for outdated information
- Update tech stack versions
- Add newly discovered patterns

**After Major Changes:**
- New technology adopted
- Architecture refactored
- Team processes change

### Keep It Fresh

```bash
# Regular review
> Review our CLAUDE.md and suggest updates based on recent changes

# After learning something new
> Add to CLAUDE.md: When processing payments, always check for duplicate transactions

# Quick syntax
> #Always validate email addresses with regex pattern [pattern]
```

## Real-World Example

```markdown
# E-Commerce Platform

Headless e-commerce platform built with modern JAMstack architecture.

## Tech Stack
- **Frontend:** Next.js 14 (App Router), TypeScript, Tailwind
- **Backend:** Supabase (PostgreSQL + Auth + Storage)
- **Payments:** Stripe
- **CMS:** Sanity.io
- **Hosting:** Vercel
- **Email:** SendGrid

## Key Conventions

### File Naming
- Components: PascalCase (`UserProfile.tsx`)
- Utilities: camelCase (`formatCurrency.ts`)
- Tests: `*.test.tsx` or `*.spec.tsx`

### Component Structure
```tsx
// Always use this pattern
export function ComponentName({ prop1, prop2 }: Props) {
  // 1. Hooks
  const [state, setState] = useState()

  // 2. Computed values
  const computed = useMemo(() => ...)

  // 3. Effects
  useEffect(() => ...)

  // 4. Event handlers
  const handleClick = () => ...

  // 5. Render
  return <div>...</div>
}
```

### Testing
- Use React Testing Library, not Enzyme
- Test user behavior, not implementation
- Every component needs tests
- Aim for 80%+ coverage

### API Routes
- Location: `app/api/[route]/route.ts`
- Always validate input with Zod
- Use database transactions for multi-step operations
- Return proper HTTP status codes
- Log errors to Sentry

## Business Rules

### Product Pricing
- All prices stored in cents (no decimals)
- Support multiple currencies (USD, EUR, GBP)
- Tax calculated at checkout based on shipping address
- Discounts applied before tax

### Order Fulfillment
1. Order placed → `pending`
2. Payment captured → `paid`
3. Items shipped → `shipped`
4. Delivery confirmed → `delivered`
5. 30-day return window starts

### Inventory
- Real-time inventory tracking
- Reserve items during checkout (15-min timeout)
- Alert when stock < 10 units
- Auto-reorder when stock < 5 units

## Claude's Role

You are a senior full-stack engineer specializing in Next.js and Supabase.

When working on this project:

1. **Code Quality**
   - Prefer server components over client components
   - Use TypeScript strict mode
   - All async operations need error handling
   - Cache expensive operations

2. **Performance**
   - Images must use Next.js Image component
   - Lazy load non-critical components
   - Implement pagination for lists > 20 items
   - Use SWR for data fetching

3. **Security**
   - Never expose API keys in client code
   - Validate all user input
   - Use Row Level Security in Supabase
   - Sanitize user-generated content

4. **Before Committing**
   - Run `npm run lint`
   - Run `npm run type-check`
   - Run `npm test`
   - Verify no console.logs in production code

5. **Communication**
   - Ask clarifying questions if requirements unclear
   - Explain trade-offs for architectural decisions
   - Suggest improvements when you see opportunities
   - Flag potential issues early

## Common Commands

```bash
# Development
npm run dev          # Start dev server (localhost:3000)
npm run type-check   # TypeScript validation
npm run lint         # ESLint check
npm run lint:fix     # Auto-fix linting issues

# Testing
npm test             # Run all tests
npm test:watch       # Watch mode
npm test:coverage    # Coverage report

# Database
npm run db:push      # Push schema changes
npm run db:seed      # Seed test data
npm run db:reset     # Reset to clean state

# Production
npm run build        # Production build
npm run start        # Start production server
```

## Resources
- Design System: https://design.example.com
- API Docs: https://docs.example.com
- Figma: https://figma.com/project-link
- Slack: #dev-platform

---
Last Updated: 2025-12-16
```

## Conclusion

A well-maintained `CLAUDE.md` file:
- ✅ Improves Claude's understanding of your project
- ✅ Ensures consistent behavior across sessions
- ✅ Serves as living documentation for your team
- ✅ Accelerates onboarding for new developers
- ✅ Reduces repetitive explanations
- ✅ Maintains code quality and conventions

Invest time in creating a comprehensive `CLAUDE.md` — it pays dividends in development efficiency and team consistency.

---

**Last Updated:** December 16, 2025
