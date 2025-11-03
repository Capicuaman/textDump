# Tmux Plugins

This file provides a list of installed `tmux` plugins, with explanations on what they do and examples of their use.

## Plugin Management

### `tmux-plugins/tpm`

*   **Explanation**: The Tmux Plugin Manager. It's used to install, update, and remove `tmux` plugins.
*   **Usage**:
    *   `prefix + I`: Installs new plugins.
    *   `prefix + U`: Updates existing plugins.
    *   `prefix + alt + u`: Removes unused plugins.

## Core Plugins

### `tmux-plugins/tmux-sensible`

*   **Explanation**: Provides a set of sensible `tmux` options that many users prefer. It's a "set it and forget it" plugin that requires no configuration.
*   **Usage**: This plugin works automatically once installed.

## Navigation and Workflow

### `tmux-plugins/tmux-pain-control`

*   **Explanation**: Simplifies pane navigation and resizing.
*   **Usage**:
    *   `prefix + arrow key`: Navigate between panes.
    *   `prefix + >`: Resize the current pane.

### `tmux-plugins/tmux-open`

*   **Explanation**: Opens highlighted text in your default browser or editor.
*   **Usage**:
    1.  Highlight a file path or URL in a `tmux` pane.
    2.  Press `prefix + o` to open it.

## Clipboard and Session Management

### `tmux-plugins/tmux-yank`

*   **Explanation**: Allows you to copy text from `tmux` to the system clipboard.
*   **Usage**:
    1.  Enter copy mode (`prefix + [`).
    2.  Select the text you want to copy.
    3.  Press `y` to yank the selection to the system clipboard.

### `tmux-plugins/tmux-resurrect`

*   **Explanation**: Saves your `tmux` environment (sessions, windows, panes) and allows you to restore it after a restart.
*   **Usage**:
    *   `prefix + Ctrl-s`: Save the current `tmux` environment.
    *   `prefix + Ctrl-r`: Restore the last saved `tmux` environment.

### `tmux-plugins/tmux-continuum`

*   **Explanation**: A companion to `tmux-resurrect` that automatically saves your `tmux` environment every 15 minutes.
*   **Usage**: This plugin works automatically in the background once installed. You can customize the save interval in your `tmux.conf` file.
