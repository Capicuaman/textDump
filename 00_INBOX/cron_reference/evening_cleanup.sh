#!/bin/bash
# Evening Cleanup Script - Run at 8:15pm weekdays

LOG_FILE="$HOME/logs/evening.log"
mkdir -p "$HOME/logs"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

log "=== Evening cleanup started ==="

# 1. Check for uncommitted changes
log "Checking for uncommitted changes..."

check_repo() {
    local repo_path="$1"
    local repo_name=$(basename "$repo_path")

    cd "$repo_path"
    if [ -n "$(git status --short)" ]; then
        log "⚠️  Uncommitted changes in $repo_name:"
        git status --short >> "$LOG_FILE"
        echo "$repo_name has uncommitted changes" >> "$HOME/logs/uncommitted_reminder.txt"
    else
        log "✓ $repo_name is clean"
    fi
}

check_repo "$HOME/Documents/textDump"
check_repo "$HOME/Documents/bilan-mx"
check_repo "$HOME/Documents/bilan-video"

# 2. List today's work from git logs
log "Today's commits:"
TODAY=$(date +%Y-%m-%d)
cd "$HOME/Documents/textDump"
git log --since="$TODAY 00:00" --until="$TODAY 23:59" --oneline >> "$LOG_FILE" 2>&1

# 3. Check if journal was updated today
JOURNAL="$HOME/Documents/textDump/05_JOURNAL/daily-${TODAY}.md"
if [ -f "$JOURNAL" ]; then
    JOURNAL_SIZE=$(wc -l < "$JOURNAL")
    log "✓ Today's journal exists ($JOURNAL_SIZE lines)"
else
    log "⚠️  No journal entry for today"
fi

# 4. Clean up /tmp files older than 3 days
OLD_TMP_COUNT=$(find /tmp -maxdepth 1 -type f -user "$USER" -mtime +3 2>/dev/null | wc -l)
if [ "$OLD_TMP_COUNT" -gt 0 ]; then
    log "Cleaning $OLD_TMP_COUNT old temp files..."
    find /tmp -maxdepth 1 -type f -user "$USER" -mtime +3 -delete 2>/dev/null
fi

# 5. Save list of open applications (for resume tomorrow)
log "Saving workspace state..."
wmctrl -l 2>/dev/null > "$HOME/.workspace_state" || log "wmctrl not available"

log "=== Evening cleanup complete ==="

# Send notification if there are uncommitted changes
if [ -f "$HOME/logs/uncommitted_reminder.txt" ]; then
    REPOS=$(cat "$HOME/logs/uncommitted_reminder.txt")
    notify-send "Uncommitted Changes" "$REPOS" 2>/dev/null
    rm "$HOME/logs/uncommitted_reminder.txt"
fi
