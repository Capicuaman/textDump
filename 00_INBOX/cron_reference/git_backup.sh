#!/bin/bash
# Comprehensive Git Backup Script

BACKUP_BASE="$HOME/backups"
LOG_FILE="$HOME/logs/backup.log"
DATE=$(date +%Y%m%d_%H%M%S)

mkdir -p "$BACKUP_BASE"
mkdir -p "$HOME/logs"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

backup_repo() {
    local repo_path="$1"
    local repo_name=$(basename "$repo_path")

    log "Backing up $repo_name..."

    # Check if repo exists
    if [ ! -d "$repo_path" ]; then
        log "ERROR: $repo_path does not exist"
        return 1
    fi

    # Create backup directory
    BACKUP_DIR="$BACKUP_BASE/${repo_name}_${DATE}"
    mkdir -p "$BACKUP_DIR"

    # 1. Create tarball of entire repo (including .git)
    log "Creating archive..."
    tar -czf "$BACKUP_DIR/${repo_name}.tar.gz" -C "$(dirname "$repo_path")" "$(basename "$repo_path")" 2>> "$LOG_FILE"

    # 2. Export git bundle (compact git repo backup)
    log "Creating git bundle..."
    cd "$repo_path"
    git bundle create "$BACKUP_DIR/${repo_name}.bundle" --all 2>> "$LOG_FILE"

    # 3. Save git log
    log "Saving git log..."
    git log --all --oneline > "$BACKUP_DIR/${repo_name}_log.txt"

    # 4. Save git status
    git status > "$BACKUP_DIR/${repo_name}_status.txt"

    # 5. List all branches
    git branch -a > "$BACKUP_DIR/${repo_name}_branches.txt"

    # Get sizes
    TARBALL_SIZE=$(du -h "$BACKUP_DIR/${repo_name}.tar.gz" | cut -f1)
    BUNDLE_SIZE=$(du -h "$BACKUP_DIR/${repo_name}.bundle" | cut -f1)

    log "✓ $repo_name backup complete (tarball: $TARBALL_SIZE, bundle: $BUNDLE_SIZE)"

    # Keep only last 7 backups
    log "Cleaning old backups (keeping last 7)..."
    ls -t "$BACKUP_BASE" | grep "^${repo_name}_" | tail -n +8 | xargs -I {} rm -rf "$BACKUP_BASE/{}" 2>/dev/null

    return 0
}

log "==================================="
log "=== Starting backup process ==="
log "==================================="

# Backup all your repos
backup_repo "$HOME/Documents/textDump"
backup_repo "$HOME/Documents/bilan-mx"
backup_repo "$HOME/Documents/bilan-video"

# Calculate total backup size
TOTAL_SIZE=$(du -sh "$BACKUP_BASE" | cut -f1)
log "Total backup size: $TOTAL_SIZE"

# Check if backup drive is mounted (optional)
if [ -d "/media/backup_drive" ]; then
    log "Copying to external backup drive..."
    rsync -av --delete "$BACKUP_BASE/" "/media/backup_drive/git_backups/" >> "$LOG_FILE" 2>&1
    log "External backup complete"
else
    log "External backup drive not mounted"
fi

log "=== Backup process complete ==="
log "==================================="

# Send notification
notify-send "Backup Complete" "Git repositories backed up successfully" 2>/dev/null

exit 0
