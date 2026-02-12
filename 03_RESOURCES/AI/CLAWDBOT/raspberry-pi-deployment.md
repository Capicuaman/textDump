# Clawdbot Raspberry Pi Deployment

**Current Status:** ✅ Active and Running
**Last Updated:** February 11, 2026
**Deployment Date:** February 11, 2026

---

## Deployment Overview

Clawdbot is deployed on a Raspberry Pi 3 for 24/7 operation, accessible via Tailscale mesh VPN.

### Device Information

- **Hostname:** raspberrypi3
- **Tailscale IP:** 100.68.220.78
- **OS:** Manjaro ARM (aarch64)
- **Kernel:** 6.12.41-1-MANJARO-RPI4
- **User:** capicuaman

### System Resources

- **Total Memory:** 896MB
- **Total Storage:** 59GB
- **Used Storage:** 27GB (47%)
- **Available:** 30GB
- **Swap:** 1.3GB

---

## Clawdbot Configuration

### Software Stack

- **Clawdbot Version:** 2026.1.24-3
- **Node.js Version:** v22.22.0 (via nvm)
- **npm Version:** v10.9.4
- **Installation Method:** npm global package
- **Binary Location:** `/home/capicuaman/.nvm/versions/node/v22.22.0/bin/clawdbot`

### Service Configuration

- **Service Name:** clawdbot-gateway.service
- **Service Type:** systemd user service
- **Service File:** `/home/capicuaman/.config/systemd/user/clawdbot-gateway.service`
- **Gateway Port:** 18789
- **Auto-start:** Enabled
- **Status:** Active (running)

### Data Locations

```
~/.clawdbot/                    # Main data directory (16MB)
├── agents/                     # Agent configurations and sessions
├── credentials/                # Authentication credentials
├── cron/                       # Scheduled jobs (largest dir)
├── devices/                    # Device registrations
├── identity/                   # Identity keys
├── media/                      # Media files
├── subagents/                  # Subagent data
├── telegram/                   # Telegram session data
├── clawdbot.json              # Main configuration
└── clawdbot.json.bak*         # Configuration backups

~/clawd/clawdbot-scripts/      # Custom scripts (12K)
~/clawd/clawdbot-templates/    # Templates (24K)
~/clawd/clawdbot-monitoring/   # Monitoring configs (28K)
~/clawd/clawdbot-*.md          # Documentation
```

### Workspace Configuration

- **Workspace Name:** Ofoson
- **Last Touched:** 2026-02-08 19:47:20
- **Auth Provider:** Anthropic (Claude)
- **Configured Channels:** WhatsApp, Telegram (and others)

---

## Quick Access Commands

### SSH Connection

```bash
ssh capicuaman@100.68.220.78
```

### Service Management

**Check status:**
```bash
ssh capicuaman@100.68.220.78 "systemctl --user status clawdbot-gateway.service"
```

**Restart service:**
```bash
ssh capicuaman@100.68.220.78 "systemctl --user restart clawdbot-gateway.service"
```

**Stop service:**
```bash
ssh capicuaman@100.68.220.78 "systemctl --user stop clawdbot-gateway.service"
```

**Start service:**
```bash
ssh capicuaman@100.68.220.78 "systemctl --user start clawdbot-gateway.service"
```

### Monitoring

**Live logs:**
```bash
ssh capicuaman@100.68.220.78 "journalctl --user -u clawdbot-gateway.service -f"
```

**Recent logs:**
```bash
ssh capicuaman@100.68.220.78 "journalctl --user -u clawdbot-gateway.service -n 50"
```

**Process check:**
```bash
ssh capicuaman@100.68.220.78 "ps aux | grep clawdbot | grep -v grep"
```

**Resource usage:**
```bash
ssh capicuaman@100.68.220.78 "top -b -n 1 | grep clawdbot"
```

**Disk usage:**
```bash
ssh capicuaman@100.68.220.78 "du -sh ~/.clawdbot/"
```

### Clawdbot Commands

**Run with nvm:**
```bash
ssh capicuaman@100.68.220.78 "
export NVM_DIR=\"\$HOME/.nvm\" &&
[ -s \"\$NVM_DIR/nvm.sh\" ] && . \"\$NVM_DIR/nvm.sh\" &&
clawdbot --help
"
```

**Check version:**
```bash
ssh capicuaman@100.68.220.78 "
export NVM_DIR=\"\$HOME/.nvm\" &&
[ -s \"\$NVM_DIR/nvm.sh\" ] && . \"\$NVM_DIR/nvm.sh\" &&
clawdbot --version
"
```

---

## Performance Baseline

### Process Information

Typical operation (post-migration):
- **Number of processes:** 2 (clawdbot + clawdbot-gateway)
- **CPU usage:** 3-5% idle, spikes to 30-40% during message processing
- **Memory usage:** 50-150MB per process (total ~200-300MB)
- **Disk I/O:** Minimal (<1MB/s)

### Network

- **Connection:** Tailscale mesh VPN
- **Latency:** <50ms (local network)
- **Bandwidth:** Minimal (<1Mbps typical)

---

## Maintenance Schedule

### Daily
- [ ] Quick status check
- [ ] Review error logs (if any)

### Weekly
- [ ] Full log review
- [ ] Disk space check
- [ ] Performance monitoring
- [ ] Backup verification

### Monthly
- [ ] Update clawdbot to latest version
- [ ] Review and clean old cron jobs
- [ ] Audit credentials
- [ ] Test auto-restart on reboot

---

## Update Procedure

```bash
# Connect to Raspberry Pi
ssh capicuaman@100.68.220.78

# Load nvm and update
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Update to latest version
npm update -g clawdbot

# Restart service
systemctl --user restart clawdbot-gateway.service

# Verify
clawdbot --version
systemctl --user status clawdbot-gateway.service
```

---

## Backup Information

### Local Backup (Source Machine)

- **Location:** `/home/capicuaman/clawdbot-backup-20260211-112813.tar.gz`
- **Size:** 4.5MB compressed
- **Created:** February 11, 2026
- **Retention:** 30 days after verification

### Raspberry Pi Backup Strategy

**Recommended:** Create weekly backups of `~/.clawdbot/`

```bash
# From source machine
BACKUP_DATE=$(date +%Y%m%d)
scp -r capicuaman@100.68.220.78:~/.clawdbot ~/pi-backups/clawdbot-$BACKUP_DATE/
tar -czf ~/pi-backups/clawdbot-$BACKUP_DATE.tar.gz -C ~/pi-backups/clawdbot-$BACKUP_DATE .
```

Or on Raspberry Pi:
```bash
ssh capicuaman@100.68.220.78 "
cd ~ &&
tar -czf clawdbot-backup-\$(date +%Y%m%d).tar.gz .clawdbot &&
ls -lh clawdbot-backup-*.tar.gz
"
```

---

## Troubleshooting

### Service Won't Start

1. Check logs:
   ```bash
   ssh capicuaman@100.68.220.78 "journalctl --user -u clawdbot-gateway.service -n 50"
   ```

2. Verify Node.js is accessible:
   ```bash
   ssh capicuaman@100.68.220.78 "
   export NVM_DIR=\"\$HOME/.nvm\" &&
   [ -s \"\$NVM_DIR/nvm.sh\" ] && . \"\$NVM_DIR/nvm.sh\" &&
   node --version
   "
   ```

3. Reinstall daemon:
   ```bash
   ssh capicuaman@100.68.220.78 "
   export NVM_DIR=\"\$HOME/.nvm\" &&
   [ -s \"\$NVM_DIR/nvm.sh\" ] && . \"\$NVM_DIR/nvm.sh\" &&
   clawdbot daemon install --port 18789 --force
   "
   ```

### High Memory Usage

If memory exceeds 300MB sustained:

1. Check for memory leaks:
   ```bash
   ssh capicuaman@100.68.220.78 "ps aux --sort=-%mem | grep clawdbot"
   ```

2. Restart service:
   ```bash
   ssh capicuaman@100.68.220.78 "systemctl --user restart clawdbot-gateway.service"
   ```

3. Monitor after restart

### Tailscale Connection Issues

1. Check Tailscale status:
   ```bash
   tailscale status | grep raspberrypi3
   ```

2. On Raspberry Pi, restart Tailscale:
   ```bash
   ssh capicuaman@100.68.220.78 "sudo systemctl restart tailscaled"
   ```

3. Verify connectivity:
   ```bash
   ping 100.68.220.78
   ```

### Authentication Errors

Re-sync credentials:
```bash
rsync -avz ~/.clawdbot/credentials/ capicuaman@100.68.220.78:~/.clawdbot/credentials/
ssh capicuaman@100.68.220.78 "systemctl --user restart clawdbot-gateway.service"
```

---

## Security Notes

- Service runs as user `capicuaman` (not root)
- Credentials stored in `~/.clawdbot/credentials/` (0700 permissions)
- Tailscale provides encrypted mesh VPN
- No direct internet exposure
- SSH access via Tailscale only

---

## Monitoring Dashboard

Create a monitoring script:

```bash
#!/bin/bash
# ~/clawd/clawdbot-monitoring/dashboard.sh

echo "=== Clawdbot Raspberry Pi Status ==="
echo "Timestamp: $(date)"
echo ""

echo "=== Service Status ==="
systemctl --user status clawdbot-gateway.service --no-pager -l | head -10
echo ""

echo "=== Processes ==="
ps aux | grep clawdbot | grep -v grep
echo ""

echo "=== Resource Usage ==="
top -b -n 1 | grep clawdbot
echo ""

echo "=== Disk Usage ==="
du -sh ~/.clawdbot/
echo ""

echo "=== Recent Logs (last 10 lines) ==="
journalctl --user -u clawdbot-gateway.service -n 10 --no-pager
```

Run via SSH:
```bash
ssh capicuaman@100.68.220.78 "bash ~/clawd/clawdbot-monitoring/dashboard.sh"
```

---

## Health Check Indicators

### Healthy System
- ✅ Service status: active (running)
- ✅ Process count: 2
- ✅ CPU usage: <10% average
- ✅ Memory usage: <300MB total
- ✅ No error logs in past hour
- ✅ Messages sending/receiving successfully

### Requires Attention
- ⚠️ CPU usage: 10-50% sustained
- ⚠️ Memory usage: 300-500MB
- ⚠️ Warning logs present
- ⚠️ Service restarts (1-2 per day)

### Critical Issues
- 🚨 Service stopped/failed
- 🚨 CPU usage: >50% sustained
- 🚨 Memory usage: >500MB
- 🚨 Error logs multiplying
- 🚨 Messages not being delivered
- 🚨 Frequent service restarts (>3/hour)

---

## Network Configuration

### Tailscale
- **Network:** 100.64.0.0/10
- **Device IP:** 100.68.220.78
- **Magic DNS:** raspberrypi3.tail-scale.ts.net
- **Status:** Active

### Local Network
- **Interface:** wlan0 or eth0
- **Gateway port:** 18789 (localhost only)
- **External access:** Via Tailscale only

---

## Useful Aliases

Add to local `~/.bashrc` or `~/.zshrc`:

```bash
# Clawdbot Raspberry Pi aliases
alias pi-ssh='ssh capicuaman@100.68.220.78'
alias pi-clawdbot-status='ssh capicuaman@100.68.220.78 "systemctl --user status clawdbot-gateway.service"'
alias pi-clawdbot-logs='ssh capicuaman@100.68.220.78 "journalctl --user -u clawdbot-gateway.service -f"'
alias pi-clawdbot-restart='ssh capicuaman@100.68.220.78 "systemctl --user restart clawdbot-gateway.service"'
alias pi-clawdbot-ps='ssh capicuaman@100.68.220.78 "ps aux | grep clawdbot | grep -v grep"'
```

Reload:
```bash
source ~/.bashrc  # or source ~/.zshrc
```

---

## Contact Information

**Device Owner:** capicuaman
**Deployment Date:** February 11, 2026
**Migration Documentation:** [clawdbot-migration-guide.md](./clawdbot-migration-guide.md)

---

*Last updated: February 11, 2026*
*Status: Active and stable*
