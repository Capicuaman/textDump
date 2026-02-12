#!/bin/bash
# Master Installation Script for Cron Automations
# Run this to set up all workflow automation scripts

set -e  # Exit on error

SCRIPT_DIR="$HOME/scripts"
LOG_DIR="$HOME/logs"
BACKUP_DIR="$HOME/backups"

echo "==================================="
echo "Cron Automation Setup"
echo "==================================="
echo ""

# Create directories
echo "Creating directories..."
mkdir -p "$SCRIPT_DIR"
mkdir -p "$LOG_DIR"
mkdir -p "$BACKUP_DIR"
echo "✓ Directories created"

# Copy scripts to proper location
echo ""
echo "Installing scripts to $SCRIPT_DIR..."

cat > "$SCRIPT_DIR/morning_setup.sh" << 'MORNING_EOF'
#!/bin/bash
# Morning Setup Script - Run at 9:45am weekdays

LOG_FILE="$HOME/logs/morning.log"
mkdir -p "$HOME/logs"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

log "=== Morning setup started ==="

# Fetch latest changes from all repos
log "Fetching git updates..."
cd "$HOME/Documents/textDump" && git fetch --all 2>&1 | head -5 >> "$LOG_FILE"
cd "$HOME/Documents/bilan-mx" && git fetch --all 2>&1 | head -5 >> "$LOG_FILE"
cd "$HOME/Documents/bilan-video" && git fetch --all 2>&1 | head -5 >> "$LOG_FILE"

# Check disk space
DISK_USAGE=$(df -h / | tail -1 | awk '{print $5}' | sed 's/%//')
log "Disk usage: ${DISK_USAGE}%"
if [ "$DISK_USAGE" -gt 90 ]; then
    log "WARNING: Disk usage above 90%!"
    notify-send "Disk Space Warning" "Your disk is ${DISK_USAGE}% full"
fi

# Check for system updates
UPDATES=$(checkupdates 2>/dev/null | wc -l)
log "Available updates: $UPDATES"

# Check git status for main repo
cd "$HOME/Documents/textDump"
UNCOMMITTED=$(git status --short | wc -l)
if [ "$UNCOMMITTED" -gt 0 ]; then
    log "WARNING: $UNCOMMITTED uncommitted changes in textDump"
fi

log "=== Morning setup complete ==="
notify-send "Morning Setup Complete" "All systems checked. Have a productive day!" 2>/dev/null
MORNING_EOF

cat > "$SCRIPT_DIR/evening_cleanup.sh" << 'EVENING_EOF'
#!/bin/bash
# Evening Cleanup Script

LOG_FILE="$HOME/logs/evening.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

log "=== Evening cleanup started ==="

check_repo() {
    local repo_path="$1"
    local repo_name=$(basename "$repo_path")

    cd "$repo_path"
    if [ -n "$(git status --short)" ]; then
        log "⚠️  Uncommitted changes in $repo_name"
        git status --short >> "$LOG_FILE"
        echo "$repo_name has uncommitted changes" >> "$HOME/logs/uncommitted_reminder.txt"
    else
        log "✓ $repo_name is clean"
    fi
}

check_repo "$HOME/Documents/textDump"
check_repo "$HOME/Documents/bilan-mx"
check_repo "$HOME/Documents/bilan-video"

# Check today's journal
TODAY=$(date +%Y-%m-%d)
JOURNAL="$HOME/Documents/textDump/05_JOURNAL/daily-${TODAY}.md"
if [ -f "$JOURNAL" ]; then
    log "✓ Today's journal exists"
else
    log "⚠️  No journal entry for today"
fi

log "=== Evening cleanup complete ==="

if [ -f "$HOME/logs/uncommitted_reminder.txt" ]; then
    REPOS=$(cat "$HOME/logs/uncommitted_reminder.txt")
    notify-send "Uncommitted Changes" "$REPOS" 2>/dev/null
    rm "$HOME/logs/uncommitted_reminder.txt"
fi
EVENING_EOF

cat > "$SCRIPT_DIR/organize_downloads.sh" << 'ORGANIZE_EOF'
#!/bin/bash
# Organize Downloads by file type

DOWNLOADS="$HOME/Downloads"
LOG_FILE="$HOME/logs/organize.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Create organized folders
mkdir -p "$DOWNLOADS"/{Documents,Images,Videos,Audio,Archives,Code}

log "=== Organizing downloads ==="

BEFORE=$(find "$DOWNLOADS" -maxdepth 1 -type f 2>/dev/null | wc -l)

# Documents
find "$DOWNLOADS" -maxdepth 1 -type f \( -iname "*.pdf" -o -iname "*.doc" -o -iname "*.docx" -o -iname "*.txt" \) -exec mv {} "$DOWNLOADS/Documents/" \; 2>/dev/null

# Images
find "$DOWNLOADS" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.gif" \) -exec mv {} "$DOWNLOADS/Images/" \; 2>/dev/null

# Videos
find "$DOWNLOADS" -maxdepth 1 -type f \( -iname "*.mp4" -o -iname "*.mkv" -o -iname "*.avi" \) -exec mv {} "$DOWNLOADS/Videos/" \; 2>/dev/null

# Archives
find "$DOWNLOADS" -maxdepth 1 -type f \( -iname "*.zip" -o -iname "*.tar.gz" -o -iname "*.rar" \) -exec mv {} "$DOWNLOADS/Archives/" \; 2>/dev/null

AFTER=$(find "$DOWNLOADS" -maxdepth 1 -type f 2>/dev/null | wc -l)
ORGANIZED=$((BEFORE - AFTER))

log "Organized $ORGANIZED files"
ORGANIZE_EOF

cat > "$SCRIPT_DIR/git_backup.sh" << 'BACKUP_EOF'
#!/bin/bash
# Git Backup Script

BACKUP_BASE="$HOME/backups"
LOG_FILE="$HOME/logs/backup.log"
DATE=$(date +%Y%m%d_%H%M%S)

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

backup_repo() {
    local repo_path="$1"
    local repo_name=$(basename "$repo_path")

    log "Backing up $repo_name..."

    BACKUP_DIR="$BACKUP_BASE/${repo_name}_${DATE}"
    mkdir -p "$BACKUP_DIR"

    tar -czf "$BACKUP_DIR/${repo_name}.tar.gz" -C "$(dirname "$repo_path")" "$(basename "$repo_path")" 2>> "$LOG_FILE"

    cd "$repo_path"
    git bundle create "$BACKUP_DIR/${repo_name}.bundle" --all 2>> "$LOG_FILE"

    log "✓ $repo_name backup complete"

    # Keep only last 7 backups
    ls -t "$BACKUP_BASE" | grep "^${repo_name}_" | tail -n +8 | xargs -I {} rm -rf "$BACKUP_BASE/{}" 2>/dev/null
}

log "=== Starting backup ==="
backup_repo "$HOME/Documents/textDump"
backup_repo "$HOME/Documents/bilan-mx"
backup_repo "$HOME/Documents/bilan-video"
log "=== Backup complete ==="

notify-send "Backup Complete" "Git repositories backed up" 2>/dev/null
BACKUP_EOF

# Make all scripts executable
chmod +x "$SCRIPT_DIR"/*.sh
echo "✓ Scripts installed and made executable"

# Show current crontab
echo ""
echo "Current crontab:"
crontab -l 2>/dev/null || echo "(empty)"

echo ""
echo "==================================="
echo "Installation Complete!"
echo "==================================="
echo ""
echo "Scripts installed in: $SCRIPT_DIR"
echo "Logs will be in: $LOG_DIR"
echo "Backups will be in: $BACKUP_DIR"
echo ""
echo "Next steps:"
echo "1. Review the scripts in $SCRIPT_DIR"
echo "2. Test them manually:"
echo "   $SCRIPT_DIR/morning_setup.sh"
echo "   $SCRIPT_DIR/evening_cleanup.sh"
echo ""
echo "3. Add to crontab with: crontab -e"
echo ""
echo "Suggested cron entries:"
echo "# Morning setup - 9:45am weekdays"
echo "45 9 * * 1-5 $SCRIPT_DIR/morning_setup.sh"
echo ""
echo "# Evening cleanup - 8:15pm weekdays"
echo "15 20 * * 1-5 $SCRIPT_DIR/evening_cleanup.sh"
echo ""
echo "# Organize downloads - 11pm daily"
echo "0 23 * * * $SCRIPT_DIR/organize_downloads.sh"
echo ""
echo "# Git backup - 2am daily"
echo "0 2 * * * $SCRIPT_DIR/git_backup.sh"
echo ""
echo "==================================="
