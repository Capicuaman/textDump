# Gemini CLI Checkpoints: A Guide to Safe Experimentation

The Gemini CLI's checkpointing feature allows you to safely experiment with AI-powered modifications by automatically saving your project's state. This guide explains how it works, provides a step-by-step workflow, and highlights common use cases.

## How Checkpoints Work

1.  **Automatic Creation:** A checkpoint is automatically created whenever you approve a tool call that modifies your file system (e.g., `write_file`, `replace`).
2.  **Contents:** Each checkpoint captures:
    *   A Git snapshot of your project files in a hidden shadow repository (separate from your project's Git).
    *   The complete conversation history up to that point.
    *   The specific tool call that triggered the checkpoint.
3.  **Local Storage:** All checkpoint data is stored locally on your machine.
4.  **Enabling:** This feature is disabled by default. To enable it, you must add `"checkpointing": { "enabled": true }` to your `settings.json` file.
5.  **Restoring:** The `/restore` command allows you to revert to a previous checkpoint.

## Example Workflow

1.  **Enable Checkpointing:**
    You need to edit your `settings.json` file and add the following:
    ```json
    {
      "checkpointing": {
        "enabled": true
      }
    }
    ```

2.  **Make a Change (and trigger a checkpoint):**
    Let's say you ask the Gemini CLI to create and then modify a file. The modification will trigger a checkpoint.

    *First, create the file:*
    ```
    > write_file(file_path='test_file.txt', content='This is the original content.')
    ```

    *Then, modify it:*
    ```
    > replace(file_path='test_file.txt', old_string='This is the original content.', new_string='This is the new content after a change.')
    ```
    A checkpoint is automatically created before this `replace` operation is executed.

3.  **List Checkpoints:**
    If you decide you don't like the change or want to see previous states, you can list available checkpoints by running:
    ```
    /restore
    ```
    The CLI would then list available checkpoints, each with a unique `tool_call_id`. For example:
    ```
    Available checkpoints:
    - <tool_call_id_1> (Modified test_file.txt)
    - <tool_call_id_2> (Created test_file.txt)
    ```

4.  **Restore a Checkpoint:**
    To revert to a specific checkpoint, you would use the `/restore` command followed by the `tool_call_id` of the desired checkpoint. For instance, to go back to the state before the modification:
    ```
    /restore <tool_call_id_2>
    ```
    This action would:
    *   Revert `test_file.txt` to "This is the original content."
    *   Restore your conversation history to the point just before the modification.
    *   Re-propose the original `write_file` tool call (that created `test_file.txt`) for you to re-execute, modify, or dismiss.

## Common Practical Use Cases

*   **Experimenting with Refactoring:** When you want to try a complex refactoring suggested by the AI but are not sure if it will work or have unintended side effects. You can apply the change, run tests, and if something breaks, you can restore the checkpoint in a single step.

*   **Trying Different Solutions:** When you ask the AI for multiple ways to solve a problem and want to try each one without manually reverting the changes every time. You can create a checkpoint for each solution you try, making it easy to switch between them and compare the results.

*   **Recovering from Mistakes:** When you accidentally approve a change that breaks the code or has undesired consequences. Instead of manually undoing the changes, you can simply restore the last checkpoint.

*   **Auditing Changes:** When you want to review the exact state of the project and the conversation that led to a specific change. Checkpoints provide a complete snapshot of the project and the conversation history, making it easy to understand the context of a change.

*   **Safe Exploration of Unfamiliar Codebases:** When working on a new project, you can use checkpoints to safely explore and experiment with changes without fear of breaking anything permanently. This is especially useful when you are trying to understand how different parts of the codebase interact.
