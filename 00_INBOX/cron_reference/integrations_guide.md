# Cron Integrations with External Services

## Notification Services

### 1. Desktop Notifications (notify-send)

**Already available on your Manjaro system:**
```bash
# Simple notification
* * * * * notify-send "Title" "Message"

# With icon
* * * * * notify-send -i dialog-information "Backup Complete" "All files backed up successfully"

# With urgency level
* * * * * notify-send -u critical "Disk Space Warning" "Only 5GB remaining"

# Notification that stays until dismissed
* * * * * notify-send -t 0 "Important" "This stays until you close it"
```

**Example: End of workday reminder**
```bash
45 19 * * 1-5 DISPLAY=:0 notify-send -u normal "Work Day Ending" "Time to wrap up and commit your work!"
```

### 2. Email Notifications

**Setup using msmtp (lightweight SMTP client):**
```bash
# Install
sudo pacman -S msmtp msmtp-mta

# Configure ~/.msmtprc (chmod 600)
account default
host smtp.gmail.com
port 587
auth on
user your.email@gmail.com
password your_app_password
from your.email@gmail.com
tls on
tls_starttls on
```

**Usage in cron:**
```bash
# Simple email
0 2 * * * /path/to/backup.sh && echo "Backup completed" | mail -s "Backup Success" you@email.com

# Email log file
0 2 * * * /path/to/script.sh >> /tmp/log.txt 2>&1 && cat /tmp/log.txt | mail -s "Daily Report" you@email.com

# Email only on failure
0 2 * * * /path/to/script.sh || echo "Script failed!" | mail -s "ALERT: Script Failed" you@email.com
```

### 3. Telegram Bot Integration

**Setup:**
```bash
# Get bot token from @BotFather on Telegram
# Get your chat ID from @userinfobot

# Create send_telegram.sh
#!/bin/bash
BOT_TOKEN="your_bot_token_here"
CHAT_ID="your_chat_id_here"
MESSAGE="$1"

curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
    -d chat_id="${CHAT_ID}" \
    -d text="${MESSAGE}" \
    -d parse_mode="Markdown" > /dev/null
```

**Usage:**
```bash
# Send notification on completion
0 2 * * * /path/to/backup.sh && ~/scripts/send_telegram.sh "✅ Backup completed successfully"

# Send on failure
0 2 * * * /path/to/backup.sh || ~/scripts/send_telegram.sh "❌ Backup failed!"
```

### 4. Discord Webhook

```bash
#!/bin/bash
# send_discord.sh

WEBHOOK_URL="your_discord_webhook_url"
MESSAGE="$1"

curl -H "Content-Type: application/json" \
    -X POST \
    -d "{\"content\": \"${MESSAGE}\"}" \
    "${WEBHOOK_URL}"
```

**Usage:**
```bash
0 2 * * * /path/to/backup.sh && ~/scripts/send_discord.sh "Backup completed at $(date)"
```

### 5. Slack Integration

```bash
#!/bin/bash
# send_slack.sh

WEBHOOK_URL="your_slack_webhook_url"
MESSAGE="$1"

curl -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"${MESSAGE}\"}" \
    "${WEBHOOK_URL}"
```

## Cloud Storage Integration

### 6. Rclone (Any Cloud Provider)

**Setup rclone for Google Drive, Dropbox, etc.:**
```bash
# Install
sudo pacman -S rclone

# Configure (interactive)
rclone config
```

**Backup to cloud:**
```bash
# Sync backups to Google Drive every day at 3am
0 3 * * * rclone sync ~/backups/ gdrive:backups/ --log-file ~/logs/rclone.log

# Copy journals to Dropbox
0 23 * * * rclone copy ~/Documents/textDump/05_JOURNAL/ dropbox:journals/ --include "daily-*.md"
```

### 7. Syncthing Integration

**Auto-sync journals across devices:**
```bash
# Ensure Syncthing is running and syncing
*/30 * * * * systemctl --user is-active syncthing || systemctl --user start syncthing

# Check sync status
0 */6 * * * ~/scripts/check_syncthing_status.sh
```

### 8. Git Push Automation

**Auto-push journals:**
```bash
#!/bin/bash
# auto_push_journals.sh

cd ~/Documents/textDump

# Check if there are changes
if [ -n "$(git status --porcelain 05_JOURNAL/)" ]; then
    git add 05_JOURNAL/
    git commit -m "Auto-update journals $(date '+%Y-%m-%d %H:%M')"
    git push origin main
fi
```

**Cron entry:**
```bash
# Auto-commit and push journals at end of day
0 21 * * * ~/scripts/auto_push_journals.sh >> ~/logs/auto_push.log 2>&1
```

## Monitoring & Analytics

### 9. HealthChecks.io Integration

**Free monitoring service that alerts if cron jobs don't run:**
```bash
# Get unique URL from healthchecks.io for each job

# Ping on success
0 2 * * * /path/to/backup.sh && curl -fsS -m 10 --retry 5 https://hc-ping.com/your-unique-id > /dev/null

# Report failure
0 2 * * * /path/to/backup.sh && curl -fsS -m 10 --retry 5 https://hc-ping.com/your-unique-id > /dev/null || curl -fsS -m 10 --retry 5 https://hc-ping.com/your-unique-id/fail > /dev/null
```

### 10. Prometheus Node Exporter

**Export cron metrics:**
```bash
#!/bin/bash
# cron_exporter.sh - Write metrics for Prometheus

METRICS_FILE="/var/lib/node_exporter/textfile_collector/cron.prom"

echo "# HELP cron_job_last_success_timestamp Unix timestamp of last successful run" > "$METRICS_FILE"
echo "# TYPE cron_job_last_success_timestamp gauge" >> "$METRICS_FILE"
echo "cron_job_last_success_timestamp{job=\"backup\"} $(date +%s)" >> "$METRICS_FILE"
```

### 11. Grafana Cloud / InfluxDB

**Send timing metrics:**
```bash
#!/bin/bash
# send_metrics.sh

INFLUX_URL="your_influxdb_url"
INFLUX_TOKEN="your_token"
JOB_NAME="$1"
DURATION="$2"
STATUS="$3"

curl -XPOST "${INFLUX_URL}/api/v2/write?org=your_org&bucket=cron_metrics" \
    -H "Authorization: Token ${INFLUX_TOKEN}" \
    --data-binary "cron_job,name=${JOB_NAME} duration=${DURATION},status=${STATUS} $(date +%s)000000000"
```

## API Integrations

### 12. GitHub API - Auto-create Issues

**Create issue for failed backups:**
```bash
#!/bin/bash
# create_github_issue.sh

GITHUB_TOKEN="your_token"
REPO="username/repo"
TITLE="$1"
BODY="$2"

curl -X POST \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/${REPO}/issues" \
    -d "{\"title\":\"${TITLE}\",\"body\":\"${BODY}\"}"
```

**Usage:**
```bash
0 2 * * * /path/to/backup.sh || ~/scripts/create_github_issue.sh "Backup Failed" "Backup failed on $(date)"
```

### 13. Notion API Integration

**Log completed tasks to Notion:**
```bash
#!/bin/bash
# log_to_notion.sh

NOTION_TOKEN="your_notion_integration_token"
DATABASE_ID="your_database_id"
TASK_NAME="$1"
STATUS="$2"

curl -X POST https://api.notion.com/v1/pages \
    -H "Authorization: Bearer ${NOTION_TOKEN}" \
    -H "Content-Type: application/json" \
    -H "Notion-Version: 2022-06-28" \
    --data "{
        \"parent\": {\"database_id\": \"${DATABASE_ID}\"},
        \"properties\": {
            \"Name\": {\"title\": [{\"text\": {\"content\": \"${TASK_NAME}\"}}]},
            \"Status\": {\"select\": {\"name\": \"${STATUS}\"}},
            \"Date\": {\"date\": {\"start\": \"$(date -I)\"}}
        }
    }"
```

### 14. Todoist API - Task Management

**Create tasks from cron:**
```bash
#!/bin/bash
# add_todoist_task.sh

API_TOKEN="your_todoist_api_token"
TASK_CONTENT="$1"

curl -X POST https://api.todoist.com/rest/v2/tasks \
    -H "Authorization: Bearer ${API_TOKEN}" \
    -H "Content-Type: application/json" \
    -d "{\"content\": \"${TASK_CONTENT}\"}"
```

## Database Operations

### 15. PostgreSQL Automated Backups

```bash
#!/bin/bash
# postgres_backup.sh

BACKUP_DIR="$HOME/db_backups"
DATE=$(date +%Y%m%d_%H%M%S)
DB_NAME="your_database"

mkdir -p "$BACKUP_DIR"

# Backup with compression
pg_dump "$DB_NAME" | gzip > "$BACKUP_DIR/${DB_NAME}_${DATE}.sql.gz"

# Keep only last 30 days
find "$BACKUP_DIR" -name "*.sql.gz" -mtime +30 -delete

# Upload to cloud
rclone copy "$BACKUP_DIR/${DB_NAME}_${DATE}.sql.gz" gdrive:db_backups/
```

**Cron:**
```bash
0 1 * * * ~/scripts/postgres_backup.sh
```

### 16. MongoDB Backups

```bash
#!/bin/bash
# mongodb_backup.sh

BACKUP_DIR="$HOME/db_backups/mongo"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p "$BACKUP_DIR"

mongodump --out "$BACKUP_DIR/${DATE}"
tar -czf "$BACKUP_DIR/${DATE}.tar.gz" -C "$BACKUP_DIR" "${DATE}"
rm -rf "$BACKUP_DIR/${DATE}"

# Retention
find "$BACKUP_DIR" -name "*.tar.gz" -mtime +30 -delete
```

## Web Scraping & Data Collection

### 17. Automated Web Scraping

```bash
#!/bin/bash
# daily_scrape.sh

OUTPUT_DIR="$HOME/scraped_data"
DATE=$(date +%Y-%m-%d)

mkdir -p "$OUTPUT_DIR"

# Scrape with Python
python3 << 'EOF'
import requests
from bs4 import BeautifulSoup
import json

url = "https://example.com/data"
response = requests.get(url)
soup = BeautifulSoup(response.content, 'html.parser')

data = {
    'date': '${DATE}',
    'items': [item.text for item in soup.find_all('div', class_='item')]
}

with open('${OUTPUT_DIR}/${DATE}.json', 'w') as f:
    json.dump(data, f)
EOF
```

**Cron:**
```bash
0 8 * * * ~/scripts/daily_scrape.sh
```

## System Integration

### 18. Systemd Integration

**Trigger systemd timer from cron:**
```bash
# Start a systemd service
0 2 * * * systemctl --user start my-backup.service

# Check service status
*/5 * * * * systemctl --user is-failed my-service && ~/scripts/alert.sh "Service failed"
```

### 19. Docker Container Management

```bash
#!/bin/bash
# docker_cleanup.sh

# Remove stopped containers
docker container prune -f

# Remove unused images
docker image prune -a -f --filter "until=72h"

# Remove unused volumes
docker volume prune -f

# Log stats
docker system df >> ~/logs/docker_cleanup.log
```

**Cron:**
```bash
0 3 * * 0 ~/scripts/docker_cleanup.sh
```

### 20. Network Monitoring

```bash
#!/bin/bash
# check_internet.sh

if ! ping -c 1 8.8.8.8 > /dev/null 2>&1; then
    notify-send -u critical "Network Down" "Internet connection lost!"
    echo "[$(date)] Internet down" >> ~/logs/network.log

    # Try to restart network
    nmcli networking off && nmcli networking on
fi
```

**Cron:**
```bash
*/5 * * * * ~/scripts/check_internet.sh
```

## Custom Integrations for Your Workflow

### 21. Journal to Obsidian Sync

```bash
#!/bin/bash
# sync_to_obsidian.sh

JOURNAL_DIR="$HOME/Documents/textDump/05_JOURNAL"
OBSIDIAN_DIR="$HOME/Documents/Obsidian/Daily Notes"

# Copy today's journal to Obsidian vault
TODAY=$(date +%Y-%m-%d)
if [ -f "$JOURNAL_DIR/daily-${TODAY}.md" ]; then
    cp "$JOURNAL_DIR/daily-${TODAY}.md" "$OBSIDIAN_DIR/${TODAY}.md"
fi
```

### 22. Commit Stats to Dashboard

```bash
#!/bin/bash
# update_commit_dashboard.sh

REPOS=(
    "$HOME/Documents/textDump"
    "$HOME/Documents/bilan-mx"
    "$HOME/Documents/bilan-video"
)

OUTPUT="$HOME/public_html/stats.json"

# Generate JSON stats
cat > "$OUTPUT" << EOF
{
    "generated": "$(date -Iseconds)",
    "repos": [
EOF

FIRST=true
for repo in "${REPOS[@]}"; do
    cd "$repo"
    COMMITS_TODAY=$(git log --since="$(date +%Y-%m-%d) 00:00" --oneline | wc -l)
    COMMITS_WEEK=$(git log --since="7 days ago" --oneline | wc -l)

    [ "$FIRST" = false ] && echo "," >> "$OUTPUT"
    cat >> "$OUTPUT" << EOF
        {
            "name": "$(basename "$repo")",
            "commits_today": $COMMITS_TODAY,
            "commits_week": $COMMITS_WEEK
        }
EOF
    FIRST=false
done

cat >> "$OUTPUT" << EOF
    ]
}
EOF
```

### 23. AI Summary Integration (Using OpenAI API)

```bash
#!/bin/bash
# ai_journal_summary.sh

OPENAI_API_KEY="your_api_key"
TODAY=$(date +%Y-%m-%d)
JOURNAL="$HOME/Documents/textDump/05_JOURNAL/daily-${TODAY}.md"

if [ ! -f "$JOURNAL" ]; then
    exit 0
fi

JOURNAL_CONTENT=$(cat "$JOURNAL")

# Get AI summary
SUMMARY=$(curl -s https://api.openai.com/v1/chat/completions \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer ${OPENAI_API_KEY}" \
    -d '{
        "model": "gpt-4",
        "messages": [
            {"role": "system", "content": "Summarize this daily journal in 3 bullet points."},
            {"role": "user", "content": "'"${JOURNAL_CONTENT}"'"}
        ]
    }' | jq -r '.choices[0].message.content')

# Send summary via notification
notify-send "Daily Summary" "$SUMMARY"
```

## Integration Testing Script

```bash
#!/bin/bash
# test_integrations.sh - Test all your integrations

echo "Testing integrations..."

# Test notify-send
notify-send "Test" "Desktop notification working" && echo "✓ Desktop notifications" || echo "✗ Desktop notifications"

# Test email
echo "Test email" | mail -s "Test" your@email.com && echo "✓ Email" || echo "✗ Email"

# Test rclone
rclone lsf gdrive: > /dev/null 2>&1 && echo "✓ Rclone" || echo "✗ Rclone"

# Test Telegram
~/scripts/send_telegram.sh "Test message" && echo "✓ Telegram" || echo "✗ Telegram"

# Test network
ping -c 1 8.8.8.8 > /dev/null 2>&1 && echo "✓ Network" || echo "✗ Network"

echo "Integration test complete"
```

## Environment Variables for Integrations

Create `~/.cron_env`:
```bash
# API Keys and Tokens
export OPENAI_API_KEY="your_key"
export TELEGRAM_BOT_TOKEN="your_token"
export TELEGRAM_CHAT_ID="your_id"
export GITHUB_TOKEN="your_token"
export NOTION_TOKEN="your_token"
export DISCORD_WEBHOOK="your_webhook"
export SLACK_WEBHOOK="your_webhook"

# Database credentials
export PGPASSWORD="your_password"
export MONGO_URI="mongodb://localhost:27017"

# Cloud storage
export RCLONE_CONFIG="$HOME/.config/rclone/rclone.conf"

# Email
export EMAIL_ADDRESS="your@email.com"
```

**Usage in crontab:**
```bash
# Source environment before running
0 2 * * * source ~/.cron_env && ~/scripts/backup.sh
```

## Quick Start: Essential Integrations

1. **Desktop Notifications** (already available)
2. **Cloud Backup** (rclone to Google Drive/Dropbox)
3. **Health Monitoring** (healthchecks.io)
4. **Email Alerts** (msmtp setup)
5. **Git Auto-push** (journals and important files)

These 5 integrations cover 80% of workflow automation needs!
