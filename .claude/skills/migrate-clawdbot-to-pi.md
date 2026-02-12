# Migrate Clawdbot to Raspberry Pi

## Description
Safely migrate clawdbot from local machine to Raspberry Pi via Tailscale. Non-destructive migration with verification before cleanup.

## Usage
- `/migrate-clawdbot` - Run full migration with interactive prompts
- `/migrate-clawdbot verify` - Check prerequisites only
- `/migrate-clawdbot rollback` - Restore from backup

## What This Skill Does
1. Pre-flight checks (connectivity, disk space, Node.js)
2. Create timestamped local backup
3. Install Node.js on Raspberry Pi (if needed)
4. Install clawdbot on Raspberry Pi (same version)
5. Sync data directories via rsync over Tailscale
6. Verify installation and configure daemon
7. Provide cleanup instructions (manual, after user confirmation)

## Target Configuration
- **Raspberry Pi:** `raspberrypi3` (100.68.220.78 via Tailscale)
- **OS:** Manjaro ARM (aarch64)
- **User:** capicuaman
- **Data to migrate:**
  - `~/.clawdbot/` (~16MB) - configs, credentials, sessions, cron jobs
  - `~/clawd/clawdbot-scripts/` - Custom scripts
  - `~/clawd/clawdbot-templates/` - Templates
  - `~/clawd/clawdbot-monitoring/` - Monitoring configs
  - `~/clawd/clawdbot-*.md` - Documentation files

---

## Agent Instructions

When this skill is invoked:

### Phase 1: Pre-flight Checks

**1.1 Check Tailscale connectivity**
```bash
tailscale status | grep raspberrypi3
```
Expected: `100.68.220.78    raspberrypi3    ofo.rivera@    linux    -` (or "idle")

**1.2 Test SSH connection**
```bash
ssh -o ConnectTimeout=5 capicuaman@100.68.220.78 "echo 'Connection OK'"
```
Expected: "Connection OK"

**1.3 Check Raspberry Pi disk space**
```bash
ssh capicuaman@100.68.220.78 "df -h / && free -h"
```
Required: At least 500MB free on root filesystem

**1.4 Check local data size**
```bash
du -sh ~/.clawdbot ~/clawd/clawdbot-* 2>/dev/null
```
Expected: ~16-20MB total

**1.5 Check current clawdbot version**
```bash
npm list -g clawdbot 2>/dev/null | grep clawdbot@
```
Save this version for installation on Pi

**1.6 Check for running clawdbot processes**
```bash
ps aux | grep clawdbot | grep -v grep
```
Note PIDs - will need to stop before migration

**Decision point:** If any pre-flight check fails, STOP and report issue to user.

---

### Phase 2: Create Local Backup

**2.1 Create backup directory**
```bash
BACKUP_DIR="$HOME/clawdbot-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"
echo "Backup directory: $BACKUP_DIR"
```

**2.2 Backup .clawdbot directory**
```bash
cp -a ~/.clawdbot "$BACKUP_DIR/" 2>&1
```

**2.3 Backup clawd directories**
```bash
mkdir -p "$BACKUP_DIR/clawd"
cp -a ~/clawd/clawdbot-* "$BACKUP_DIR/clawd/" 2>&1 || echo "Some clawd items not found (OK)"
```

**2.4 Create compressed archive**
```bash
tar -czf "$BACKUP_DIR.tar.gz" -C "$BACKUP_DIR" . && ls -lh "$BACKUP_DIR.tar.gz"
```
Expected: Compressed file ~5-10MB

**2.5 Verify backup**
```bash
tar -tzf "$BACKUP_DIR.tar.gz" | head -10
```

**Output to user:**
```
✅ Backup created: $BACKUP_DIR.tar.gz
📦 Size: [X]MB
📁 Location: $BACKUP_DIR/
```

**Decision point:** If backup fails, STOP. Do not proceed without valid backup.

---

### Phase 3: Install Node.js on Raspberry Pi

**3.1 Check if Node.js already installed**
```bash
ssh capicuaman@100.68.220.78 "node --version 2>/dev/null && npm --version 2>/dev/null || echo 'Not installed'"
```

**3.2 Install Node.js (if needed)**
```bash
ssh capicuaman@100.68.220.78 "sudo pacman -Sy --noconfirm nodejs npm"
```

**3.3 Verify installation**
```bash
ssh capicuaman@100.68.220.78 "node --version && npm --version"
```
Required: Node.js ≥ v22.x.x, npm ≥ v10.x.x

**Output to user:**
```
✅ Node.js v[X.Y.Z] installed on Raspberry Pi
✅ npm v[X.Y.Z] installed on Raspberry Pi
```

**Decision point:** If Node.js version < 22, warn user and ask to proceed or abort.

---

### Phase 4: Install Clawdbot on Raspberry Pi

**4.1 Get local clawdbot version**
```bash
CLAWDBOT_VERSION=$(npm list -g clawdbot 2>/dev/null | grep clawdbot@ | sed 's/.*clawdbot@//' | sed 's/ .*//')
echo "Version to install: $CLAWDBOT_VERSION"
```

**4.2 Install clawdbot on Raspberry Pi**
```bash
ssh capicuaman@100.68.220.78 "npm install -g clawdbot@${CLAWDBOT_VERSION}"
```

**4.3 Verify installation**
```bash
ssh capicuaman@100.68.220.78 "which clawdbot && clawdbot --version"
```

**Output to user:**
```
✅ clawdbot@[VERSION] installed on Raspberry Pi
📍 Binary location: [PATH]
```

**Decision point:** If installation fails, STOP and check npm logs.

---

### Phase 5: Stop Local Clawdbot

**5.1 Stop clawdbot processes**
```bash
pkill -15 clawdbot-gateway 2>/dev/null
sleep 2
pkill -15 clawdbot 2>/dev/null
sleep 2
pkill -9 clawdbot-gateway 2>/dev/null
pkill -9 clawdbot 2>/dev/null
```

**5.2 Verify processes stopped**
```bash
ps aux | grep clawdbot | grep -v grep || echo "All processes stopped"
```

**Output to user:**
```
🛑 Local clawdbot processes stopped
⏸️  Gateway halted for migration
```

**Decision point:** If processes won't stop, report PIDs and ask user to investigate.

---

### Phase 6: Sync Data to Raspberry Pi

**6.1 Sync .clawdbot directory**
```bash
rsync -avz --progress ~/.clawdbot/ capicuaman@100.68.220.78:~/.clawdbot/
```

**6.2 Create clawd directory on Pi**
```bash
ssh capicuaman@100.68.220.78 "mkdir -p ~/clawd"
```

**6.3 Sync clawdbot-scripts**
```bash
if [ -d ~/clawd/clawdbot-scripts ]; then
  rsync -avz --progress ~/clawd/clawdbot-scripts/ capicuaman@100.68.220.78:~/clawd/clawdbot-scripts/
fi
```

**6.4 Sync clawdbot-templates**
```bash
if [ -d ~/clawd/clawdbot-templates ]; then
  rsync -avz --progress ~/clawd/clawdbot-templates/ capicuaman@100.68.220.78:~/clawd/clawdbot-templates/
fi
```

**6.5 Sync clawdbot-monitoring**
```bash
if [ -d ~/clawd/clawdbot-monitoring ]; then
  rsync -avz --progress ~/clawd/clawdbot-monitoring/ capicuaman@100.68.220.78:~/clawd/clawdbot-monitoring/
fi
```

**6.6 Sync documentation files**
```bash
rsync -avz ~/clawd/clawdbot-*.md capicuaman@100.68.220.78:~/clawd/ 2>/dev/null || true
```

**6.7 Verify sync**
```bash
ssh capicuaman@100.68.220.78 "du -sh ~/.clawdbot ~/clawd/clawdbot-* 2>/dev/null"
```

**Output to user:**
```
✅ Data synced to Raspberry Pi:
  📁 ~/.clawdbot/ → [SIZE]
  📁 ~/clawd/clawdbot-scripts/ → [SIZE]
  📁 ~/clawd/clawdbot-templates/ → [SIZE]
  📁 ~/clawd/clawdbot-monitoring/ → [SIZE]
  📄 Documentation files → synced
```

**Decision point:** If sizes don't match local (within 10%), warn user and ask to verify.

---

### Phase 7: Verify Installation on Raspberry Pi

**7.1 Check data directory structure**
```bash
ssh capicuaman@100.68.220.78 "ls -la ~/.clawdbot/ | head -20"
```
Expected: agents/, credentials/, cron/, devices/, identity/, telegram/, clawdbot.json, etc.

**7.2 Run clawdbot doctor**
```bash
ssh capicuaman@100.68.220.78 "clawdbot doctor 2>&1 | head -30"
```
Look for errors or warnings

**7.3 Test configuration**
```bash
ssh capicuaman@100.68.220.78 "cat ~/.clawdbot/clawdbot.json | jq -r '.workspace.name, .channels[]?.type' 2>/dev/null || cat ~/.clawdbot/clawdbot.json"
```
Verify workspace and channels loaded

**Output to user:**
```
✅ Configuration verified on Raspberry Pi
📋 Workspace: [NAME]
📱 Channels: [LIST]
```

**Decision point:** If doctor shows errors, review with user before proceeding.

---

### Phase 8: Install Daemon on Raspberry Pi

**8.1 Run onboarding to install daemon**
```bash
ssh capicuaman@100.68.220.78 "clawdbot onboard --install-daemon --skip-auth"
```

**8.2 Enable systemd service**
```bash
ssh capicuaman@100.68.220.78 "systemctl --user enable clawdbot-gateway.service"
```

**8.3 Start service**
```bash
ssh capicuaman@100.68.220.78 "systemctl --user start clawdbot-gateway.service"
```

**8.4 Wait for startup**
```bash
sleep 5
```

**8.5 Check service status**
```bash
ssh capicuaman@100.68.220.78 "systemctl --user status clawdbot-gateway.service"
```

**8.6 Check processes**
```bash
ssh capicuaman@100.68.220.78 "ps aux | grep clawdbot | grep -v grep"
```
Expected: clawdbot and clawdbot-gateway processes

**Output to user:**
```
✅ Daemon installed and running on Raspberry Pi
🚀 Service: clawdbot-gateway.service (active)
🔄 Auto-start on boot: enabled
⚙️  Processes: clawdbot (PID [X]), clawdbot-gateway (PID [Y])
```

**Decision point:** If service fails to start, check logs and report to user.

---

### Phase 9: Final Verification

**9.1 Check logs for errors**
```bash
ssh capicuaman@100.68.220.78 "journalctl --user -u clawdbot-gateway.service -n 50"
```

**9.2 Test gateway responsiveness**
```bash
ssh capicuaman@100.68.220.78 "clawdbot status 2>&1 || echo 'Status command not available, checking processes instead'"
```

**Output to user:**
```
🎉 MIGRATION COMPLETE!

✅ Clawdbot successfully migrated to Raspberry Pi
✅ Daemon running and auto-start enabled
✅ Local backup saved: [BACKUP PATH]

📱 Next Steps:
1. Test WhatsApp/Telegram connection from another device
2. Send a test message to verify bot responds
3. Monitor Raspberry Pi for 24-48 hours
4. If everything works, run cleanup (see below)

🔍 Monitoring Commands:
- View logs: ssh capicuaman@100.68.220.78 "journalctl --user -u clawdbot-gateway.service -f"
- Check status: ssh capicuaman@100.68.220.78 "systemctl --user status clawdbot-gateway.service"
- Check resources: ssh capicuaman@100.68.220.78 "htop"
```

---

## Cleanup Instructions (Manual - After 24-48 Hours)

⚠️ **IMPORTANT:** Only run cleanup AFTER confirming Raspberry Pi installation works perfectly!

**Recommended waiting period:** 24-48 hours of testing

### Cleanup Steps

**1. Stop local services (if any)**
```bash
# Stop any lingering systemd services
systemctl --user stop clawdbot-gateway.service 2>/dev/null || true
systemctl --user disable clawdbot-gateway.service 2>/dev/null || true
```

**2. Uninstall clawdbot npm package**
```bash
npm uninstall -g clawdbot
which clawdbot  # Should return nothing
```

**3. Archive local data (don't delete yet!)**
```bash
mkdir -p ~/clawdbot-old-data
mv ~/.clawdbot ~/clawdbot-old-data/
mv ~/clawd/clawdbot-* ~/clawdbot-old-data/ 2>/dev/null || true
```

**4. After 30 days (if everything still works)**
```bash
# Final cleanup - only if confident!
rm -rf ~/clawdbot-old-data
rm -rf ~/clawdbot-backup-*
```

---

## Rollback Procedure

If something goes wrong on the Raspberry Pi:

**1. Stop Raspberry Pi processes**
```bash
ssh capicuaman@100.68.220.78 "systemctl --user stop clawdbot-gateway.service"
ssh capicuaman@100.68.220.78 "pkill -9 clawdbot"
```

**2. Restore from backup**
```bash
BACKUP_FILE=$(ls -t ~/clawdbot-backup-*.tar.gz | head -1)
tar -xzf "$BACKUP_FILE" -C ~/
```

**3. Restart local clawdbot**
```bash
clawdbot gateway --port 18789 --verbose &
```

**4. Verify local processes**
```bash
ps aux | grep clawdbot | grep -v grep
```

---

## Decision Rules

### HIGH Confidence (auto-proceed)
- Pre-flight checks all pass
- Backup created successfully
- rsync completes without errors
- Service starts successfully

### MEDIUM Confidence (warn and ask)
- Node.js version between 18-22 (works but not recommended)
- Data size mismatch < 10%
- Some optional directories missing
- Daemon starts but shows warnings in logs

### LOW Confidence (stop and ask user)
- Pre-flight checks fail
- Backup creation fails
- rsync shows permission errors
- Service fails to start
- Critical directories missing
- Major version mismatch

---

## Error Handling

**If backup fails:**
- STOP immediately - do not proceed
- Check disk space
- Report error to user

**If rsync fails:**
- Check SSH connectivity
- Verify Tailscale connection
- Check destination permissions
- Report specific files that failed

**If service fails to start:**
- Check logs: `journalctl --user -u clawdbot-gateway.service`
- Verify Node.js version
- Check port conflicts
- Report to user with logs

**If rollback is needed:**
- Follow rollback procedure above
- Verify backup integrity first
- Keep Raspberry Pi data for analysis

---

## Special Cases

### If Node.js < 22 on Pi
- Warn user that clawdbot requires Node.js ≥22
- Offer to upgrade: `sudo pacman -S nodejs-lts`
- Don't proceed with older version

### If clawdbot processes won't stop
- Try graceful shutdown first (`pkill -15`)
- Wait 5 seconds
- Force kill if needed (`pkill -9`)
- If still running, ask user to investigate

### If Raspberry Pi not accessible
- Check Tailscale status
- Verify Pi is powered on
- Test ping: `ping 100.68.220.78`
- Ask user to check Pi status

### If disk space insufficient
- Calculate exact requirement
- Ask user to free up space
- Suggest locations to clean

---

## Post-Migration Monitoring

### First 24 Hours
- Check logs every few hours
- Verify messages are sent/received
- Monitor CPU/memory usage
- Test all configured channels

### Commands for Monitoring
```bash
# Live logs
ssh capicuaman@100.68.220.78 "journalctl --user -u clawdbot-gateway.service -f"

# Service status
ssh capicuaman@100.68.220.78 "systemctl --user status clawdbot-gateway.service"

# Resource usage
ssh capicuaman@100.68.220.78 "top -b -n 1 | grep clawdbot"

# Disk usage
ssh capicuaman@100.68.220.78 "du -sh ~/.clawdbot/"
```

### Red Flags
- Service crashes/restarts frequently
- High CPU usage (>50% constant)
- Memory leaks (growing RSS)
- Message delivery failures
- Authentication errors

If any red flags appear, consider rollback.

---

## Summary

**Migration Strategy:** Non-destructive, verified, with rollback capability

**Safety Features:**
- Timestamped backup before migration
- No deletion of local data
- Service verification before declaring success
- Manual cleanup only after user confirmation
- Clear rollback procedure

**Timeline:**
- Migration: ~15-30 minutes
- Verification: 24-48 hours
- Cleanup: After 30 days (optional)

**Success Criteria:**
- Raspberry Pi service running and stable
- All channels functional
- Messages sent/received successfully
- No authentication errors
- No crashes for 24+ hours
