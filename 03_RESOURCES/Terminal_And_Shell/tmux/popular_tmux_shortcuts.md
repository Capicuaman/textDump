## Most Popular and Useful Tmux Shortcuts

Here are some essential Tmux shortcuts that can greatly enhance your productivity:

### Session Management
- **Create a new session:** `tmux new -s session_name`
- **Attach to an existing session:** `tmux attach -t session_name`
- **Detach from the current session:** `Ctrl + b, d`
- **List existing sessions:** `tmux ls`
- **Kill a session:** `tmux kill-session -t session_name`

### Window Management
- **Create a new window:** `Ctrl + b, c`
- **Switch to the next window:** `Ctrl + b, n`
- **Switch to the previous window:** `Ctrl + b, p`
- **Rename the current window:** `Ctrl + b, ,`
- **Close the current window:** `Ctrl + b, &`

### Pane Management
- **Split the current pane vertically:** `Ctrl + b, %`
- **Split the current pane horizontally:** `Ctrl + b, "`
- **Navigate to the next pane:** `Ctrl + b, o`
- **Resize panes:** `Ctrl + b, arrow keys`
- **Close the current pane:** `Ctrl + b, x`

### Miscellaneous
- **Command prompt:** `Ctrl + b, :`
- **Search through scrollback buffer:** `Ctrl + b, [`, then use arrow keys to scroll
- **Clear pane:** `Ctrl + b, x`

### Configuration
For more customization, you can edit your `~/.tmux.conf` file to create your own shortcuts or change existing ones.

These shortcuts will help you navigate and utilize Tmux more effectively.