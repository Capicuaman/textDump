#!/bin/bash
# Organize Downloads - Sorts files by type

DOWNLOADS="$HOME/Downloads"
LOG_FILE="$HOME/logs/organize.log"
mkdir -p "$HOME/logs"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# Create organized folders
mkdir -p "$DOWNLOADS/Documents"
mkdir -p "$DOWNLOADS/Images"
mkdir -p "$DOWNLOADS/Videos"
mkdir -p "$DOWNLOADS/Audio"
mkdir -p "$DOWNLOADS/Archives"
mkdir -p "$DOWNLOADS/Code"
mkdir -p "$DOWNLOADS/Other"

log "=== Organizing downloads ==="

# Count files before
BEFORE=$(find "$DOWNLOADS" -maxdepth 1 -type f | wc -l)
log "Files to organize: $BEFORE"

# Documents
find "$DOWNLOADS" -maxdepth 1 -type f \( \
    -iname "*.pdf" -o \
    -iname "*.doc" -o \
    -iname "*.docx" -o \
    -iname "*.txt" -o \
    -iname "*.odt" -o \
    -iname "*.xlsx" -o \
    -iname "*.xls" -o \
    -iname "*.pptx" -o \
    -iname "*.ppt" \
\) -exec mv {} "$DOWNLOADS/Documents/" \; 2>/dev/null

# Images
find "$DOWNLOADS" -maxdepth 1 -type f \( \
    -iname "*.jpg" -o \
    -iname "*.jpeg" -o \
    -iname "*.png" -o \
    -iname "*.gif" -o \
    -iname "*.bmp" -o \
    -iname "*.svg" -o \
    -iname "*.webp" \
\) -exec mv {} "$DOWNLOADS/Images/" \; 2>/dev/null

# Videos
find "$DOWNLOADS" -maxdepth 1 -type f \( \
    -iname "*.mp4" -o \
    -iname "*.mkv" -o \
    -iname "*.avi" -o \
    -iname "*.mov" -o \
    -iname "*.wmv" -o \
    -iname "*.flv" -o \
    -iname "*.webm" \
\) -exec mv {} "$DOWNLOADS/Videos/" \; 2>/dev/null

# Audio
find "$DOWNLOADS" -maxdepth 1 -type f \( \
    -iname "*.mp3" -o \
    -iname "*.wav" -o \
    -iname "*.flac" -o \
    -iname "*.aac" -o \
    -iname "*.ogg" -o \
    -iname "*.m4a" \
\) -exec mv {} "$DOWNLOADS/Audio/" \; 2>/dev/null

# Archives
find "$DOWNLOADS" -maxdepth 1 -type f \( \
    -iname "*.zip" -o \
    -iname "*.tar" -o \
    -iname "*.tar.gz" -o \
    -iname "*.tgz" -o \
    -iname "*.rar" -o \
    -iname "*.7z" -o \
    -iname "*.bz2" -o \
    -iname "*.xz" \
\) -exec mv {} "$DOWNLOADS/Archives/" \; 2>/dev/null

# Code
find "$DOWNLOADS" -maxdepth 1 -type f \( \
    -iname "*.py" -o \
    -iname "*.js" -o \
    -iname "*.html" -o \
    -iname "*.css" -o \
    -iname "*.json" -o \
    -iname "*.xml" -o \
    -iname "*.sh" -o \
    -iname "*.java" -o \
    -iname "*.cpp" -o \
    -iname "*.c" \
\) -exec mv {} "$DOWNLOADS/Code/" \; 2>/dev/null

# Count files after
AFTER=$(find "$DOWNLOADS" -maxdepth 1 -type f | wc -l)
ORGANIZED=$((BEFORE - AFTER))

log "Organized $ORGANIZED files"
log "=== Organization complete ==="

# Optional: Delete files older than 90 days from Downloads
# Uncomment to enable:
# find "$DOWNLOADS" -maxdepth 1 -type f -mtime +90 -delete 2>/dev/null
