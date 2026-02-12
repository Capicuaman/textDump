# Cron Job Debugging Guide

## Common Issues & Solutions

### 1. Cron Job Not Running At All

**Check cron service is running:**
```bash
systemctl status cronie    # Manjaro/Arch
# or
systemctl status cron      # Debian/Ubuntu
```

**Enable cron if it's disabled:**
```bash
sudo systemctl enable --now cronie
```

**Check cron logs:**
```bash
# System cron log (Manjaro/Arch)
journalctl -u cronie -f

# Check for your jobs specifically
grep CRON /var/log/syslog    # Debian/Ubuntu
journalctl | grep CRON       # Systemd-based systems
```

**Verify crontab syntax:**
```bash
crontab -l    # Check current crontab
```

### 2. Command Runs But Fails

**Use full paths:**
```bash
# BAD
* * * * * python script.py

# GOOD
* * * * * /usr/bin/python3 /home/user/script.py
```

**Check command works manually:**
```bash
# Run the exact command from cron
/usr/bin/python3 /home/user/script.py

# Or source environment and test
bash -c "source ~/.bashrc && your_command"
```

**Add verbose logging:**
```bash
* * * * * /path/to/script.sh >> /tmp/debug.log 2>&1
```

**Debug environment issues:**
```bash
# Add this as a cron job to see what environment cron has
* * * * * env > /tmp/cron_env.txt
```

Then compare with your regular shell:
```bash
env > /tmp/shell_env.txt
diff /tmp/cron_env.txt /tmp/shell_env.txt
```

### 3. Permission Issues

**Check file permissions:**
```bash
ls -la /path/to/script.sh    # Should be readable/executable
chmod +x /path/to/script.sh  # Make executable
```

**Check directory permissions:**
```bash
# Cron needs access to parent directories too
ls -la /path/to/
```

**SELinux issues (if applicable):**
```bash
# Check SELinux status
getenforce

# View SELinux denials
ausearch -m avc -ts recent
```

### 4. Timing Issues

**Test cron timing with a simple job:**
```bash
# Add this to test if cron runs at all
* * * * * date >> /tmp/cron_test.log
```

Wait a minute, then check:
```bash
cat /tmp/cron_test.log
```

**Check system time:**
```bash
date              # Current time
timedatectl       # Time zone info
```

**Cron uses system timezone:**
```bash
# Set timezone in crontab if needed
CRON_TZ=America/New_York
0 9 * * * command
```

### 5. Output/Logging Issues

**Redirect both stdout and stderr:**
```bash
* * * * * command >> /tmp/output.log 2>&1
```

**Separate error log:**
```bash
* * * * * command >> /tmp/output.log 2>> /tmp/error.log
```

**Verbose script logging:**
```bash
#!/bin/bash
set -x  # Print each command before executing
exec 2>&1  # Redirect stderr to stdout

# Your commands here
```

### 6. Email/Notification Issues

**Set MAILTO in crontab:**
```bash
MAILTO=your@email.com
* * * * * command
```

**Disable email (silence output):**
```bash
* * * * * command > /dev/null 2>&1
```

**Check mail:**
```bash
mail          # Read system mail
cat /var/mail/$USER
```

## Testing & Validation Tools

### Crontab Syntax Validator

**Online tools:**
- https://crontab.guru/ - Visual cron expression validator
- https://crontab-generator.org/ - Generate cron expressions

**Command line validation:**
```bash
# Use a cron expression tester script
# Save as test_cron.sh:
#!/bin/bash
read -p "Enter cron expression: " expression
echo "$expression /bin/true" | crontab -
sleep 65  # Wait for potential execution
crontab -r
echo "Test complete. Check logs."
```

### Monitoring Script

Create `/usr/local/bin/cron-monitor`:
```bash
#!/bin/bash
# Monitor cron job execution

LOGDIR="$HOME/logs"
mkdir -p "$LOGDIR"

echo "=== Cron Job Monitor ==="
echo "Time: $(date)"
echo ""

echo "Recent cron executions:"
journalctl -u cronie --since "1 hour ago" --no-pager | grep -i cron

echo ""
echo "Your crontab:"
crontab -l

echo ""
echo "Log files in $LOGDIR:"
ls -lh "$LOGDIR"

echo ""
echo "Disk space:"
df -h /home
```

Make executable: `chmod +x /usr/local/bin/cron-monitor`

Run: `cron-monitor`

## Best Practices Checklist

- [ ] Use absolute paths for commands and files
- [ ] Set PATH and other env vars at top of crontab
- [ ] Log all output (stdout and stderr)
- [ ] Test commands manually before adding to cron
- [ ] Use meaningful log file names with dates
- [ ] Set up log rotation for long-running jobs
- [ ] Add comments to explain what each job does
- [ ] Use flock to prevent overlapping executions
- [ ] Monitor disk space used by logs
- [ ] Test recovery from failures

## Advanced Debugging

### Enable detailed cron logging

Edit `/etc/rsyslog.conf` or `/etc/rsyslog.d/50-default.conf`:
```bash
# Uncomment this line:
cron.*                          /var/log/cron.log
```

Restart rsyslog:
```bash
sudo systemctl restart rsyslog
```

### Prevent overlapping jobs

Use flock:
```bash
* * * * * flock -n /tmp/myjob.lock -c '/path/to/script.sh'
```

This ensures only one instance runs at a time.

### Run job only if previous succeeded

Create a wrapper script:
```bash
#!/bin/bash
LOCKFILE="/tmp/myjob.lock"
LASTRUN="/tmp/myjob.lastrun"

# Check if last run was successful
if [ -f "$LASTRUN" ]; then
    LAST_STATUS=$(cat "$LASTRUN")
    if [ "$LAST_STATUS" != "0" ]; then
        echo "Previous run failed. Skipping."
        exit 1
    fi
fi

# Run job
/path/to/actual/script.sh
STATUS=$?

# Save status
echo $STATUS > "$LASTRUN"
exit $STATUS
```

## Quick Troubleshooting Commands

```bash
# 1. Check if cron is running
systemctl status cronie

# 2. View your crontab
crontab -l

# 3. Check recent cron activity
journalctl -u cronie --since "1 hour ago"

# 4. Test command manually
/usr/bin/python3 /path/to/script.py --verbose

# 5. Check permissions
ls -la /path/to/script.py

# 6. View cron environment
* * * * * env > /tmp/cron_env.txt

# 7. Simple test job
* * * * * echo "Cron works! $(date)" >> /tmp/cron_test.log

# 8. Check system time
date && timedatectl

# 9. Monitor logs in real-time
tail -f /var/log/cron.log
# or
journalctl -u cronie -f

# 10. Validate cron syntax
echo "0 10,12,14,16,18,20 * * * command" | crontab -
```

## Common Error Messages

| Error | Cause | Solution |
|-------|-------|----------|
| `command not found` | Not in PATH | Use full path: `/usr/bin/command` |
| `Permission denied` | Not executable | `chmod +x script.sh` |
| `No such file or directory` | Wrong path or file doesn't exist | Verify path, use absolute paths |
| `MAILTO: Cannot send mail` | Mail system not configured | Add `> /dev/null 2>&1` to silence |
| `Syntax error` | Invalid cron expression | Check with crontab.guru |
| Job runs but doesn't work | Environment issues | Set PATH/vars in crontab |
