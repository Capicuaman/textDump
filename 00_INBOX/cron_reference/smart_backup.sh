#!/bin/bash
# Smart Backup - Only runs if there's new activity

BACKUP_BASE="$HOME/backups"
LOG_FILE="$HOME/logs/smart_backup.log"
LAST_BACKUP_MARKER="$HOME/.last_backup_commit"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Function to get latest commit hash from a repo
get_latest_commit() {
    local repo="$1"
    cd "$repo" && git rev-parse HEAD 2>/dev/null
}

# Function to check if repo has new commits since last backup
has_new_commits() {
    local repo="$1"
    local repo_name=$(basename "$repo")
    local current_commit=$(get_latest_commit "$repo")
    local last_backed_up=$(grep "^${repo_name}:" "$LAST_BACKUP_MARKER" 2>/dev/null | cut -d: -f2)

    if [ -z "$last_backed_up" ] || [ "$current_commit" != "$last_backed_up" ]; then
        return 0  # Has new commits
    else
        return 1  # No changes
    fi
}

# Function to record backup
record_backup() {
    local repo="$1"
    local repo_name=$(basename "$repo")
    local commit=$(get_latest_commit "$repo")

    # Remove old entry and add new one
    grep -v "^${repo_name}:" "$LAST_BACKUP_MARKER" > "${LAST_BACKUP_MARKER}.tmp" 2>/dev/null
    echo "${repo_name}:${commit}" >> "${LAST_BACKUP_MARKER}.tmp"
    mv "${LAST_BACKUP_MARKER}.tmp" "$LAST_BACKUP_MARKER"
}

log "=== Smart backup check started ==="

REPOS=(
    "$HOME/Documents/textDump"
    "$HOME/Documents/bilan-mx"
    "$HOME/Documents/bilan-video"
)

BACKUP_NEEDED=false

# Check each repo
for repo in "${REPOS[@]}"; do
    repo_name=$(basename "$repo")

    if [ ! -d "$repo" ]; then
        log "⚠️  Repository not found: $repo"
        continue
    fi

    if has_new_commits "$repo"; then
        log "✓ New commits in $repo_name - backup needed"
        BACKUP_NEEDED=true
    else
        log "○ No changes in $repo_name since last backup"
    fi
done

if [ "$BACKUP_NEEDED" = true ]; then
    log "📦 Starting backup (changes detected)..."

    # Run the actual backup
    if [ -f "$HOME/scripts/git_backup.sh" ]; then
        bash "$HOME/scripts/git_backup.sh"
        BACKUP_STATUS=$?

        if [ $BACKUP_STATUS -eq 0 ]; then
            # Record successful backup
            for repo in "${REPOS[@]}"; do
                record_backup "$repo"
            done
            log "✅ Backup completed and recorded"
        else
            log "❌ Backup failed with status $BACKUP_STATUS"
        fi
    else
        log "❌ Backup script not found"
    fi
else
    log "⏭️  Skipping backup - no new commits"
fi

log "=== Smart backup check complete ==="
