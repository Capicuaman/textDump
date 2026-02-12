# Model Context Protocol (MCP) - Power User Guide

**Last Updated:** February 11, 2026

## What is MCP?

Model Context Protocol (MCP) is Anthropic's **universal, open standard** for connecting AI systems with data sources and tools. Instead of building separate integrations for every tool, MCP provides a single protocol that works across all systems.

**Think of it as:** USB for AI integrations - one standard that connects everything.

---

## Why Use MCP?

### Without MCP (Traditional Approach)
- Build custom integrations for each tool
- Parse bash output and handle errors manually
- Repeat connection logic in every conversation
- High token usage from verbose outputs
- Brittle integrations that break with updates

### With MCP (Protocol Approach)
- ✅ Connect once, use everywhere
- ✅ Structured data instead of text parsing
- ✅ Persistent connections (lower latency)
- ✅ 30-50% token reduction
- ✅ Self-documenting tools
- ✅ Built-in error handling

---

## MCP for Your Use Cases

### Current Use Case: Clawdbot Migration
**Token usage:** ~75K tokens

**With SSH MCP Server:**
- Persistent SSH connection (no reconnecting each command)
- Structured command execution
- Built-in file transfer
- **Estimated savings:** ~30K tokens (40% reduction)

### Future Use Cases
1. **Daily Raspberry Pi monitoring** - Check status across all Pis
2. **Automated backups** - Sync data between devices
3. **Service management** - Restart services, check logs
4. **Infrastructure updates** - Update packages, deploy code
5. **Multi-device orchestration** - Coordinate tasks across network

---

## Available MCP Servers (2026)

### 🔥 Top SSH/Remote Management Servers

1. **[tufantunc/ssh-mcp](https://github.com/tufantunc/ssh-mcp)**
   - Exposes SSH control for Linux servers
   - Basic command execution
   - File operations

2. **[mixelpixx/SSH-MCP](https://github.com/mixelpixx/SSH-MCP)**
   - SSH + serial console access
   - VPS management
   - Network device support

3. **[shaike1/mcp-server-ssh](https://mcp.so/server/mcp-server-ssh)**
   - General-purpose SSH implementation
   - Password and key-based auth
   - Persistent sessions

4. **[balloonf/ssh_mcp](https://glama.ai/mcp/servers/@balloonf/ssh_mcp)**
   - Advanced SSH Session Manager
   - Multi-session support
   - Connection monitoring

5. **[lightfate/ssh-tools](https://www.pulsemcp.com/servers/lightfate-ssh-tools)**
   - Secure SSH interface
   - System administration focused
   - Persistent sessions throughout conversations

### 🏢 Enterprise/System Monitoring

6. **Red Hat MCP Server (RHEL)**
   - Intelligent log analysis
   - Performance monitoring
   - Anomaly detection
   - Configurable access controls

7. **Console Automation MCP**
   - 40+ tools for production use
   - Session management
   - Testing and monitoring
   - Background jobs

8. **DesktopCommander**
   - Local file management
   - Terminal commands
   - Remote SSH connections

### 📚 Official Resources

- **[Official MCP Servers Repo](https://github.com/modelcontextprotocol/servers)** - Anthropic's official collection
- **[Awesome MCP Servers](https://mcp-awesome.com/)** - 1200+ curated servers
- **[MCP Examples](https://modelcontextprotocol.io/examples)** - Official examples
- **[Claude Code MCP Docs](https://docs.anthropic.com/en/docs/claude-code/mcp)** - Integration guide

---

## Installation Guide

### 1. Check Current MCP Configuration

```bash
# macOS
cat ~/Library/Application\ Support/Claude/claude_desktop_config.json

# Linux
cat ~/.config/claude/claude_desktop_config.json
```

### 2. Install an SSH MCP Server

**Example: Installing ssh-mcp**

```bash
# Clone the repository
git clone https://github.com/tufantunc/ssh-mcp.git
cd ssh-mcp

# Install dependencies
npm install

# Build
npm run build
```

### 3. Configure in Claude Desktop

Edit your `claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "ssh": {
      "command": "node",
      "args": ["/path/to/ssh-mcp/build/index.js"],
      "env": {
        "SSH_HOST": "100.68.220.78",
        "SSH_USER": "capicuaman",
        "SSH_KEY_PATH": "/home/capicuaman/.ssh/id_rsa"
      }
    }
  }
}
```

### 4. Restart Claude Desktop

The MCP server will now be available in your Claude conversations.

---

## Custom Homelab MCP (Design)

See: [homelab-mcp-spec.md](./homelab-mcp-spec.md)

A custom MCP server designed specifically for your Tailscale network:

### Tools Provided

1. **`check_pi_status(hostname)`** - Get full Pi status in one call
2. **`sync_to_pi(source, dest, host)`** - Efficient file transfer
3. **`restart_service(service, host)`** - Service management
4. **`get_logs(service, host, lines)`** - Structured log retrieval
5. **`monitor_resources(host)`** - CPU, memory, disk stats
6. **`run_command(cmd, host)`** - Execute arbitrary commands
7. **`backup_clawdbot(host)`** - Automated backups
8. **`list_tailscale_devices()`** - All devices on network

### Benefits

- **Token savings:** 60-70% on remote operations
- **Persistent connections** to all Tailscale devices
- **Structured data** instead of parsing bash output
- **Built-in error handling** and retries
- **Type-safe** operations with validation

---

## MCP vs Skills vs Agents

Understanding when to use each:

### MCP Servers
**What:** External tools/data sources connected via protocol
**Best for:**
- Connecting to external systems (SSH, databases, APIs)
- Persistent connections
- Structured data access
- Low-level operations

**Example:** SSH MCP for remote server management

### Skills
**What:** Reusable workflows/procedures within Claude Code
**Best for:**
- Multi-step processes
- Decision trees
- Domain-specific workflows
- Documentation of procedures

**Example:** Your `/migrate-clawdbot` skill

### Agents
**What:** Autonomous AI entities that can use tools and skills
**Best for:**
- Complex, multi-turn tasks
- Tasks requiring exploration
- Tasks with unclear requirements
- Parallel execution

**Example:** Explore agent for codebase analysis

### When to Combine Them

**MCP + Skills:**
- Skill defines the workflow
- MCP provides the tools
- Example: Migration skill using SSH MCP

**MCP + Agents:**
- Agent makes decisions
- MCP provides capabilities
- Example: Monitoring agent using system MCP

**Skills + Agents:**
- Agent executes skills
- Skills provide structure
- Example: Maintenance agent running backup skills

**All Three:**
- Agent orchestrates
- Skills define procedures
- MCPs provide access
- Example: Infrastructure management system

---

## Token Optimization Comparison

### Example Task: Check Raspberry Pi Status

**Without MCP (Traditional Bash):**
```
Tokens: ~2,000
- SSH connection string: ~200 tokens
- Command execution: ~300 tokens
- Output parsing: ~500 tokens
- Error handling: ~400 tokens
- Result formatting: ~600 tokens
```

**With SSH MCP:**
```
Tokens: ~500
- Tool call: check_pi_status("raspberrypi3")
- Structured response: ~400 tokens
- Already formatted: ~100 tokens

Savings: ~75%
```

### Example Task: Full Migration

**Without MCP:**
- Total: ~75,000 tokens
- Commands: ~30,000 tokens
- Output parsing: ~15,000 tokens
- Documentation: ~25,000 tokens

**With SSH MCP:**
- Total: ~45,000 tokens
- Tool calls: ~10,000 tokens (structured)
- Documentation: ~25,000 tokens
- Error handling: ~10,000 tokens

**Savings: ~40% (30,000 tokens)**

---

## Building Your Own MCP Server

See: [custom-mcp-guide.md](./custom-mcp-guide.md)

Quick overview:

### 1. Choose Your Stack

**Node.js/TypeScript (Recommended)**
```bash
npm install @modelcontextprotocol/sdk
```

**Python**
```bash
pip install mcp
```

### 2. Define Your Tools

```typescript
server.tool(
  "check_pi_status",
  {
    hostname: z.string()
  },
  async ({ hostname }) => {
    // Implementation
  }
);
```

### 3. Handle Connections

```typescript
const transport = new StdioServerTransport();
await server.connect(transport);
```

### 4. Test Locally

```bash
npm run build
node build/index.js
```

### 5. Configure in Claude

Add to `claude_desktop_config.json`

---

## Best Practices

### DO ✅

1. **Use MCP for repetitive operations**
   - Daily checks
   - Regular syncs
   - Monitoring

2. **Structure your data**
   - Return JSON, not raw text
   - Include metadata
   - Provide clear error messages

3. **Handle errors gracefully**
   - Retry logic
   - Timeouts
   - Fallback options

4. **Keep connections persistent**
   - Reuse SSH sessions
   - Pool database connections
   - Cache when appropriate

5. **Document your tools**
   - Clear descriptions
   - Example usage
   - Parameter validation

### DON'T ❌

1. **Don't use MCP for one-time tasks**
   - Installation scripts
   - Initial setup
   - Rare operations

2. **Don't make MCPs too complex**
   - Keep tools focused
   - Separate concerns
   - Avoid business logic

3. **Don't ignore security**
   - Validate inputs
   - Use least privilege
   - Rotate credentials

4. **Don't return huge payloads**
   - Paginate results
   - Stream large data
   - Summarize when possible

---

## MCP Server Discovery

### Official Directories

1. **[Awesome MCP Servers](https://mcp-awesome.com/)** - 1200+ servers, quality-verified
2. **[PulseMCP](https://www.pulsemcp.com/)** - Curated directory with ratings
3. **[Glama MCP](https://glama.ai/mcp/servers)** - Search and discover servers
4. **[MCP Servers Org](https://mcpservers.org/)** - Community directory
5. **[LobeHub MCP](https://lobehub.com/mcp)** - Server marketplace

### Search by Use Case

- **SSH/Remote:** Search "ssh mcp", "remote mcp"
- **Databases:** Search "postgres mcp", "mongodb mcp"
- **Cloud:** Search "aws mcp", "gcp mcp", "azure mcp"
- **Monitoring:** Search "monitoring mcp", "observability mcp"
- **Dev Tools:** Search "github mcp", "gitlab mcp", "docker mcp"

---

## Integration with Your Workflow

### Current Setup: Skills + Bash
```
User Request → Skill File → Bash Commands → Parse Output → Response
```

### Future Setup: Skills + MCP
```
User Request → Skill File → MCP Tool Calls → Structured Data → Response
```

### Migration Path

**Phase 1: Add SSH MCP** (Week 1)
- Install SSH MCP server
- Test with simple commands
- Compare token usage

**Phase 2: Update Skills** (Week 2)
- Modify migration skill to use MCP
- Update monitoring commands
- Document savings

**Phase 3: Create Custom MCP** (Week 3-4)
- Build Homelab MCP
- Add Tailscale integration
- Add Raspberry Pi specific tools

**Phase 4: Expand** (Ongoing)
- Add more devices
- Create orchestration skills
- Build monitoring dashboards

---

## Resources

### Official Documentation
- [MCP Specification](https://modelcontextprotocol.io/) - Official protocol spec
- [Claude Code MCP Guide](https://docs.anthropic.com/en/docs/claude-code/mcp) - Integration docs
- [MCP SDK Docs](https://github.com/modelcontextprotocol/sdk) - TypeScript/Python SDKs

### Community
- [MCP Discord](https://discord.gg/anthropic) - Official community
- [MCP GitHub Discussions](https://github.com/modelcontextprotocol/servers/discussions) - Q&A
- [r/ClaudeAI](https://reddit.com/r/ClaudeAI) - Reddit community

### Tutorials
- [Building Your First MCP Server](https://docs.anthropic.com/en/docs/build-with-claude/mcp) - Official tutorial
- [Top 10 MCP Servers 2026](https://dasroot.net/posts/2026/01/top-10-mcp-servers-2026/) - Curated list
- [Best MCP Servers Guide](https://cyberpress.org/best-mcp-servers/) - Comprehensive guide

---

## Next Steps

1. ✅ **Read this guide** - Understand MCP fundamentals
2. 📖 **Review [homelab-mcp-spec.md](./homelab-mcp-spec.md)** - Custom server design
3. 🔧 **Try an SSH MCP** - Install and test
4. 📊 **Measure token savings** - Compare before/after
5. 🏗️ **Build custom MCP** - If savings justify it
6. 📚 **Update skills** - Integrate MCP tools
7. 🚀 **Expand** - Add more devices and capabilities

---

*Created: February 11, 2026*
*Focus: Power user capabilities for skills and agents*
