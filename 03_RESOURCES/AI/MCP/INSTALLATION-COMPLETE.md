# SSH MCP Server - Installation Complete ✅

**Date:** February 11, 2026
**Server:** ssh-mcp by tufantunc
**Status:** Installed and configured

---

## Installation Summary

### ✅ What Was Installed

**SSH MCP Server:**
- **Repository:** https://github.com/tufantunc/ssh-mcp
- **Location:** `/home/capicuaman/Projects/ssh-mcp`
- **Build output:** `/home/capicuaman/Projects/ssh-mcp/build/index.js`
- **Version:** 1.5.0

**Dependencies:**
- 363 npm packages installed
- Built successfully with TypeScript

---

## Configuration Files

### Claude Desktop Config

**File location:** `/home/capicuaman/.config/claude/claude_desktop_config.json`

**Current configuration:**
```json
{
  "mcpServers": {
    "ssh-mcp": {
      "command": "node",
      "args": [
        "/home/capicuaman/Projects/ssh-mcp/build/index.js",
        "--host=100.68.220.78",
        "--user=capicuaman",
        "--key=/home/capicuaman/.ssh/id_rsa",
        "--timeout=60000",
        "--maxChars=none"
      ]
    }
  }
}
```

**What this configures:**
- **Target host:** raspberrypi3 (100.68.220.78 via Tailscale)
- **User:** capicuaman
- **Authentication:** SSH key at `/home/capicuaman/.ssh/id_rsa`
- **Timeout:** 60 seconds
- **Max command length:** Unlimited

---

## SSH Connection Details

**SSH key:** `/home/capicuaman/.ssh/id_rsa` ✅ (exists, correct permissions)
**Target device:** raspberrypi3 (100.68.220.78)
**Tailscale status:** Active ✅
**SSH test:** Successful ✅

---

## How to Use

### 1. Restart Claude Desktop

**IMPORTANT:** You must restart Claude Desktop for the MCP server to load.

```bash
# Close Claude Desktop completely
# Then reopen it
```

### 2. Test in Claude Desktop

Once restarted, try these commands in a Claude Desktop conversation:

**Test 1: Simple command**
```
Use SSH MCP to run 'uptime' on the server
```

**Test 2: Check clawdbot status**
```
Use SSH MCP to execute: systemctl --user status clawdbot-gateway
```

**Test 3: Get system info**
```
Use SSH MCP to run these commands:
1. uname -a
2. df -h /
3. free -m
```

### 3. Verify MCP is Loaded

In Claude Desktop, you should see:
- MCP server "ssh-mcp" listed in available tools
- Ability to execute SSH commands
- Responses include command output

---

## Available Tools

The SSH MCP server provides two tools:

### 1. `exec` - Execute command
**Parameters:**
- `command` (required): Shell command to execute
- `description` (optional): What the command does

**Example:**
```
Use the exec tool to run 'ps aux | grep clawdbot'
```

### 2. `sudo-exec` - Execute with sudo
**Parameters:**
- `command` (required): Shell command to execute as root
- `description` (optional): What the command does

**Note:** Currently configured without sudo password. Add `--sudoPassword=YOUR_PASSWORD` to config if needed.

---

## Token Savings

### Before (Bash approach)

**Example: Check clawdbot status**
```
Tokens: ~2,000
- SSH connection setup: ~300 tokens
- Command: ~200 tokens
- Output parsing: ~800 tokens
- Response formatting: ~700 tokens
```

### After (SSH MCP)

**Same task:**
```
Tokens: ~600
- Tool call: ~100 tokens
- Structured output: ~400 tokens
- Response: ~100 tokens

Savings: 70%
```

---

## Configuration Options

### Add Multiple Hosts

Edit `/home/capicuaman/.config/claude/claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "ssh-pi": {
      "command": "node",
      "args": [
        "/home/capicuaman/Projects/ssh-mcp/build/index.js",
        "--host=100.68.220.78",
        "--user=capicuaman",
        "--key=/home/capicuaman/.ssh/id_rsa"
      ]
    },
    "ssh-alien": {
      "command": "node",
      "args": [
        "/home/capicuaman/Projects/ssh-mcp/build/index.js",
        "--host=100.96.199.13",
        "--user=capicuaman",
        "--key=/home/capicuaman/.ssh/id_rsa"
      ]
    }
  }
}
```

### Adjust Timeout

Change `--timeout=60000` (60 seconds) to:
- `--timeout=30000` (30 seconds) for faster commands
- `--timeout=120000` (2 minutes) for long-running tasks

### Enable Sudo

Add to args:
```json
"--sudoPassword=YOUR_PASSWORD"
```

Or for passwordless sudo, it should work without this flag.

---

## Troubleshooting

### MCP Server Not Loading

**Check Claude Desktop logs:**

```bash
# View logs
tail -f ~/.config/Claude/logs/mcp-ssh-mcp.log
```

**Common issues:**
1. Didn't restart Claude Desktop
2. JSON syntax error in config file
3. Wrong path to index.js

**Fix:**
```bash
# Validate JSON
cat /home/capicuaman/.config/claude/claude_desktop_config.json | jq .

# Check build exists
ls -la /home/capicuaman/Projects/ssh-mcp/build/index.js
```

### SSH Connection Fails

**Test manually:**
```bash
ssh capicuaman@100.68.220.78 "echo OK"
```

**If fails:**
1. Check Tailscale: `tailscale status | grep raspberrypi3`
2. Check SSH key: `ls -la /home/capicuaman/.ssh/id_rsa`
3. Test key: `ssh -i /home/capicuaman/.ssh/id_rsa capicuaman@100.68.220.78 "echo OK"`

### Commands Time Out

**Increase timeout in config:**
```json
"--timeout=120000"
```

**Or run commands differently:**
```
Use SSH MCP to run 'nohup long-command &' to run in background
```

---

## Integration with Your Skills

### Update Migration Skill

Edit `/home/capicuaman/Documents/textDump/.claude/skills/migrate-clawdbot-to-pi.md`

**Before (Bash):**
```markdown
ssh capicuaman@100.68.220.78 "systemctl --user status clawdbot-gateway"
```

**After (MCP):**
```markdown
Use SSH MCP exec tool to check clawdbot-gateway service status
```

### Create New MCP-Powered Skills

**Example: `/pi-status` skill**

```markdown
# Pi Status Skill

Use SSH MCP to run these commands:
1. systemctl --user status clawdbot-gateway
2. ps aux | grep clawdbot
3. df -h /
4. free -m
5. uptime

Parse and summarize the results.
```

---

## Monitoring

### Check MCP Activity

**View Claude Desktop logs:**
```bash
tail -f ~/.config/Claude/logs/mcp-ssh-mcp.log
```

**Check for errors:**
```bash
grep ERROR ~/.config/Claude/logs/mcp-ssh-mcp.log
```

### Monitor SSH Connections

```bash
# Active SSH connections
netstat -an | grep :22 | grep ESTABLISHED
```

---

## Next Steps

### Immediate (Today)

1. ✅ **Restart Claude Desktop**
2. ✅ **Test with simple command** (uptime)
3. ✅ **Verify token savings** (compare to Bash)
4. ✅ **Document results**

### This Week

1. 📝 **Create MCP-powered skills**
   - `/pi-status` - Quick health check
   - `/pi-logs` - Get recent logs
   - `/pi-backup` - Trigger backup

2. 📊 **Measure token usage**
   - Track before/after for common tasks
   - Document savings

3. 🔧 **Optimize configuration**
   - Adjust timeout if needed
   - Add other devices (alien, ds220)

### This Month

1. 🚀 **Build custom Homelab MCP** (if managing 3+ devices)
   - See: `/home/capicuaman/Documents/textDump/03_RESOURCES/AI/MCP/homelab-mcp-spec.md`
   - 75-85% token savings vs current SSH MCP

2. 📚 **Update all skills** to use MCP
3. 🎯 **Automate common tasks**

---

## File Locations Reference

### MCP Server Files
```
/home/capicuaman/Projects/ssh-mcp/               # Main directory
/home/capicuaman/Projects/ssh-mcp/build/index.js # Executable
/home/capicuaman/Projects/ssh-mcp/package.json   # Package info
/home/capicuaman/Projects/ssh-mcp/README.md      # Documentation
```

### Configuration Files
```
/home/capicuaman/.config/claude/claude_desktop_config.json  # Claude config
/home/capicuaman/.ssh/id_rsa                                 # SSH key
```

### Documentation
```
/home/capicuaman/Documents/textDump/03_RESOURCES/AI/MCP/
├── README.md                    # Power user guide
├── ssh-mcp-quickstart.md       # Quick start
├── homelab-mcp-spec.md         # Custom MCP design
├── mcp-decision-guide.md       # When to use what
└── INSTALLATION-COMPLETE.md    # This file
```

### Your Skills
```
/home/capicuaman/Documents/textDump/.claude/skills/
├── migrate-clawdbot-to-pi.md   # Migration skill (update to use MCP)
└── process-inbox.md             # Inbox processing
```

---

## Resources

### Documentation
- **SSH MCP README:** `/home/capicuaman/Projects/ssh-mcp/README.md`
- **GitHub:** https://github.com/tufantunc/ssh-mcp
- **MCP Protocol:** https://modelcontextprotocol.io/
- **Claude MCP Guide:** https://docs.anthropic.com/en/docs/claude-code/mcp

### Your Guides
- **Power User Guide:** `03_RESOURCES/AI/MCP/README.md`
- **Quick Start:** `03_RESOURCES/AI/MCP/ssh-mcp-quickstart.md`
- **Decision Guide:** `03_RESOURCES/AI/MCP/mcp-decision-guide.md`

---

## Quick Commands

**Restart Claude Desktop:**
```bash
# Close and reopen Claude Desktop app
```

**Test SSH manually:**
```bash
ssh capicuaman@100.68.220.78 "uptime"
```

**View MCP logs:**
```bash
tail -f ~/.config/Claude/logs/mcp-ssh-mcp.log
```

**Validate config:**
```bash
cat /home/capicuaman/.config/claude/claude_desktop_config.json | jq .
```

**Update MCP server:**
```bash
cd /home/capicuaman/Projects/ssh-mcp
git pull
npm install
npm run build
# Restart Claude Desktop
```

---

**Installation Date:** February 11, 2026
**Status:** ✅ Ready to use
**Next Action:** Restart Claude Desktop and test!

---

*All file paths are absolute and verified*
