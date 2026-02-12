# Personalized Cron Workflow Recommendations

Based on your setup (Manjaro, work hours 10am-8pm, 3 git repos), here are optimized automation recommendations.

## Tier 1: Essential Automations (Implement Now)

### 1. Journal Automation ✅ ALREADY INSTALLED
```cron
0 10,12,14,16,18,20 * * * /usr/bin/python3 /home/capicuaman/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation/journal_agent.py --live >> /home/capicuaman/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation/cron.log 2>&1
```
**Status:** Already running! Tracks git activity every 2 hours.

### 2. Daily Backup (Critical)
```cron
0 2 * * * /home/capicuaman/scripts/git_backup.sh
```
**Why:** Protects your work. Runs at 2am when you're asleep.
**What it does:**
- Creates tarball + git bundle of all 3 repos
- Keeps last 7 backups (auto-rotates)
- Takes ~1-2 minutes

### 3. Evening Uncommitted Changes Alert
```cron
15 20 * * 1-5 /home/capicuaman/scripts/evening_cleanup.sh
```
**Why:** Reminds you to commit before ending the workday.
**What it does:**
- Checks all 3 repos for uncommitted changes
- Sends desktop notification if found
- Logs today's commits
- Runs at 8:15pm (15 min after your work ends)

## Tier 2: Productivity Boosters (Highly Recommended)

### 4. Morning Workspace Setup
```cron
45 9 * * 1-5 /home/capicuaman/scripts/morning_setup.sh
```
**Why:** Start your day with fresh repo data and system checks.
**What it does:**
- Fetches git updates from remotes (doesn't merge)
- Checks disk space (alerts if >90%)
- Shows available system updates
- Checks for uncommitted work
- Runs at 9:45am (15 min before work starts)

### 5. Downloads Organization
```cron
0 23 * * * /home/capicuaman/scripts/organize_downloads.sh
```
**Why:** Keep Downloads folder clean automatically.
**What it does:**
- Sorts files into Documents/Images/Videos/Archives folders
- Runs at 11pm daily
- Handles 20+ file types

### 6. Git Fetch Updates (Stay Current)
```cron
0 */3 * * * cd /home/capicuaman/Documents/textDump && git fetch --all >> /home/capicuaman/logs/git_fetch.log 2>&1
```
**Why:** Always know if remote has new commits (doesn't change your code).
**What it does:**
- Fetches from all remotes every 3 hours
- Non-destructive (just downloads refs)
- Lets you see if you're behind

## Tier 3: Nice-to-Have Enhancements

### 7. Break Reminders (Health)
```cron
0 */2 10-20 * * 1-5 notify-send "Break Time" "Stand up and stretch! 🧘" 2>/dev/null
```
**Why:** Prevent RSI and eye strain.
**Runs:** Every 2 hours during work hours, weekdays only.

### 8. Weekly Git Garbage Collection
```cron
0 3 * * 0 cd /home/capicuaman/Documents/textDump && git gc --auto >> /home/capicuaman/logs/git_gc.log 2>&1
```
**Why:** Keeps git repos optimized and fast.
**Runs:** Sunday 3am weekly.

### 9. System Update Check
```cron
0 6 * * * /usr/bin/pacman -Sy >> /home/capicuaman/logs/pacman_sync.log 2>&1
```
**Why:** Stay current with Manjaro updates.
**Runs:** 6am daily (just syncs database, doesn't install).

### 10. Monthly Review Reminder
```cron
0 9 1 * * notify-send "Monthly Review" "Time to review last month's journals!" 2>/dev/null
```
**Why:** Helps with reflection and goal tracking.
**Runs:** First day of each month at 9am.

## Recommended Crontab (Copy-Paste Ready)

```cron
# ============================================
# WORKFLOW AUTOMATION CRONTAB
# ============================================

# Environment
SHELL=/bin/bash
PATH=/usr/local/bin:/usr/bin:/bin
HOME=/home/capicuaman

# ============================================
# TIER 1: ESSENTIAL (HIGH PRIORITY)
# ============================================

# Journal automation (ALREADY INSTALLED)
0 10,12,14,16,18,20 * * * /usr/bin/python3 /home/capicuaman/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation/journal_agent.py --live >> /home/capicuaman/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation/cron.log 2>&1

# Daily git backup at 2am
0 2 * * * /home/capicuaman/scripts/git_backup.sh

# Evening cleanup at 8:15pm weekdays
15 20 * * 1-5 /home/capicuaman/scripts/evening_cleanup.sh

# ============================================
# TIER 2: PRODUCTIVITY (RECOMMENDED)
# ============================================

# Morning setup at 9:45am weekdays
45 9 * * 1-5 /home/capicuaman/scripts/morning_setup.sh

# Organize downloads at 11pm daily
0 23 * * * /home/capicuaman/scripts/organize_downloads.sh

# Fetch git updates every 3 hours
0 */3 * * * cd /home/capicuaman/Documents/textDump && git fetch --all >> /home/capicuaman/logs/git_fetch.log 2>&1

# ============================================
# TIER 3: ENHANCEMENTS (OPTIONAL)
# ============================================

# Break reminder every 2 hours during work
0 */2 10-20 * * 1-5 notify-send "Break Time" "Stand up and stretch!" 2>/dev/null

# Weekly git maintenance Sunday 3am
0 3 * * 0 cd /home/capicuaman/Documents/textDump && git gc --auto >> /home/capicuaman/logs/git_gc.log 2>&1

# System update check daily 6am
0 6 * * * /usr/bin/pacman -Sy >> /home/capicuaman/logs/pacman_sync.log 2>&1

# Monthly review reminder
0 9 1 * * notify-send "Monthly Review" "Time to review last month's journals!" 2>/dev/null
```

## Installation Steps

1. **Run the installer:**
   ```bash
   bash /tmp/install_cron_automations.sh
   ```

2. **Test scripts manually:**
   ```bash
   ~/scripts/morning_setup.sh
   ~/scripts/evening_cleanup.sh
   ~/scripts/organize_downloads.sh
   ~/scripts/git_backup.sh
   ```

3. **Add to crontab:**
   ```bash
   crontab -e
   # Copy-paste the recommended crontab above
   ```

4. **Verify installation:**
   ```bash
   crontab -l
   ```

## Monitoring Your Automations

### Quick Health Check
```bash
# View all logs
ls -lh ~/logs/

# Check recent journal automation
tail ~/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation/cron.log

# Check backup status
tail ~/logs/backup.log

# Check morning setup
tail ~/logs/morning.log

# Check evening cleanup
tail ~/logs/evening.log
```

### Create a Dashboard Script
Save as `~/scripts/cron_dashboard.sh`:
```bash
#!/bin/bash
echo "=== Cron Automation Dashboard ==="
echo "Generated: $(date)"
echo ""

echo "📅 Next cron runs:"
echo "Next journal update: $(date -d 'today 14:00' 2>/dev/null || echo 'N/A')"
echo "Next backup: $(date -d 'tomorrow 02:00' 2>/dev/null || echo 'N/A')"
echo ""

echo "📊 Recent activity:"
echo "Journal runs today: $(grep -c "$(date +%Y-%m-%d)" ~/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation/cron.log 2>/dev/null || echo 0)"
echo "Last backup: $(ls -lt ~/backups/ | head -2 | tail -1 | awk '{print $6,$7,$8}')"
echo ""

echo "💾 Storage:"
echo "Home: $(df -h /home | tail -1 | awk '{print $5}')"
echo "Backups: $(du -sh ~/backups 2>/dev/null | cut -f1)"
echo "Logs: $(du -sh ~/logs 2>/dev/null | cut -f1)"
echo ""

echo "⚠️  Warnings:"
git -C ~/Documents/textDump status --short | head -3
```

Run: `bash ~/scripts/cron_dashboard.sh`

## Log Rotation (Prevent Disk Bloat)

Add to `/etc/logrotate.d/user_cron`:
```
/home/capicuaman/logs/*.log {
    weekly
    rotate 4
    compress
    missingok
    notifempty
}
```

Or manual rotation cron:
```cron
0 0 * * 0 find /home/capicuaman/logs -name "*.log" -mtime +30 -exec gzip {} \;
```

## Resource Impact

| Automation | CPU | Disk I/O | Runtime | Impact |
|------------|-----|----------|---------|--------|
| Journal agent | Low | Low | 1-3s | Minimal |
| Morning setup | Low | Medium | 5-10s | Minimal |
| Evening cleanup | Low | Low | 2-5s | Minimal |
| Downloads org | Low | Medium | 1-5s | Minimal |
| Git backup | Medium | High | 30-60s | Low (runs at 2am) |
| Git fetch | Low | Low | 1-2s | Minimal |

**Total overhead:** <5 minutes/day, mostly during off-hours.

## Advanced: Conditional Execution

### Only backup if changes exist:
```bash
#!/bin/bash
cd ~/Documents/textDump
if [ -n "$(git status --short)" ] || [ "$(git log --since='24 hours ago' --oneline | wc -l)" -gt 0 ]; then
    ~/scripts/git_backup.sh
fi
```

### Skip weekends for work reminders:
```cron
# Already handled with: * * * * 1-5 (Mon-Fri only)
```

### Run only if on AC power:
```bash
# Check battery status first
if [ "$(acpi -a | grep -c on-line)" -eq 1 ]; then
    ~/scripts/expensive_operation.sh
fi
```

## Troubleshooting Quick Reference

| Issue | Check | Solution |
|-------|-------|----------|
| Script not running | `journalctl -u cronie -f` | Verify cron service running |
| Wrong time | `date && timedatectl` | Check timezone |
| Permission denied | `ls -la ~/scripts/*.sh` | `chmod +x script.sh` |
| Output not visible | Check log file | Add `>> log.log 2>&1` |
| Path not found | `which command` | Use full path in cron |

## Next Steps

1. ✅ Install scripts: `bash /tmp/install_cron_automations.sh`
2. ✅ Test manually: Run each script
3. ✅ Add Tier 1 jobs to crontab
4. ⏳ Monitor for 1 week
5. ⏳ Add Tier 2 jobs if working well
6. ⏳ Customize timing based on your preference

## Questions to Consider

- **Backup destination:** Do you have an external drive for backups?
- **Email notifications:** Want email summaries instead of/in addition to desktop notifications?
- **Work schedule changes:** Adjust times if your hours shift?
- **Additional repos:** Have other git repos to track?

Let me know if you want help with any customizations!
