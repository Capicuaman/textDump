```markdown
# You've Been Using AI the Hard Way (Use This Instead)

**Channel:** NetworkChuck
**URL:** https://www.youtube.com/watch?v=MsQACpcuTkU
**Published:** 2025-10-28
**Length:** PT33M44S
**Views:** 1,093,780
**Likes:** 44,890

---

## 💡 Summary: Using AI in the Terminal (CLI)

The video argues that utilizing AI tools (like Gemini, Claude, and Codeex) directly in the terminal (Command Line Interface - CLI) is a "superpower" that makes users 10 times faster than using browser-based applications [00:00:04]. This approach provides unprecedented control over context, files, and project management.

### 🔑 Core Benefits of Terminal AI

The terminal approach resolves common issues with browser-based AI:

* **Superior Context Management:** Terminal tools explicitly show the context window remaining (e.g., "99% context left") [00:02:59]. This prevents the AI from losing its focus or "mind" after too many interactions [00:00:47].
* **Local File Access and Manipulation:** AI can read and write files directly on the local file system. This allows it to:
    * Compile research results into documents automatically (e.g., a `.md` file) [00:03:16].
    * Access and update local notes (like an Obsidian vault) [00:03:48].
    * Run Bash and Python scripts [00:03:52].
* **Project Organization:** By working in a project directory, all context, research, and decisions are stored in a single folder on the hard drive, making it easy to copy, share, or manage [00:19:37].

---

## 🛠️ AI Terminal Tools Demonstration

The video showcases three main tools, detailing their installation, features, and use cases:

### 1. Gemini CLI
* **Cost:** Has a **generous free tier** (uses a regular Gmail account) [00:01:22].
* **Installation:** `pip install google-gemini-cli` (or `brew install gemini-cli` for Mac) [00:01:50].
* **Context Feature:** The `/init` command creates a `gemini.md` file in the project directory that the AI loads as context for every new session, keeping the project organized and focused [00:04:14].

### 2. Claude Code (by Anthropic)
* **Cost:** Requires a **Claude Pro subscription** (starting at ~$20/month) [00:09:01].
* **Installation:** `npm install -g @anthropic/claude-cli` [00:09:15].
* **Key Features:**
    * **Agents:** The most powerful feature, allowing the user to create and delegate tasks to sub-agents (e.g., a "Home Lab Guru" or a "Brutal Critic") [00:08:46].
    * **Fresh Context:** Delegated agents receive a **fresh context window** (e.g., 200,000 tokens) for their task, preventing the main conversation's context from becoming bloated or biased [00:12:18].
    * **Output Styles:** Custom system prompts/personas can be created and adopted to control how Claude responds (e.g., "script writing output style") [00:16:32].

### 3. Open Code
* **Cost:** Open Source, allows use with Grock (free for a while), Claude Pro, or local models [00:26:36].
* **Installation:** `npm install -g opencode` [00:26:48].
* **Key Features:**
    * **Model Flexibility:** Can be configured to use local models like Llama 3 [00:27:37].
    * **Claude Pro Login:** Allows users to log in with their Claude Pro subscription, avoiding API key usage and usage-based payment [00:28:26].
    * **Session Management:** Features include sharing sessions via a URL (`/share`) and using a timeline to jump back to previous states in the conversation (`/timeline`) [00:29:01].

---

## 🧑‍💻 Advanced Workflow: Multi-AI Synchronization

The speaker demonstrates how to use **Claude, Gemini, and Codeex (ChatGPT's terminal tool)** simultaneously on the same project [00:18:04]:

1.  **Launch Together:** Open all AI tools in the same project directory (e.g., `coffee project`) [00:18:16].
2.  **Sync Context:** Ensure all context files (`gemini.md`, `claude.md`, and `agents.md`) are synchronized to give all AIs the same starting knowledge [00:18:29].
3.  **Delegate Roles:** Assign distinct tasks based on AI strengths (e.g., Claude for deep work, Codeex for high-level analysis) [00:19:04].
4.  **Project Closure Agent:** A custom Claude agent is used to end a work session by:
    * Creating a comprehensive summary of the day's work [00:21:27].
    * Updating and synchronizing all context files (`claude.md`, `gemini.md`, `agents.md`) [00:21:37].
    * **Committing the project to a GitHub repo** to track changes and maintain a history of all work and decisions [00:21:43].

---

**Security Intermission:** (Sponsored by Twingate)

For remote workers using terminal AI, traditional VPNs are dangerous because they grant the AI access to the entire internal network (servers, file servers). **Zero Trust** solutions like Twingate are recommended, which only grant access to explicitly authorized resources and can enforce device security checks (Trusted Profiles) before connection [00:06:40].
```