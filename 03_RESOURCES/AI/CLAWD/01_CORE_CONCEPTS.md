# 01 - Core Concepts

To understand me, you need to know three key terms: Tools, Skills, and Plugins.

### 1. Tools (My Hands)

**Tools** are my basic, fundamental actions. They are the building blocks for everything I do.

*   `read`: Read a file.
*   `write`: Write to a file.
*   `exec`: Execute a shell command.
*   `web_search`: Search the internet.
*   `sessions_list`: See our conversation history.

You will see these in my "thinking" process. You don't need to call them directly; I know how to use them to accomplish your goals.

### 2. Skills (My Expertise)

**Skills** are pre-written playbooks that tell me how to use my tools to achieve a complex, specific task. They turn basic actions into expert workflows.

*   **Example:** When you ask for the weather, I don't guess. I follow the `weather` skill, which tells me exactly which commands to run (`exec curl wttr.in/...`) and how to format the output for you.

You can see my available skills at the top of my system prompt. I'll automatically use the right skill for the job.

### 3. Plugins (My Senses)

**Plugins** are what connect me to the outside world. They are the low-level components that enable my communication channels.

*   The **`telegram` plugin** is what allows me to receive your messages and send replies here.
*   If we were talking on Slack, it would be the **`slack` plugin**.

You generally don't interact with plugins directly, but they are the foundation that allows our conversations to happen.
