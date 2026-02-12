#!/bin/bash
# Morning Setup Script - Run at 9:45am weekdays

LOG_FILE="$HOME/logs/morning.log"
mkdir -p "$HOME/logs"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

log "=== Morning setup started ==="

# 1. Fetch latest changes from all repos
log "Fetching git updates..."
cd "$HOME/Documents/textDump" && git fetch --all 2>&1 | head -5 >> "$LOG_FILE"
cd "$HOME/Documents/bilan-mx" && git fetch --all 2>&1 | head -5 >> "$LOG_FILE"
cd "$HOME/Documents/bilan-video" && git fetch --all 2>&1 | head -5 >> "$LOG_FILE"

# 2. Check disk space
DISK_USAGE=$(df -h / | tail -1 | awk '{print $5}' | sed 's/%//')
log "Disk usage: ${DISK_USAGE}%"
if [ "$DISK_USAGE" -gt 90 ]; then
    log "WARNING: Disk usage above 90%!"
    notify-send "Disk Space Warning" "Your disk is ${DISK_USAGE}% full"
fi

# 3. Check for system updates (don't install, just check)
UPDATES=$(checkupdates 2>/dev/null | wc -l)
log "Available updates: $UPDATES"

# 4. Open today's journal (if it exists)
TODAY=$(date +%Y-%m-%d)
JOURNAL="$HOME/Documents/textDump/05_JOURNAL/daily-${TODAY}.md"
if [ -f "$JOURNAL" ]; then
    log "Today's journal exists: $JOURNAL"
else
    log "No journal yet for today"
fi

# 5. Show git status for main repo
cd "$HOME/Documents/textDump"
UNCOMMITTED=$(git status --short | wc -l)
if [ "$UNCOMMITTED" -gt 0 ]; then
    log "WARNING: $UNCOMMITTED uncommitted changes in textDump"
fi

log "=== Morning setup complete ==="

# Optional: Send desktop notification
notify-send "Morning Setup Complete" "All systems checked. Have a productive day!" 2>/dev/null
