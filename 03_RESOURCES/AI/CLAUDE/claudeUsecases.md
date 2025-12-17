# Claude Code Use Cases

This document explores practical use cases for Claude Code across different development scenarios, from simple tasks to complex workflows.

## Development Workflows

### 1. Understanding a New Codebase

**Scenario:** You've joined a new team or need to work on an unfamiliar project.

**Workflow:**
```bash
cd /path/to/new-project
claude

> Give me an overview of this codebase
> What's the main technology stack?
> Explain the project structure
> What are the key architectural patterns?
> Show me the entry point and trace the main execution flow
> Where are the most critical business logic files?
```

**Benefits:**
- Rapid understanding without reading every file
- Identifies key patterns and conventions
- Highlights important files to focus on
- Explains architectural decisions

---

### 2. Bug Fixing

**Scenario:** Tests are failing or users reported an error.

**Workflow:**
```bash
# Run tests to see failures
> Run the test suite and show me the results

# Paste error message
> I'm getting this error:
[error traceback]

# Claude analyzes and suggests fixes
> Investigate what's causing this in @src/auth/login.js

# Implement fix
> Implement your suggested fix and add a test to prevent regression

# Verify
> Run the tests again to confirm the fix works
```

**Benefits:**
- Quick root cause analysis
- Immediate fix suggestions
- Automated test generation
- Verification in one workflow

---

### 3. Feature Implementation

**Scenario:** Implementing a new feature from requirements.

**Workflow:**
```bash
> I need to add user profile editing functionality. Here's what users should be able to do:
- Edit name, email, bio
- Upload profile picture
- Change password
- Delete account

Create a plan for implementing this.

# Review plan
> Looks good. Let's start with the backend API endpoints.

# Implement backend
> Create the API routes in @src/api/profile/

# Add frontend
> Now create the React components for the profile edit form

# Add tests
> Generate unit tests for the API endpoints and component tests for the form

# Documentation
> Update the API documentation and add a section about profile management
```

**Benefits:**
- Structured implementation plan
- Consistent code across frontend/backend
- Automated test generation
- Documentation stays current

---

### 4. Code Refactoring

**Scenario:** Technical debt or code quality issues need addressing.

**Workflow:**
```bash
> Find all files in @src/ that use callbacks instead of async/await

> Refactor @src/api/users.js to use modern async/await patterns

> Ensure backward compatibility and that all tests still pass

> Find any other files that call these functions and update them

> Run the full test suite to verify nothing broke
```

**Benefits:**
- Identifies refactoring opportunities
- Maintains functionality while improving code
- Automatically updates dependent code
- Verifies changes with tests

---

### 5. Creating Pull Requests

**Scenario:** You've made changes and need to create a comprehensive PR.

**Workflow:**
```bash
> Show me what I've changed since main

> Analyze these changes and explain what they accomplish

> Stage all relevant files

> Create a detailed commit message explaining the changes

> Create a pull request with:
- Summary of changes
- Why these changes were needed
- How to test
- Any breaking changes
- Screenshots if applicable

> Push the branch and open the PR
```

**Benefits:**
- Comprehensive PR descriptions
- Clear change summaries
- Professional commit messages
- Includes testing instructions

---

## Testing and Quality Assurance

### 6. Test Generation

**Scenario:** Need comprehensive test coverage for existing code.

**Workflow:**
```bash
> Find all functions in @src/utils/ that don't have tests

> For each untested function, generate comprehensive unit tests including:
- Happy path scenarios
- Edge cases
- Error conditions
- Boundary values

> Place tests in @tests/utils/ matching the source structure

> Run the tests and fix any that fail

> Show me the test coverage report
```

**Benefits:**
- Rapid test creation
- Comprehensive edge case coverage
- Consistent test patterns
- Immediate feedback

---

### 7. Security Audit

**Scenario:** Need to identify security vulnerabilities.

**Workflow:**
```bash
> Perform a security audit of our authentication system @src/auth/

Look for:
- SQL injection vulnerabilities
- XSS vulnerabilities
- CSRF issues
- Weak password validation
- Insecure token handling
- Missing input validation

> For each issue found, explain the risk and suggest a fix

> Implement the fixes with tests that verify security
```

**Benefits:**
- Systematic security review
- Identifies common vulnerabilities
- Provides fix recommendations
- Adds security tests

---

### 8. Performance Optimization

**Scenario:** Application is slow and needs optimization.

**Workflow:**
```bash
> Analyze @src/api/products.js for performance issues

> Identify:
- N+1 query problems
- Missing database indexes
- Unnecessary computations
- Inefficient algorithms

> Suggest optimizations with estimated impact

> Implement the most critical optimizations

> Add benchmarks to verify improvements
```

**Benefits:**
- Identifies bottlenecks
- Quantifies impact
- Implements optimizations
- Measures improvements

---

## Documentation and Knowledge Transfer

### 9. API Documentation Generation

**Scenario:** API endpoints need documentation.

**Workflow:**
```bash
> Generate comprehensive API documentation for all endpoints in @src/api/

Include for each endpoint:
- HTTP method and path
- Request parameters (path, query, body)
- Request/response examples
- Error codes and meanings
- Authentication requirements
- Rate limits

Format as OpenAPI/Swagger specification

> Save to @docs/api-reference.yaml
```

**Benefits:**
- Consistent documentation format
- Includes all required information
- Industry-standard format
- Easy to maintain

---

### 10. Code Review Assistance

**Scenario:** Reviewing a teammate's pull request.

**Workflow:**
```bash
> Fetch PR #123 and show me the changes

> Review this PR for:
- Code quality and best practices
- Potential bugs or edge cases
- Performance implications
- Security concerns
- Test coverage
- Documentation needs

> Draft a review comment with:
- Positive feedback on good practices
- Constructive suggestions for improvements
- Questions about unclear logic
- Specific code suggestions
```

**Benefits:**
- Thorough code review
- Constructive feedback
- Catches issues early
- Maintains code quality

---

## DevOps and Automation

### 11. CI/CD Pipeline Setup

**Scenario:** Need to set up automated testing and deployment.

**Workflow:**
```bash
> Create a GitHub Actions workflow that:
- Runs on push to main and PRs
- Installs dependencies
- Runs linting
- Runs type checking
- Runs tests with coverage
- Builds the project
- Deploys to staging (main branch only)

> Save to @.github/workflows/ci.yml

> Test the workflow by creating a test PR
```

**Benefits:**
- Automated quality checks
- Consistent deployment process
- Catches issues before merge
- Reduces manual work

---

### 12. Database Migration

**Scenario:** Database schema needs to change.

**Workflow:**
```bash
> I need to add a user_preferences table with:
- user_id (foreign key to users)
- theme (light/dark)
- notifications_enabled (boolean)
- language (string)

Create a migration that:
- Adds the new table
- Adds indexes
- Sets up foreign key constraints
- Includes rollback logic

> Generate the migration in @migrations/

> Review the migration for safety (avoiding data loss)

> Run the migration on dev database

> Update the ORM models
```

**Benefits:**
- Safe schema changes
- Proper indexes and constraints
- Reversible migrations
- Updates related code

---

## Learning and Exploration

### 13. Technology Evaluation

**Scenario:** Considering adopting a new technology.

**Workflow:**
```bash
> I'm considering using GraphQL instead of REST for our API. Help me evaluate:

1. Search for current best practices for GraphQL in Node.js 2025
2. Compare pros/cons vs our current REST API
3. Estimate migration effort
4. Identify potential issues with our architecture
5. Suggest a proof-of-concept scope

> Create a proof-of-concept GraphQL endpoint for our user queries

> Document findings and recommendation
```

**Benefits:**
- Research backed by current information
- Practical evaluation
- Concrete code examples
- Informed decision making

---

### 14. Legacy Code Modernization

**Scenario:** Old codebase needs updating to modern standards.

**Workflow:**
```bash
> Analyze @src/legacy/ for outdated patterns:
- ES5 vs ES6+
- Callbacks vs Promises/Async-Await
- var vs const/let
- Class components vs Hooks (React)
- Deprecated APIs

> Create a modernization plan with priorities

> Start with the most impactful changes

> Refactor @src/legacy/authentication.js as a pilot

> Create before/after comparison showing improvements
```

**Benefits:**
- Systematic modernization
- Prioritized improvements
- Reduced technical debt
- Knowledge transfer

---

## Specialized Scenarios

### 15. Multi-Language Project Support

**Scenario:** Project uses multiple languages/frameworks.

**Workflow:**
```bash
> This is a full-stack project:
- Frontend: React/TypeScript in @frontend/
- Backend: Python/FastAPI in @backend/
- Infrastructure: Terraform in @infrastructure/

I need to add a new feature that touches all three:

1. Add a new API endpoint for user analytics (backend)
2. Create React component to display analytics (frontend)
3. Add required infrastructure resources (infrastructure)

Implement this feature across all three layers maintaining consistency

> Ensure types are synchronized between frontend and backend
> Generate comprehensive tests for each layer
```

**Benefits:**
- Coordinated changes across stack
- Type safety across boundaries
- Consistent patterns
- Comprehensive testing

---

### 16. Internationalization (i18n)

**Scenario:** Need to add multi-language support.

**Workflow:**
```bash
> Add internationalization support to this React app:

1. Set up i18next
2. Extract all hardcoded strings from @src/components/
3. Create translation files for English and Spanish
4. Update components to use translation keys
5. Add language switcher component

> Prioritize user-facing strings first

> Ensure dates, numbers, and currencies are localized properly
```

**Benefits:**
- Systematic i18n implementation
- Organized translation files
- Proper localization
- Reduced errors

---

### 17. Data Migration

**Scenario:** Need to migrate data between systems.

**Workflow:**
```bash
> We're migrating from MongoDB to PostgreSQL. Help me:

1. Analyze our MongoDB schemas in @src/models/
2. Design equivalent PostgreSQL schemas
3. Create migration scripts that:
   - Extract data from MongoDB
   - Transform to PostgreSQL format
   - Load into PostgreSQL
   - Validate data integrity

> Generate SQL schema
> Create Python migration script
> Add rollback capability
> Include data validation checks
```

**Benefits:**
- Safe data migration
- Validates integrity
- Reversible process
- Comprehensive logging

---

### 18. Accessibility Improvements

**Scenario:** Application needs accessibility enhancements.

**Workflow:**
```bash
> Audit @src/components/ for accessibility issues:

- Missing ARIA labels
- Keyboard navigation problems
- Color contrast issues
- Missing alt text
- Form accessibility
- Screen reader compatibility

> Fix all critical and high-priority issues

> Add accessibility tests

> Generate accessibility compliance report
```

**Benefits:**
- Systematic accessibility audit
- WCAG compliance
- Better user experience
- Automated testing

---

## Team Collaboration

### 19. Onboarding New Developers

**Scenario:** New team member needs to get up to speed.

**Workflow:**
```bash
> Create comprehensive onboarding documentation:

1. Project overview and architecture
2. Setup instructions for dev environment
3. Explanation of key modules and their interactions
4. Coding conventions and best practices
5. Testing guidelines
6. Deployment process
7. "Good first issue" suggestions

> Include code examples and diagrams where helpful

> Save to @docs/ONBOARDING.md
```

**Benefits:**
- Accelerated onboarding
- Consistent knowledge transfer
- Reduced mentoring burden
- Better code quality from start

---

### 20. Technical Debt Documentation

**Scenario:** Need to track and prioritize technical debt.

**Workflow:**
```bash
> Analyze the codebase for technical debt:

- Deprecated dependencies
- TODO/FIXME comments
- Code complexity hotspots
- Missing tests
- Outdated patterns
- Performance bottlenecks
- Security concerns

> Create a prioritized technical debt backlog with:
- Issue description
- Impact (high/medium/low)
- Effort estimate
- Suggested approach
- Related files

> Save to @docs/TECHNICAL_DEBT.md
```

**Benefits:**
- Visible technical debt
- Prioritized improvements
- Informed planning decisions
- Team alignment

---

## Productivity Patterns

### Quick Tasks

```bash
# Find all usages of a function
> Find all places that call authenticateUser()

# Rename variables across project
> Rename all instances of 'userId' to 'userID' in @src/

# Add logging
> Add debug logging to all API endpoints in @src/api/

# Update dependencies
> Check for outdated npm packages and suggest safe updates

# Generate sample data
> Create a JSON file with 100 sample user records for testing

# Convert formats
> Convert all our JSON config files to YAML
```

### One-Liners for Common Tasks

```bash
> add error handling to this function
> write a test for this component
> explain what this regex does
> optimize this SQL query
> fix all linting errors
> generate JSDoc for this file
> create a .gitignore for Node.js project
> write a commit message for these changes
```

---

## Real-World Workflow Example

**Complete Feature Development Flow:**

```bash
# 1. Planning
> I need to add email verification to our signup flow. Create an implementation plan.

# 2. Database
> Create a migration to add email_verified and verification_token fields to users table

# 3. Backend
> Implement the email verification endpoints:
- POST /api/auth/send-verification
- GET /api/auth/verify-email/:token

> Add email sending functionality using SendGrid

# 4. Frontend
> Create React components for:
- Email verification prompt
- Verification success/error pages
- Resend verification email button

# 5. Testing
> Generate comprehensive tests for:
- Email verification API endpoints
- Token generation and validation
- React components
- Email sending service

# 6. Documentation
> Update API documentation with the new endpoints
> Add user flow diagram for email verification

# 7. Review
> Create a comprehensive PR with all changes

# 8. Deployment
> Update environment variables documentation for SendGrid API key
> Create deployment checklist for this feature
```

---

## Tips for Effective Use

1. **Be Specific:** Instead of "improve this code", say "refactor this to use async/await and add error handling"

2. **Provide Context:** Reference files with `@`, include error messages, explain the goal

3. **Iterative Approach:** Start with planning, then implement, then test, then document

4. **Verify Changes:** Always run tests after changes, review diffs before committing

5. **Use Todo Lists:** For multi-step tasks, have Claude create and track a todo list

6. **Leverage Memory:** Use `#` to add important facts to CLAUDE.md for future sessions

7. **Ask for Explanations:** Don't just accept code, understand it: "explain why this works"

8. **Combine Tools:** Use web search for current info, then apply to your codebase

---

**Last Updated:** December 16, 2025
