# Cron Quick Reference Card

## Cron Expression Syntax
```
 ┌─────── minute (0-59)
 │ ┌────── hour (0-23)
 │ │ ┌───── day of month (1-31)
 │ │ │ ┌──── month (1-12)
 │ │ │ │ ┌─── day of week (0-7, Sun=0 or 7)
 │ │ │ │ │
 * * * * * command
```

## Common Patterns Cheat Sheet

| Pattern | Meaning | Example Use Case |
|---------|---------|------------------|
| `* * * * *` | Every minute | Testing only |
| `0 * * * *` | Every hour | Health checks |
| `*/15 * * * *` | Every 15 minutes | Frequent monitoring |
| `0 9 * * *` | 9am daily | Morning tasks |
| `0 0 * * *` | Midnight daily | Daily maintenance |
| `0 9 * * 1-5` | 9am weekdays | Work-day tasks |
| `0 0 * * 0` | Midnight Sunday | Weekly tasks |
| `0 0 1 * *` | First of month | Monthly tasks |
| `0 10,14,18 * * *` | 10am, 2pm, 6pm | Multiple times |
| `*/2 9-17 * * *` | Every 2h, 9am-5pm | Business hours |

## Essential Commands

```bash
# View cron jobs
crontab -l

# Edit cron jobs
crontab -e

# Remove all cron jobs (CAREFUL!)
crontab -r

# Check cron service status
systemctl status cronie    # Manjaro/Arch
systemctl status cron      # Debian/Ubuntu

# View cron logs
journalctl -u cronie -f    # Follow live
journalctl -u cronie --since "1 hour ago"  # Last hour
```

## Output Redirection

```bash
# Append to log (stdout + stderr)
* * * * * command >> /path/to/log.log 2>&1

# Separate logs
* * * * * command >> /path/to/output.log 2>> /path/to/error.log

# Silence completely
* * * * * command > /dev/null 2>&1

# Email output (requires mail setup)
MAILTO=you@email.com
* * * * * command
```

## Common Issues & Solutions

| Problem | Cause | Solution |
|---------|-------|----------|
| Job doesn't run | Cron service down | `systemctl start cronie` |
| Command not found | Not in PATH | Use full path: `/usr/bin/command` |
| Permission denied | Not executable | `chmod +x script.sh` |
| Wrong timing | Timezone issue | Check `timedatectl` |
| Environment issue | Minimal env | Set PATH/vars in crontab |

## Best Practices

### DO ✓
- Use full paths: `/usr/bin/python3`
- Log all output: `>> log.log 2>&1`
- Test manually first
- Use `flock` to prevent overlaps
- Stagger execution times
- Set environment variables in crontab
- Add comments to explain jobs

### DON'T ✗
- Rely on relative paths
- Assume env variables exist
- Run untested scripts
- Use dangerous commands without safety checks
- Forget about log rotation
- Run resource-heavy tasks during work hours

## Template Cron Entry

```bash
# Description: What this job does
# Runs: When it executes (in plain English)
# Owner: Your name
# Added: Date
0 2 * * * /usr/bin/python3 /full/path/to/script.py --option >> /full/path/to/log.log 2>&1
```

## Quick Diagnostic Commands

```bash
# Is cron running?
systemctl is-active cronie && echo "Running" || echo "Stopped"

# Show my cron jobs
crontab -l | grep -v '^#' | grep -v '^$'

# Check recent cron activity
journalctl -u cronie --since today --no-pager

# Test if command works
/usr/bin/python3 /path/to/script.py --verbose

# Check environment cron sees
* * * * * env > /tmp/cron_env.txt  # Add temporarily

# Test timing with online tool
# Visit: https://crontab.guru/
```

## Performance Tips

```bash
# Lower priority (nice)
0 2 * * * nice -n 19 /path/to/script.sh

# Lower I/O priority (ionice)
0 2 * * * ionice -c3 /path/to/script.sh

# Prevent overlap (flock)
*/5 * * * * flock -n /tmp/job.lock -c '/path/to/script.sh'

# Run only if low load
0 2 * * * [ $(uptime | awk '{print $10}' | cut -d, -f1) < 2.0 ] && /path/to/script.sh

# Timeout after 1 hour
0 2 * * * timeout 3600 /path/to/script.sh
```

## Your Current Setup (Reminder)

```bash
# Journal automation - every 2 hours
0 10,12,14,16,18,20 * * * /usr/bin/python3 ~/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation/journal_agent.py --live >> ~/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation/cron.log 2>&1

# Check current jobs
crontab -l

# View journal automation log
tail -f ~/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation/cron.log
```

## Emergency Commands

```bash
# Disable all cron jobs temporarily
sudo systemctl stop cronie

# Re-enable
sudo systemctl start cronie

# View all system cron jobs
sudo cat /etc/crontab
ls -la /etc/cron.d/
ls -la /etc/cron.daily/

# Kill runaway cron job
ps aux | grep script_name
kill -9 PID
```

## Useful Scripts Location

```bash
# Your scripts
~/scripts/

# Logs
~/logs/

# Backups
~/backups/

# Test framework
bash ~/scripts/cron_test_framework.sh
```

## Online Resources

- **Crontab Guru:** https://crontab.guru/ - Visual cron tester
- **Generator:** https://crontab-generator.org/ - Build expressions
- **Arch Wiki:** https://wiki.archlinux.org/title/Cron - Comprehensive guide
- **Man Pages:** `man cron`, `man crontab`, `man 5 crontab`

## Save This Quick Reference

```bash
# Print to terminal
cat ~/CRON_QUICK_REFERENCE.md

# Save to your docs
cp /tmp/CRON_QUICK_REFERENCE.md ~/Documents/

# View in less
less ~/Documents/CRON_QUICK_REFERENCE.md
```

---

**Print this out or bookmark it for quick access!**

*Last updated: 2026-02-11*
