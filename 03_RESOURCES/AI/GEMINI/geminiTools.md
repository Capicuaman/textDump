# Gemini CLI Tools

This document provides a list of available tools in the Gemini CLI, with brief explanations and usage examples.

---

### `list_directory`

Lists the names of files and subdirectories directly within a specified directory path.

**Example:**
```bash
list_directory(path='/Users/ideaopedia/Documents/geminiDemo')
```

---

### `read_file`

Reads and returns the content of a specified file. It can handle text and some binary formats like images and PDFs.

**Example:**
```bash
read_file(absolute_path='/Users/ideaopedia/Documents/geminiDemo/GEMINI.md')
```

---

### `search_file_content`

Searches for a regular expression pattern within the content of files in a specified directory.

**Example:**
```bash
search_file_content(pattern='Gemini CLI', path='/Users/ideaopedia/Documents/geminiDemo')
```

---

### `glob`

Finds files matching specific glob patterns.

**Example:**
```bash
glob(pattern='**/*.md', path='/Users/ideaopedia/Documents/geminiDemo')
```

---

### `replace`

Replaces text within a file. Requires significant context around the change to ensure precision.

**Example:**
```bash
replace(
  file_path='/Users/ideaopedia/Documents/geminiDemo/GEMINI.md',
  old_string='old text to be replaced',
  new_string='new text to replace with'
)
```

---

### `write_file`

Writes content to a specified file.

**Example:**
```bash
write_file(
  file_path='/Users/ideaopedia/Documents/geminiDemo/newFile.md',
  content='# New File\n\nThis is a new file created by Gemini.'
)
```

---

### `web_fetch`

Processes content from one or more URLs.

**Example:**
```bash
web_fetch(prompt='Summarize https://en.wikipedia.org/wiki/Gemini_(chatbot)')
```

---

### `read_many_files`

Reads content from multiple files specified by paths or glob patterns.

**Example:**
```bash
read_many_files(paths=['**/*.md'], exclude=['geminiTools.md'])
```

---

### `run_shell_command`

Executes a given shell command.

**Example:**
```bash
run_shell_command(command='ls -l', description='List files in the current directory')
```

---

### `save_memory`

Saves a specific piece of information or fact to long-term memory.

**Example:**
```bash
save_memory(fact='My favorite programming language is Python.')
```

---

### `google_web_search`

Performs a web search using Google Search.

**Example:**
```bash
google_web_search(query='latest news on Gemini CLI')
```

---

## Slash Commands

These commands are used to interact with the Gemini CLI directly.

*   `/memory`: Manage saved information.
    *   **Example:** `/memory` - Displays all saved memories.

*   `/stats`: Show session token usage and savings.
    *   **Example:** `/stats` - Shows token usage for the current session.

*   `/tools`: List available tools.
    *   **Example:** `/tools` - Lists all tools available to the AI.

*   `/mcp`: List configured Model Context Protocol (MCP) servers and their available tools.
    *   **Example:** `/mcp`

*   `/compress`: Replace the entire chat context with a summary to save tokens.
    *   **Example:** `/compress`

*   `/copy`: Copy the last response to the clipboard.
    *   **Example:** `/copy`

*   `/clear`: Clear the terminal screen and context.
    *   **Example:** `/clear`

*   `/extensions`: List active extensions.
    *   **Example:** `/extensions`

*   `/chat`: Manages conversations. The `/chat` command is a powerful feature that allows you to save and resume your conversations. This is useful when you are working on multiple tasks and want to switch between different contexts without losing your progress.
    *   **Subcommands:** 
        *   `save <tag>`: Saves your current conversation, including the entire history, to a session with a specific tag. You can think of a tag as a name for your saved session.
            *   **Example**: Imagine you are working on a new feature for your project. You can save your current conversation with the tag `feature-x`:
                ```
                /chat save feature-x
                ```
        *   `resume <tag>`: This command allows you to switch to a previously saved conversation. When you resume a session, the entire history of that conversation is loaded, and you can continue where you left off.
            *   **Example**: If you want to continue working on `feature-x` after working on something else, you can resume your session:
                ```
                /chat resume feature-x
                ```
        *   `list`: This command lists all the saved chat sessions, so you can easily see which sessions are available to resume.
            *   **Example**: To see all your saved sessions:
                ```
                /chat list
                ```

*   `/restore`: List or restore a project state checkpoint.
    *   **Example:** `/restore`

*   `/auth`: Change the current authentication method.
    *   **Example:** `/auth`

*   `/bug`: File an issue or bug report about the Gemini CLI.
    *   **Example:** `/bug`

*   `/help`: Display help information and available commands.
    *   **Example:** `/help`

*   `/theme`: Change the CLI's visual theme.
    *   **Example:** `/theme dark`

*   `/quit`: Exit the Gemini CLI.
    *   **Example:** `/quit`

*   `/ide`: Manage integration with an IDE.
    *   **Example:** `/ide`

*   `/settings`: Open the settings.json file for editing.
    *   **Example:** `/settings`

*   `/vim`: Toggle Vim mode for input editing.
    *   **Example:** `/vim`

*   `/init`: Generate a starting `GEMINI.md` context file for a project.
    *   **Example:** `/init`