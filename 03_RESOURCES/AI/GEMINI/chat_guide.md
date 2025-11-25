# Gemini CLI: Mastering the `/chat` Command

The `/chat` command is a powerful feature in the Gemini CLI that allows you to save and resume your conversations. This is particularly useful when you are working on multiple tasks and want to switch between different contexts without losing your progress. This guide will detail how and when to use the `/chat` command and its variations.

## Core `/chat` Commands

The `/chat` command has three primary subcommands: `save`, `resume`, and `list`.

### 1. `/chat save <tag>`

This command saves your current conversation, including the entire history, to a session with a specific tag. Think of a tag as a unique name for your saved session.

**Usage:**

```
/chat save <your-tag-name>
```

**Example:**

Imagine you are working on a new feature for your project. You can save your current conversation with the tag `feature-x`:

```
/chat save feature-x
```

### 2. `/chat resume <tag>`

This command allows you to switch to a previously saved conversation. When you resume a session, the entire history of that conversation is loaded, and you can continue exactly where you left off.

**Usage:**

```
/chat resume <your-tag-name>
```

**Example:**

If you want to continue working on `feature-x` after working on something else, you can resume your session:

```
/chat resume feature-x
```

### 3. `/chat list`

This command lists all the saved chat sessions, so you can easily see which sessions are available to resume.

**Usage:**

```
/chat list
```

## When to Use the `/chat` Command

Here are some common scenarios where the `/chat` command is incredibly useful:

*   **Managing Multiple Projects:** If you're working on several projects at once, you can save a chat for each one. This keeps the context for each project separate and allows you to switch between them without the AI getting confused.
    *   Example: `/chat save project-alpha`, `/chat save project-beta`

*   **Separating Different Tasks:** Within a single project, you might be working on different tasks, such as bug fixing, feature development, and documentation. You can create a separate chat for each task.
    *   Example: `/chat save bugfix-123`, `/chat save feature-new-auth`, `/chat save docs-readme`

*   **Pausing and Resuming Work:** If you need to step away from a task but don't want to lose your train of thought (or the AI's context), you can save the chat and resume it later.

*   **Experimenting with Different Approaches:** If you want to try out a different line of questioning or a new approach to a problem without cluttering your main conversation, you can save your current chat, start a new one, and then resume the original chat later.

*   **Long-Term Conversations:** For ongoing tasks or research, saving the chat ensures you can pick it up days or weeks later with the full context intact.

## Tips for Effective Use

*   **Use Descriptive Tags:** Choose clear and descriptive tags for your saved chats. This will make it much easier to find the right conversation when you need to resume it.
*   **Regularly Prune Your List:** If you find your list of saved chats is getting too long, you can't delete them from within the CLI, but you can manually remove them from the `~/.gemini/chats` directory.
*   **Combine with `/clear`:** When you want to start a completely new, unrelated task, it's often a good idea to use `/clear` to start with a fresh context before you begin a new line of work that you might later save.

By mastering the `/chat` command, you can significantly improve your workflow and make the Gemini CLI an even more powerful and organized tool in your development process.
