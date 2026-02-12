# Cron Performance Optimization & Best Practices

## Resource Management

### 1. Prevent Resource Hogging

**Use `nice` and `ionice` for low-priority tasks:**
```bash
# Reduce CPU priority (nice values: -20 to 19, higher = lower priority)
0 2 * * * nice -n 19 /path/to/backup.sh

# Reduce I/O priority (ionice classes: 1=realtime, 2=best-effort, 3=idle)
0 2 * * * ionice -c3 /path/to/backup.sh

# Combine both
0 2 * * * nice -n 19 ionice -c3 /path/to/heavy_task.sh
```

**Limit memory usage with `ulimit`:**
```bash
# Limit to 512MB RAM
0 2 * * * bash -c 'ulimit -v 524288 && /path/to/script.sh'

# Limit CPU time to 1 hour
0 2 * * * bash -c 'ulimit -t 3600 && /path/to/script.sh'
```

### 2. Prevent Overlapping Executions

**Method 1: Using `flock` (recommended)**
```bash
# Only one instance can run at a time
*/5 * * * * flock -n /tmp/myjob.lock -c '/path/to/script.sh' || echo "Job already running" >> /tmp/skipped.log
```

**Method 2: Using PID file**
```bash
#!/bin/bash
# script_with_lock.sh

PIDFILE="/tmp/myscript.pid"

# Check if already running
if [ -f "$PIDFILE" ] && kill -0 $(cat "$PIDFILE") 2>/dev/null; then
    echo "Script already running"
    exit 1
fi

# Create PID file
echo $$ > "$PIDFILE"

# Ensure cleanup on exit
trap "rm -f $PIDFILE" EXIT

# Your actual work here
/path/to/actual/work

# PID file is automatically removed by trap
```

### 3. Stagger Execution Times

**Bad: All backups start at midnight**
```bash
0 0 * * * backup_textDump.sh
0 0 * * * backup_bilan_mx.sh
0 0 * * * backup_bilan_video.sh
```

**Good: Staggered to spread load**
```bash
0 2 * * * backup_textDump.sh      # 2:00 AM
15 2 * * * backup_bilan_mx.sh     # 2:15 AM
30 2 * * * backup_bilan_video.sh  # 2:30 AM
```

### 4. Conditional Execution Based on System Load

```bash
#!/bin/bash
# run_if_low_load.sh

MAX_LOAD=2.0
CURRENT_LOAD=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | sed 's/,//')

if (( $(echo "$CURRENT_LOAD < $MAX_LOAD" | bc -l) )); then
    /path/to/intensive_task.sh
else
    echo "Load too high ($CURRENT_LOAD), skipping" >> /tmp/deferred.log
fi
```

### 5. Battery-Aware Execution (for laptops)

```bash
#!/bin/bash
# run_on_ac_power.sh

# Only run if on AC power
if [ "$(acpi -a 2>/dev/null | grep -c on-line)" -eq 1 ]; then
    /path/to/power_intensive_task.sh
else
    echo "On battery power, skipping" >> /tmp/battery_skip.log
fi
```

## Optimization Strategies

### 6. Batch Similar Operations

**Bad: Multiple git fetches**
```bash
0 * * * * cd ~/Documents/textDump && git fetch
0 * * * * cd ~/Documents/bilan-mx && git fetch
0 * * * * cd ~/Documents/bilan-video && git fetch
```

**Good: Single script batches them**
```bash
0 * * * * ~/scripts/fetch_all_repos.sh
```

Where `fetch_all_repos.sh`:
```bash
#!/bin/bash
for repo in ~/Documents/textDump ~/Documents/bilan-mx ~/Documents/bilan-video; do
    cd "$repo" && git fetch --all &
done
wait  # Wait for all background processes
```

### 7. Use Tmpfs for Temporary Files

**Speed up operations with RAM-based temp storage:**
```bash
#!/bin/bash
# Use /tmp (often tmpfs) for intermediate files

TEMP_DIR="/tmp/mywork_$$"
mkdir -p "$TEMP_DIR"
trap "rm -rf $TEMP_DIR" EXIT

# Do work with temp files
process_data > "$TEMP_DIR/intermediate.txt"
final_output "$TEMP_DIR/intermediate.txt" > /final/location/output.txt

# Cleanup handled by trap
```

### 8. Incremental Processing

**Bad: Process everything every time**
```bash
# Processes all 10,000 files every run
0 * * * * find ~/Documents -name "*.txt" -exec process_file {} \;
```

**Good: Only process new/changed files**
```bash
#!/bin/bash
# process_new_files.sh

MARKER_FILE="$HOME/.last_process_time"

# Find files modified since last run
if [ -f "$MARKER_FILE" ]; then
    find ~/Documents -name "*.txt" -newer "$MARKER_FILE" -exec process_file {} \;
else
    find ~/Documents -name "*.txt" -exec process_file {} \;
fi

# Update marker
touch "$MARKER_FILE"
```

### 9. Parallel Processing

```bash
#!/bin/bash
# parallel_backup.sh

# Use GNU parallel or xargs for parallel execution
find ~/Documents -type d -name ".git" | \
    parallel -j 3 'cd {//} && git gc --auto' || \
    xargs -I {} -P 3 bash -c 'cd {}/.. && git gc --auto'

# -j 3 or -P 3 = run 3 jobs in parallel
```

### 10. Compress Logs On-The-Fly

**Bad: Large uncompressed logs**
```bash
0 * * * * /path/to/script.sh >> /var/log/huge.log 2>&1
```

**Good: Compress old logs, rotate current**
```bash
#!/bin/bash
# log_with_rotation.sh

LOG_FILE="/var/log/myapp.log"
MAX_SIZE=10485760  # 10MB in bytes

if [ -f "$LOG_FILE" ] && [ $(stat -f%z "$LOG_FILE" 2>/dev/null || stat -c%s "$LOG_FILE") -gt $MAX_SIZE ]; then
    # Compress and rotate
    gzip -c "$LOG_FILE" > "$LOG_FILE.$(date +%Y%m%d_%H%M%S).gz"
    > "$LOG_FILE"  # Truncate current log
fi

# Now log normally
echo "[$(date)] Log entry" >> "$LOG_FILE"
```

## Security Best Practices

### 11. Secure Credential Handling

**Bad: Credentials in crontab**
```bash
0 2 * * * curl -u user:password https://api.example.com/backup
```

**Good: Use environment file**
```bash
# In crontab
0 2 * * * source ~/.env && /path/to/backup.sh

# In ~/.env (chmod 600)
export API_KEY="your_key_here"
export DB_PASSWORD="your_password"

# In backup.sh
curl -H "Authorization: Bearer $API_KEY" https://api.example.com/backup
```

**Better: Use system keyring**
```bash
# Store credentials securely
secret-tool store --label="API Key" service myapp key api_key

# Retrieve in script
API_KEY=$(secret-tool lookup service myapp key api_key)
```

### 12. Validate Input and Paths

```bash
#!/bin/bash
# secure_script.sh

# Validate paths before using
BACKUP_DIR="$HOME/backups"

if [[ ! "$BACKUP_DIR" =~ ^/home/[a-z]+/backups$ ]]; then
    echo "Invalid backup directory" >&2
    exit 1
fi

# Sanitize user input if any
safe_filename=$(echo "$USER_INPUT" | tr -cd '[:alnum:]._-')
```

### 13. Limit Permissions

```bash
# Scripts should not be world-writable
chmod 750 ~/scripts/*.sh  # rwxr-x---

# Logs should not be world-readable if sensitive
chmod 640 ~/logs/*.log    # rw-r-----

# Crontab should be user-only
# (automatically enforced by cron)
```

### 14. Audit Trail

```bash
#!/bin/bash
# Add comprehensive logging

LOG_FILE="/var/log/myapp.log"

log_action() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$USER] [$$] $1" >> "$LOG_FILE"
}

log_action "Script started"
# Do work
log_action "Processed 100 files"
log_action "Script completed"
```

## Monitoring & Alerting

### 15. Health Check Script

```bash
#!/bin/bash
# cron_health_check.sh - Run daily to verify all jobs working

ALERT_EMAIL="your@email.com"
ALERT_THRESHOLD=24  # Hours

check_log_freshness() {
    local logfile="$1"
    local name="$2"

    if [ ! -f "$logfile" ]; then
        echo "ALERT: $name log missing"
        return 1
    fi

    # Check if log was updated in last 24 hours
    local age=$(find "$logfile" -mtime +1 | wc -l)
    if [ $age -gt 0 ]; then
        echo "ALERT: $name log not updated in 24+ hours"
        return 1
    fi

    return 0
}

ISSUES=""
check_log_freshness "$HOME/logs/journal_agent.log" "Journal" || ISSUES="$ISSUES\n- Journal agent"
check_log_freshness "$HOME/logs/backup.log" "Backup" || ISSUES="$ISSUES\n- Backup"

if [ -n "$ISSUES" ]; then
    echo -e "Cron health check failed:$ISSUES" | mail -s "Cron Alert" "$ALERT_EMAIL"
fi
```

### 16. Performance Metrics

```bash
#!/bin/bash
# track_performance.sh

METRICS_FILE="$HOME/logs/cron_metrics.csv"

# Initialize CSV if doesn't exist
if [ ! -f "$METRICS_FILE" ]; then
    echo "timestamp,job_name,duration_seconds,exit_code,cpu_percent,mem_kb" > "$METRICS_FILE"
fi

run_with_metrics() {
    local job_name="$1"
    shift
    local start_time=$(date +%s)

    # Run command and capture metrics
    /usr/bin/time -f "%U %S %M" -o /tmp/time_$$.txt "$@"
    local exit_code=$?

    local end_time=$(date +%s)
    local duration=$((end_time - start_time))

    # Parse time output
    read cpu_user cpu_sys mem_kb < /tmp/time_$$.txt
    local cpu_percent=$(echo "scale=2; ($cpu_user + $cpu_sys) / $duration * 100" | bc)

    # Log metrics
    echo "$(date +%s),$job_name,$duration,$exit_code,$cpu_percent,$mem_kb" >> "$METRICS_FILE"

    rm /tmp/time_$$.txt
    return $exit_code
}

# Usage in cron:
# 0 2 * * * /path/to/track_performance.sh backup /path/to/backup.sh
```

## Specific Optimizations for Your Workflow

### 17. Journal Agent Optimization

```bash
# Current (runs every 2 hours regardless)
0 10,12,14,16,18,20 * * * /usr/bin/python3 .../journal_agent.py --live

# Optimized (only runs if there are commits)
0 10,12,14,16,18,20 * * * [ $(cd ~/Documents/textDump && git log --since="2 hours ago" --oneline | wc -l) -gt 0 ] && /usr/bin/python3 .../journal_agent.py --live
```

### 18. Git Operations Optimization

```bash
#!/bin/bash
# optimized_git_fetch.sh

# Fetch all repos in parallel with timeout
timeout 30s git -C ~/Documents/textDump fetch --all &
timeout 30s git -C ~/Documents/bilan-mx fetch --all &
timeout 30s git -C ~/Documents/bilan-video fetch --all &
wait

# Total time: max 30 seconds instead of 3x fetch time
```

### 19. Smart Backup Scheduling

```bash
# Differential backup (faster, more frequent)
0 */6 * * * ~/scripts/differential_backup.sh

# Full backup (slower, less frequent)
0 3 * * 0 ~/scripts/full_backup.sh
```

## Resource Limits Reference

```bash
# Set in crontab or script
SHELL=/bin/bash
PATH=/usr/local/bin:/usr/bin:/bin

# Limit virtual memory to 1GB
0 2 * * * bash -c 'ulimit -v 1048576 && /path/to/script.sh'

# Limit file size to 100MB
0 2 * * * bash -c 'ulimit -f 102400 && /path/to/script.sh'

# Limit CPU time to 30 minutes
0 2 * * * bash -c 'ulimit -t 1800 && /path/to/script.sh'

# Limit number of processes to 50
0 2 * * * bash -c 'ulimit -u 50 && /path/to/script.sh'

# Combine multiple limits
0 2 * * * bash -c 'ulimit -v 1048576 -t 1800 -f 102400 && /path/to/script.sh'
```

## Debugging Performance Issues

### Find slow cron jobs
```bash
# Add timing to all jobs
* * * * * START=$(date +%s); /path/to/job; END=$(date +%s); echo "Duration: $((END-START))s" >> /tmp/timing.log

# Or use wrapper script
* * * * * ~/scripts/time_job.sh /path/to/actual_job
```

### Monitor system during cron execution
```bash
# Run this in a separate terminal
watch -n 1 'ps aux | grep -E "cron|backup|journal" | grep -v grep'
```

### Check I/O wait
```bash
# High iowait indicates disk bottleneck
iostat -x 1
```

## Quick Wins Checklist

- [ ] Use `flock` to prevent overlapping jobs
- [ ] Stagger execution times by 5-15 minutes
- [ ] Add `nice -n 19` to low-priority tasks
- [ ] Compress old log files
- [ ] Use incremental processing where possible
- [ ] Batch similar operations together
- [ ] Run heavy tasks during off-hours (2-4 AM)
- [ ] Set resource limits on long-running jobs
- [ ] Monitor log file sizes weekly
- [ ] Test scripts manually before adding to cron
- [ ] Add comprehensive error logging
- [ ] Set up health check monitoring
- [ ] Use conditional execution for expensive operations
- [ ] Parallel process independent tasks
- [ ] Keep scripts modular and testable
