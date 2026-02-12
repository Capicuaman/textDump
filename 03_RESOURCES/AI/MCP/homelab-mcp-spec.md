# Homelab MCP Server Specification

**Project Name:** homelab-mcp
**Purpose:** Unified MCP server for managing Tailscale-connected devices
**Target:** Raspberry Pis, Linux servers, home lab infrastructure
**Created:** February 11, 2026

---

## Overview

A custom Model Context Protocol server designed specifically for your home lab environment. Provides high-level tools for managing multiple devices over Tailscale with minimal token usage.

### Why Build This?

**Current approach (Bash):**
- Every command requires full SSH connection string
- Must source nvm environment in each command
- Output is unstructured text requiring parsing
- No connection reuse
- High token usage (~2K per command)

**With homelab-mcp:**
- Tools remember device configurations
- Persistent SSH connections
- Structured JSON responses
- ~500 tokens per operation
- **75% token reduction**

---

## Architecture

```
┌─────────────────────────────────────────┐
│           Claude / Claude Code          │
│                                         │
│   (Uses MCP tools via Protocol)         │
└────────────────┬────────────────────────┘
                 │
                 │ stdio/SSE
                 │
┌────────────────▼────────────────────────┐
│         Homelab MCP Server              │
│                                         │
│  ┌──────────────────────────────────┐  │
│  │    Tool Registry                 │  │
│  │  - check_pi_status               │  │
│  │  - sync_to_pi                    │  │
│  │  - restart_service               │  │
│  │  - get_logs                      │  │
│  │  - monitor_resources             │  │
│  │  - run_command                   │  │
│  │  - backup_clawdbot               │  │
│  │  - list_devices                  │  │
│  └──────────────────────────────────┘  │
│                                         │
│  ┌──────────────────────────────────┐  │
│  │    Connection Manager            │  │
│  │  - SSH connection pool           │  │
│  │  - Tailscale device discovery    │  │
│  │  - Credential management         │  │
│  └──────────────────────────────────┘  │
│                                         │
│  ┌──────────────────────────────────┐  │
│  │    Device Config                 │  │
│  │  - Known hosts (Tailscale IPs)   │  │
│  │  - Environment settings (nvm)    │  │
│  │  - Service mappings              │  │
│  └──────────────────────────────────┘  │
└────────────────┬────────────────────────┘
                 │
                 │ SSH over Tailscale
                 │
┌────────────────▼────────────────────────┐
│         Tailscale Network               │
│                                         │
│  ┌────────────┐  ┌────────────┐        │
│  │raspberrypi3│  │   alien    │        │
│  │100.68.220  │  │100.96.199  │        │
│  └────────────┘  └────────────┘        │
│                                         │
│  ┌────────────┐  ┌────────────┐        │
│  │   ds220    │  │ Other Pis  │        │
│  │100.119.163 │  │   Future   │        │
│  └────────────┘  └────────────┘        │
└─────────────────────────────────────────┘
```

---

## Tools Specification

### 1. check_pi_status

**Description:** Get comprehensive status of a Raspberry Pi in one call

**Parameters:**
```typescript
{
  hostname: string;  // "raspberrypi3" or Tailscale IP
}
```

**Returns:**
```typescript
{
  hostname: string;
  ip: string;
  online: boolean;
  uptime: string;
  system: {
    os: string;
    kernel: string;
    arch: string;
  };
  resources: {
    cpu: {
      count: number;
      usage_percent: number;
    };
    memory: {
      total_mb: number;
      used_mb: number;
      available_mb: number;
      usage_percent: number;
    };
    disk: {
      total_gb: number;
      used_gb: number;
      available_gb: number;
      usage_percent: number;
    };
  };
  services: {
    name: string;
    status: "active" | "inactive" | "failed";
    pid?: number[];
  }[];
  clawdbot?: {
    version: string;
    running: boolean;
    processes: number;
    data_size_mb: number;
  };
}
```

**Token Usage:** ~800 tokens (vs ~2,500 with Bash)

---

### 2. sync_to_pi

**Description:** Rsync files to Raspberry Pi with progress tracking

**Parameters:**
```typescript
{
  source: string;        // Local path
  destination: string;   // Remote path
  hostname: string;      // Target device
  options?: {
    compress: boolean;   // Default: true
    delete: boolean;     // Default: false
    dry_run: boolean;    // Default: false
    exclude?: string[];  // Patterns to exclude
  };
}
```

**Returns:**
```typescript
{
  success: boolean;
  files_transferred: number;
  bytes_transferred: number;
  duration_seconds: number;
  errors?: string[];
}
```

**Token Usage:** ~600 tokens (vs ~1,800 with Bash)

---

### 3. restart_service

**Description:** Restart a systemd service on remote host

**Parameters:**
```typescript
{
  service: string;       // Service name (e.g., "clawdbot-gateway")
  hostname: string;      // Target device
  user_service: boolean; // Default: true
}
```

**Returns:**
```typescript
{
  success: boolean;
  service: string;
  status: "active" | "inactive" | "failed";
  pid: number[];
  uptime: string;
  error?: string;
}
```

**Token Usage:** ~400 tokens (vs ~1,200 with Bash)

---

### 4. get_logs

**Description:** Retrieve structured logs from systemd service

**Parameters:**
```typescript
{
  service: string;       // Service name
  hostname: string;      // Target device
  lines?: number;        // Default: 50
  follow?: boolean;      // Stream logs (default: false)
  since?: string;        // Time filter (e.g., "1 hour ago")
  priority?: "err" | "warning" | "info" | "debug";
}
```

**Returns:**
```typescript
{
  service: string;
  hostname: string;
  entries: {
    timestamp: string;
    priority: string;
    message: string;
  }[];
  summary: {
    errors: number;
    warnings: number;
    total_lines: number;
  };
}
```

**Token Usage:** ~700 tokens (vs ~2,000 with Bash)

---

### 5. monitor_resources

**Description:** Get real-time resource usage metrics

**Parameters:**
```typescript
{
  hostname: string;      // Target device
  duration?: number;     // Seconds to monitor (default: 1)
}
```

**Returns:**
```typescript
{
  hostname: string;
  timestamp: string;
  cpu: {
    usage_percent: number;
    load_average: [number, number, number]; // 1m, 5m, 15m
    processes: number;
  };
  memory: {
    total_mb: number;
    used_mb: number;
    free_mb: number;
    cached_mb: number;
    swap_total_mb: number;
    swap_used_mb: number;
  };
  disk: {
    mount: string;
    total_gb: number;
    used_gb: number;
    available_gb: number;
    usage_percent: number;
  }[];
  network: {
    interface: string;
    rx_bytes: number;
    tx_bytes: number;
  }[];
}
```

**Token Usage:** ~900 tokens (vs ~2,800 with Bash)

---

### 6. run_command

**Description:** Execute arbitrary command on remote host

**Parameters:**
```typescript
{
  command: string;       // Command to execute
  hostname: string;      // Target device
  timeout?: number;      // Seconds (default: 30)
  cwd?: string;          // Working directory
  env?: Record<string, string>; // Environment variables
  load_nvm?: boolean;    // Load nvm first (default: true)
}
```

**Returns:**
```typescript
{
  success: boolean;
  exit_code: number;
  stdout: string;
  stderr: string;
  duration_ms: number;
  command: string;
  error?: string;
}
```

**Token Usage:** ~500 tokens (vs ~1,500 with Bash)

---

### 7. backup_clawdbot

**Description:** Create and download clawdbot backup from Pi

**Parameters:**
```typescript
{
  hostname: string;      // Source device
  destination?: string;  // Local path (default: ~/backups/)
  compress?: boolean;    // Default: true
}
```

**Returns:**
```typescript
{
  success: boolean;
  backup_file: string;
  size_mb: number;
  timestamp: string;
  contents: {
    clawdbot_dir: boolean;
    scripts: boolean;
    templates: boolean;
    monitoring: boolean;
  };
  duration_seconds: number;
}
```

**Token Usage:** ~600 tokens (vs ~2,000 with Bash)

---

### 8. list_tailscale_devices

**Description:** Get all devices on Tailscale network

**Parameters:**
```typescript
{
  online_only?: boolean; // Default: false
}
```

**Returns:**
```typescript
{
  devices: {
    hostname: string;
    ip: string;
    os: string;
    online: boolean;
    last_seen?: string;
    exit_node: boolean;
  }[];
  total_count: number;
  online_count: number;
}
```

**Token Usage:** ~400 tokens (vs ~1,000 with Bash)

---

## Configuration

### Device Configuration File

**Location:** `~/.config/homelab-mcp/devices.json`

```json
{
  "devices": {
    "raspberrypi3": {
      "ip": "100.68.220.78",
      "user": "capicuaman",
      "key_path": "~/.ssh/id_rsa",
      "services": {
        "clawdbot": "clawdbot-gateway.service"
      },
      "environment": {
        "nvm": {
          "enabled": true,
          "dir": "$HOME/.nvm"
        }
      }
    },
    "alien": {
      "ip": "100.96.199.13",
      "user": "capicuaman",
      "key_path": "~/.ssh/id_rsa"
    },
    "ds220": {
      "ip": "100.119.163.51",
      "user": "capicuaman",
      "key_path": "~/.ssh/id_rsa"
    }
  },
  "defaults": {
    "timeout": 30,
    "retry_count": 3,
    "connection_pool_size": 5
  }
}
```

### Claude Desktop Configuration

**Location:** `~/Library/Application Support/Claude/claude_desktop_config.json` (macOS)
or `~/.config/claude/claude_desktop_config.json` (Linux)

```json
{
  "mcpServers": {
    "homelab": {
      "command": "node",
      "args": ["/path/to/homelab-mcp/build/index.js"],
      "env": {
        "CONFIG_PATH": "/home/capicuaman/.config/homelab-mcp/devices.json"
      }
    }
  }
}
```

---

## Implementation Guide

### Tech Stack

- **Runtime:** Node.js 22+
- **Language:** TypeScript
- **MCP SDK:** `@modelcontextprotocol/sdk`
- **SSH:** `node-ssh` or `ssh2`
- **Process Management:** `execa`

### Project Structure

```
homelab-mcp/
├── src/
│   ├── index.ts              # Main entry point
│   ├── server.ts             # MCP server setup
│   ├── tools/
│   │   ├── check-pi-status.ts
│   │   ├── sync-to-pi.ts
│   │   ├── restart-service.ts
│   │   ├── get-logs.ts
│   │   ├── monitor-resources.ts
│   │   ├── run-command.ts
│   │   ├── backup-clawdbot.ts
│   │   └── list-devices.ts
│   ├── connection/
│   │   ├── ssh-manager.ts    # SSH connection pool
│   │   ├── tailscale.ts      # Tailscale device discovery
│   │   └── config.ts         # Configuration management
│   └── types/
│       └── index.ts          # TypeScript types
├── config/
│   └── devices.example.json  # Example config
├── tests/
│   └── *.test.ts
├── package.json
├── tsconfig.json
└── README.md
```

### Quick Start

```bash
# Create project
mkdir homelab-mcp
cd homelab-mcp
npm init -y

# Install dependencies
npm install @modelcontextprotocol/sdk node-ssh execa zod
npm install -D typescript @types/node tsx

# Initialize TypeScript
npx tsc --init

# Create src directory
mkdir -p src/tools src/connection src/types

# Start coding (see implementation below)
```

---

## Implementation Example

### Main Server Setup

**`src/index.ts`:**

```typescript
#!/usr/bin/env node
import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { checkPiStatus } from "./tools/check-pi-status.js";
import { syncToPi } from "./tools/sync-to-pi.js";
import { restartService } from "./tools/restart-service.js";
import { getLogs } from "./tools/get-logs.js";
import { monitorResources } from "./tools/monitor-resources.js";
import { runCommand } from "./tools/run-command.js";
import { backupClawdbot } from "./tools/backup-clawdbot.js";
import { listDevices } from "./tools/list-devices.js";
import { SSHManager } from "./connection/ssh-manager.js";
import { loadConfig } from "./connection/config.js";

const server = new Server(
  {
    name: "homelab-mcp",
    version: "1.0.0",
  },
  {
    capabilities: {
      tools: {},
    },
  }
);

// Load configuration
const config = loadConfig();
const sshManager = new SSHManager(config);

// Register tools
checkPiStatus(server, sshManager);
syncToPi(server, sshManager);
restartService(server, sshManager);
getLogs(server, sshManager);
monitorResources(server, sshManager);
runCommand(server, sshManager);
backupClawdbot(server, sshManager);
listDevices(server, sshManager);

// Start server
async function main() {
  const transport = new StdioServerTransport();
  await server.connect(transport);
  console.error("Homelab MCP server running on stdio");
}

main().catch(console.error);
```

### Example Tool Implementation

**`src/tools/check-pi-status.ts`:**

```typescript
import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { z } from "zod";
import { SSHManager } from "../connection/ssh-manager.js";

const CheckPiStatusSchema = z.object({
  hostname: z.string(),
});

export function checkPiStatus(server: Server, sshManager: SSHManager) {
  server.tool(
    "check_pi_status",
    {
      description: "Get comprehensive status of a Raspberry Pi",
      inputSchema: {
        type: "object",
        properties: {
          hostname: {
            type: "string",
            description: "Hostname or Tailscale IP of the device",
          },
        },
        required: ["hostname"],
      },
    },
    async ({ hostname }) => {
      const input = CheckPiStatusSchema.parse({ hostname });

      try {
        const ssh = await sshManager.getConnection(input.hostname);

        // Run multiple commands in parallel
        const [uptime, uname, df, free, systemctl] = await Promise.all([
          ssh.execCommand("uptime"),
          ssh.execCommand("uname -a"),
          ssh.execCommand("df -h /"),
          ssh.execCommand("free -m"),
          ssh.execCommand("systemctl --user status clawdbot-gateway.service --no-pager"),
        ]);

        // Parse results
        const status = {
          hostname: input.hostname,
          ip: sshManager.getDeviceIP(input.hostname),
          online: true,
          uptime: parseUptime(uptime.stdout),
          system: parseUname(uname.stdout),
          resources: {
            cpu: parseCPU(uptime.stdout),
            memory: parseMemory(free.stdout),
            disk: parseDisk(df.stdout),
          },
          services: parseServices(systemctl.stdout),
        };

        return {
          content: [
            {
              type: "text",
              text: JSON.stringify(status, null, 2),
            },
          ],
        };
      } catch (error) {
        return {
          content: [
            {
              type: "text",
              text: JSON.stringify({
                error: error.message,
                hostname: input.hostname,
                online: false,
              }),
            },
          ],
          isError: true,
        };
      }
    }
  );
}

// Helper functions
function parseUptime(output: string): string {
  // Parse uptime output
  return output.trim();
}

function parseUname(output: string) {
  const parts = output.split(" ");
  return {
    os: parts[0],
    kernel: parts[2],
    arch: parts[parts.length - 1],
  };
}

function parseCPU(output: string) {
  // Extract CPU usage from uptime
  const match = output.match(/load average: ([\d.]+), ([\d.]+), ([\d.]+)/);
  return {
    usage_percent: match ? parseFloat(match[1]) * 100 : 0,
  };
}

function parseMemory(output: string) {
  // Parse free output
  const lines = output.split("\n");
  const memLine = lines.find(l => l.startsWith("Mem:"));
  if (!memLine) return {};

  const [, total, used, , , , available] = memLine.split(/\s+/);
  return {
    total_mb: parseInt(total),
    used_mb: parseInt(used),
    available_mb: parseInt(available),
    usage_percent: (parseInt(used) / parseInt(total)) * 100,
  };
}

function parseDisk(output: string) {
  // Parse df output
  const lines = output.split("\n").slice(1);
  const [filesystem, size, used, avail, percent] = lines[0].split(/\s+/);
  return {
    total_gb: parseSize(size),
    used_gb: parseSize(used),
    available_gb: parseSize(avail),
    usage_percent: parseInt(percent),
  };
}

function parseSize(size: string): number {
  // Convert size string (e.g., "59G", "27G") to number
  const match = size.match(/([\d.]+)([KMGT])/);
  if (!match) return 0;
  const value = parseFloat(match[1]);
  const unit = match[2];
  const multipliers = { K: 0.001, M: 0.001, G: 1, T: 1000 };
  return value * multipliers[unit];
}

function parseServices(output: string) {
  // Parse systemctl output
  const active = output.includes("Active: active");
  return [
    {
      name: "clawdbot-gateway",
      status: active ? "active" : "inactive",
    },
  ];
}
```

### SSH Connection Manager

**`src/connection/ssh-manager.ts`:**

```typescript
import { NodeSSH, Config } from "node-ssh";

interface DeviceConfig {
  ip: string;
  user: string;
  key_path: string;
  services?: Record<string, string>;
  environment?: {
    nvm?: {
      enabled: boolean;
      dir: string;
    };
  };
}

export class SSHManager {
  private connections: Map<string, NodeSSH> = new Map();
  private config: Record<string, DeviceConfig>;

  constructor(config: { devices: Record<string, DeviceConfig> }) {
    this.config = config.devices;
  }

  async getConnection(hostname: string): Promise<NodeSSH> {
    // Return existing connection if available
    if (this.connections.has(hostname)) {
      const conn = this.connections.get(hostname)!;
      if (conn.isConnected()) {
        return conn;
      }
    }

    // Create new connection
    const device = this.config[hostname];
    if (!device) {
      throw new Error(`Device ${hostname} not found in config`);
    }

    const ssh = new NodeSSH();
    await ssh.connect({
      host: device.ip,
      username: device.user,
      privateKeyPath: device.key_path.replace("~", process.env.HOME),
    });

    this.connections.set(hostname, ssh);
    return ssh;
  }

  getDeviceIP(hostname: string): string {
    return this.config[hostname]?.ip || "";
  }

  async disconnect(hostname: string) {
    const conn = this.connections.get(hostname);
    if (conn) {
      conn.dispose();
      this.connections.delete(hostname);
    }
  }

  async disconnectAll() {
    for (const [hostname, conn] of this.connections) {
      conn.dispose();
    }
    this.connections.clear();
  }
}
```

---

## Token Savings Calculator

### Migration Task Breakdown

| Operation | Bash Tokens | MCP Tokens | Savings |
|-----------|-------------|------------|---------|
| Check status | 2,500 | 800 | 68% |
| Sync files | 1,800 | 600 | 67% |
| Restart service | 1,200 | 400 | 67% |
| Get logs | 2,000 | 700 | 65% |
| Monitor resources | 2,800 | 900 | 68% |
| Run command | 1,500 | 500 | 67% |
| **Total** | **11,800** | **3,900** | **67%** |

### ROI Analysis

**Development Time:** ~16-20 hours
**Token Cost Savings:** ~8,000 tokens per migration
**Break-even:** 3-4 uses

**After 10 uses:**
- Tokens saved: ~80,000
- Time saved: ~5 hours (less debugging, faster execution)
- **ROI: Positive**

---

## Testing Strategy

### Unit Tests

```typescript
// tests/check-pi-status.test.ts
import { describe, it, expect, beforeEach } from "vitest";
import { SSHManager } from "../src/connection/ssh-manager";

describe("check_pi_status", () => {
  let sshManager: SSHManager;

  beforeEach(() => {
    sshManager = new SSHManager(mockConfig);
  });

  it("should return comprehensive status", async () => {
    const result = await checkPiStatus(sshManager, "raspberrypi3");
    expect(result.online).toBe(true);
    expect(result.resources).toBeDefined();
  });

  it("should handle offline devices", async () => {
    const result = await checkPiStatus(sshManager, "offline-device");
    expect(result.online).toBe(false);
  });
});
```

### Integration Tests

Test against actual Raspberry Pi:

```bash
npm run test:integration
```

---

## Deployment

### Local Development

```bash
npm run dev
```

### Build for Production

```bash
npm run build
```

### Install in Claude Desktop

1. Build the project
2. Update `claude_desktop_config.json`
3. Restart Claude Desktop
4. Test with: "Use the homelab MCP to check raspberrypi3 status"

---

## Future Enhancements

### Phase 2 Features

1. **Orchestration Tools**
   - `deploy_to_all(command)` - Run on all devices
   - `rolling_update(service)` - Update with zero downtime
   - `health_check_all()` - Check all devices

2. **Monitoring Dashboard**
   - `get_dashboard()` - All devices status
   - `alert_config()` - Set up alerts
   - `metric_history(device, metric)` - Historical data

3. **Backup Management**
   - `scheduled_backup()` - Automated backups
   - `restore_backup(file)` - Restore from backup
   - `backup_rotation()` - Manage backup retention

### Phase 3 Features

1. **Docker Integration**
   - `list_containers(host)`
   - `restart_container(name, host)`
   - `deploy_compose(file, host)`

2. **Network Tools**
   - `ping_all()` - Network connectivity check
   - `bandwidth_test(source, dest)`
   - `firewall_status(host)`

3. **Security**
   - `update_packages(host)` - Security updates
   - `audit_config(host)` - Security audit
   - `rotate_keys()` - SSH key rotation

---

## Maintenance

### Updates

```bash
# Update dependencies
npm update

# Update MCP SDK
npm install @modelcontextprotocol/sdk@latest

# Rebuild
npm run build
```

### Monitoring

Check MCP server logs:

```bash
# macOS
tail -f ~/Library/Logs/Claude/mcp-homelab.log

# Linux
journalctl --user -u claude-desktop -f | grep homelab
```

### Troubleshooting

**Connection issues:**
- Check Tailscale status
- Verify SSH keys
- Test manual SSH connection

**Tool failures:**
- Check MCP server logs
- Verify device config
- Test tool in isolation

---

## Resources

- **MCP SDK:** https://github.com/modelcontextprotocol/sdk
- **node-ssh:** https://github.com/steelbrain/node-ssh
- **TypeScript:** https://www.typescriptlang.org/

---

*Specification version: 1.0*
*Last updated: February 11, 2026*
*Ready for implementation*
