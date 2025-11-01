# Gemini CLI Features

The Gemini CLI is an open-source AI agent that integrates Google's Gemini model directly into the terminal, offering a wide range of capabilities for developers and other users. It's designed to streamline workflows by bringing AI assistance directly to the command line.

Here are the key features and capabilities of the Gemini CLI:

## Core AI Capabilities

*   **Code Understanding and Generation:**
    *   Analyze and summarize code architecture.
    *   Explain module roles and map code flows.
    *   Generate new applications from various inputs like PDFs, images, or sketches using multimodal capabilities.
*   **Bug Detection and Fixing:**
    *   Identifies bugs and proposes fixes for errors.
    *   Helps debug issues and troubleshoot with natural language prompts.
    *   Suggests changes and handles response handling in files.
*   **Refactoring and Editing:**
    *   Automatically improves and simplifies code with AI guidance.
*   **Test Generation:**
    *   Auto-generates `pytest` test cases to enhance reliability and CI confidence.
*   **Documentation Support:**
    *   Creates structured markdown documents, changelogs, and GitHub issue replies directly within the terminal.

## Automation and Integration

*   **Automation of Operational Tasks:**
    *   Automate tasks such as querying pull requests or managing complex rebases.
*   **Integration with External Tools:**
    *   Integrates with other tools and services, including databases and project management software, to automate entire workflows.
*   **Model Context Protocol (MCP) Support:**
    *   Extensible through built-in support for MCP servers, allowing interaction with external systems, APIs, custom scripts, and specialized workflows.
*   **GitHub Integration:**
    *   Can be integrated into GitHub workflows for automated code reviews, issue triage, and on-demand assistance by mentioning `@gemini-cli` in issues and pull requests.

## CLI and User Experience

*   **Built-in Tools:**
    *   Includes tools like `grep`, terminal access, file read/write operations, web search, and web fetch, enabling it to ground prompts with real-time, external context.
*   **Interactive Commands:**
    *   Allows for running complex, interactive commands like `vim`, `top`, or `git rebase -i` directly within the Gemini CLI, maintaining context within the terminal.
*   **Customization:**
    *   Users can customize prompts and instructions.
    *   Uses custom context files (GEMINI.md) to tailor its behavior for specific projects.

## Advanced Capabilities

*   **Multimodal Capabilities:**
    *   Beyond text and code, it integrates with Google's Veo and Imagen models for image or video generation.

## Availability and Access

*   The Gemini CLI is available in preview and offers a generous free tier for individual developers.
*   Provides access to Gemini 2.5 Pro with a 1M token context window.
*   Allows up to 60 requests per minute and 1,000 requests per day.
*   Can be authenticated using a personal Google account, an API Key, or Vertex AI.
