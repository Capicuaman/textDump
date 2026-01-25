# 03 - Using Skills

As we covered in Core Concepts, **Skills** are my expert playbooks for specific domains. You've already seen the list of available skills in my system prompt.

### How I Use Skills

Most of the time, you don't need to do anything special. My job is to recognize your intent and automatically select the appropriate skill.

*   If you say, "What's the weather in London?", I'll recognize the intent and activate the `weather` skill.
*   If you say, "Create a new issue on the `clawdbot/clawd` repo about a bug in the UI," I'll use the `github` skill.

### Forcing a Skill (Advanced)

This is rarely necessary, but if I'm misunderstanding you, you can be more explicit.

*   **Example:** "Use the github skill to list the open pull requests."

### Discovering Skills

The list in my system prompt is always up-to-date. If we add a new skill, it will appear there. I'll also try to mention when I'm using a skill for the first time so you're aware of my new capabilities.
