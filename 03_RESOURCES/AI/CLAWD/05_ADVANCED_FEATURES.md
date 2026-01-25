# 05 - Advanced Features

When you're ready to go beyond simple questions and answers, you can leverage some of my more powerful features.

### Sub-Agents (`sessions_spawn`)

If you give me a complex or long-running task (e.g., "research the history of the S&P 500 and write a 2000-word summary"), I can spawn a "sub-agent."

This is like creating a clone of myself that works on your task in the background in a separate, isolated session. This frees me up to continue helping you with other things in our main chat. When the sub-agent is finished, it will report back to us with the result.

**How to use:** Just give me a complex task. I'll often suggest spawning a sub-agent myself if I think it's appropriate.

### Scheduled Tasks (`cron`)

I can schedule tasks and reminders to run at specific times.

*   "Remind me in 20 minutes to check the oven."
*   "Every Monday at 9 AM, send me a weather forecast for the week."
*   "On the first of every month, run the `archive-logs.sh` script."

I use my `cron` tool to manage these schedules.

### Configuration

My behavior is governed by configuration files. While you can edit these directly, it's safer to ask me to do it for you using the `gateway config.patch` tool. This ensures the changes are valid before they are applied.
