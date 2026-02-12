#!/bin/bash
# Example script with proper logging for cron

LOG_FILE="/var/log/myscript.log"
ERROR_LOG="/var/log/myscript_error.log"

# Function to log with timestamp
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log_error() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $1" | tee -a "$ERROR_LOG"
}

# Main script
log "Script started"

# Your commands here
if ! some_command; then
    log_error "Command failed"
    exit 1
fi

log "Script completed successfully"
exit 0
