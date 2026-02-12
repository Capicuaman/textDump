#!/bin/bash
# Comprehensive Workflow Dashboard
# Shows status of all automations, repos, and system health

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
REPOS=(
    "$HOME/Documents/textDump"
    "$HOME/Documents/bilan-mx"
    "$HOME/Documents/bilan-video"
)
JOURNAL_DIR="$HOME/Documents/textDump/05_JOURNAL"
LOG_DIR="$HOME/logs"
BACKUP_DIR="$HOME/backups"

print_header() {
    echo -e "\n${CYAN}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║           WORKFLOW AUTOMATION DASHBOARD                       ║${NC}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════════════╝${NC}"
    echo -e "Generated: ${BLUE}$(date '+%Y-%m-%d %H:%M:%S')${NC}\n"
}

print_section() {
    echo -e "\n${MAGENTA}▶ $1${NC}"
    echo "────────────────────────────────────────────────────────"
}

check_cron_status() {
    print_section "CRON SERVICE STATUS"

    if systemctl is-active --quiet cronie; then
        echo -e "Status: ${GREEN}✓ Running${NC}"
    else
        echo -e "Status: ${RED}✗ Not running${NC}"
        return 1
    fi

    # Show cron jobs count
    CRON_COUNT=$(crontab -l 2>/dev/null | grep -v '^#' | grep -v '^$' | wc -l)
    echo "Active jobs: $CRON_COUNT"

    # Next scheduled jobs
    echo -e "\nNext scheduled runs:"
    current_hour=$(date +%H)
    for hour in 10 12 14 16 18 20; do
        if [ $hour -gt $current_hour ]; then
            echo "  • Journal update: Today at ${hour}:00"
            break
        fi
    done
}

check_repositories() {
    print_section "REPOSITORY STATUS"

    for repo in "${REPOS[@]}"; do
        if [ ! -d "$repo" ]; then
            echo -e "${RED}✗${NC} $(basename "$repo"): Not found"
            continue
        fi

        repo_name=$(basename "$repo")
        cd "$repo"

        # Check for uncommitted changes
        UNCOMMITTED=$(git status --short 2>/dev/null | wc -l)
        UNPUSHED=$(git log @{u}.. 2>/dev/null | wc -l)
        LAST_COMMIT=$(git log -1 --format="%h - %ar" 2>/dev/null)

        echo -e "\n${BLUE}$repo_name${NC}"

        if [ $UNCOMMITTED -gt 0 ]; then
            echo -e "  Uncommitted: ${YELLOW}$UNCOMMITTED files${NC}"
        else
            echo -e "  Uncommitted: ${GREEN}Clean${NC}"
        fi

        if [ $UNPUSHED -gt 0 ]; then
            echo -e "  Unpushed: ${YELLOW}$UNPUSHED commits${NC}"
        else
            echo -e "  Unpushed: ${GREEN}Up to date${NC}"
        fi

        echo "  Last commit: $LAST_COMMIT"
    done
}

check_journal_status() {
    print_section "JOURNAL STATUS"

    TODAY=$(date +%Y-%m-%d)
    TODAY_JOURNAL="$JOURNAL_DIR/daily-$TODAY.md"

    if [ -f "$TODAY_JOURNAL" ]; then
        LINES=$(wc -l < "$TODAY_JOURNAL")
        SIZE=$(du -h "$TODAY_JOURNAL" | cut -f1)
        LAST_MODIFIED=$(stat -c %y "$TODAY_JOURNAL" 2>/dev/null | cut -d. -f1 || stat -f %Sm "$TODAY_JOURNAL" 2>/dev/null)

        echo -e "Today's journal: ${GREEN}✓ Exists${NC}"
        echo "  Lines: $LINES"
        echo "  Size: $SIZE"
        echo "  Last updated: $LAST_MODIFIED"

        # Extract activity score if present
        if grep -q "Activity Score" "$TODAY_JOURNAL"; then
            SCORE=$(grep "Activity Score" "$TODAY_JOURNAL" | grep -oP '\d+\.?\d*' | head -1)
            echo "  Activity score: $SCORE"
        fi
    else
        echo -e "Today's journal: ${YELLOW}⚠ Not created yet${NC}"
    fi

    # Recent journals
    echo -e "\nRecent journals:"
    ls -t "$JOURNAL_DIR"/daily-*.md 2>/dev/null | head -5 | while read journal; do
        DATE=$(basename "$journal" | sed 's/daily-\(.*\)\.md/\1/')
        SIZE=$(du -h "$journal" | cut -f1)
        echo "  • $DATE ($SIZE)"
    done

    # Weekly summaries
    WEEKLY_COUNT=$(ls "$JOURNAL_DIR"/weekly-summary-*.md 2>/dev/null | wc -l)
    echo -e "\nWeekly summaries: $WEEKLY_COUNT"
}

check_backups() {
    print_section "BACKUP STATUS"

    if [ ! -d "$BACKUP_DIR" ]; then
        echo -e "${YELLOW}⚠ Backup directory not found${NC}"
        return
    fi

    BACKUP_COUNT=$(ls -d "$BACKUP_DIR"/*/ 2>/dev/null | wc -l)
    echo "Total backups: $BACKUP_COUNT"

    if [ $BACKUP_COUNT -gt 0 ]; then
        LATEST_BACKUP=$(ls -td "$BACKUP_DIR"/*/ 2>/dev/null | head -1)
        BACKUP_NAME=$(basename "$LATEST_BACKUP")
        BACKUP_DATE=$(echo "$BACKUP_NAME" | grep -oP '\d{8}_\d{6}' | sed 's/\([0-9]\{4\}\)\([0-9]\{2\}\)\([0-9]\{2\}\)_\([0-9]\{2\}\)\([0-9]\{2\}\)\([0-9]\{2\}\)/\1-\2-\3 \4:\5:\6/')
        BACKUP_SIZE=$(du -sh "$LATEST_BACKUP" 2>/dev/null | cut -f1)

        echo -e "\nLatest backup:"
        echo "  Date: $BACKUP_DATE"
        echo "  Size: $BACKUP_SIZE"
        echo "  Location: $LATEST_BACKUP"

        # Total backup disk usage
        TOTAL_BACKUP_SIZE=$(du -sh "$BACKUP_DIR" 2>/dev/null | cut -f1)
        echo -e "\nTotal backup space: $TOTAL_BACKUP_SIZE"
    fi
}

check_logs() {
    print_section "LOG STATUS"

    if [ ! -d "$LOG_DIR" ]; then
        echo -e "${YELLOW}⚠ Log directory not found${NC}"
        return
    fi

    TOTAL_LOG_SIZE=$(du -sh "$LOG_DIR" 2>/dev/null | cut -f1)
    LOG_COUNT=$(find "$LOG_DIR" -name "*.log" 2>/dev/null | wc -l)

    echo "Total log files: $LOG_COUNT"
    echo "Total log size: $TOTAL_LOG_SIZE"

    echo -e "\nRecent log activity:"

    # Check each important log
    for log in journal_agent.log morning.log evening.log backup.log; do
        LOG_PATH="$LOG_DIR/$log"
        if [ -f "$LOG_PATH" ]; then
            LAST_ENTRY=$(tail -1 "$LOG_PATH" 2>/dev/null | grep -oP '\[\K[^\]]+' || echo "Unknown")
            echo "  • $log: $LAST_ENTRY"
        fi
    done

    # Check for errors
    echo -e "\nRecent errors:"
    ERROR_COUNT=$(grep -i "error\|fail\|exception" "$LOG_DIR"/*.log 2>/dev/null | wc -l)
    if [ $ERROR_COUNT -gt 0 ]; then
        echo -e "  ${RED}Found $ERROR_COUNT error mentions${NC}"
        grep -i "error\|fail" "$LOG_DIR"/*.log 2>/dev/null | tail -3 | sed 's/^/  /'
    else
        echo -e "  ${GREEN}No recent errors${NC}"
    fi
}

check_system_health() {
    print_section "SYSTEM HEALTH"

    # Disk usage
    DISK_USAGE=$(df -h / | tail -1 | awk '{print $5}' | sed 's/%//')
    DISK_FREE=$(df -h / | tail -1 | awk '{print $4}')

    echo -n "Disk usage: "
    if [ $DISK_USAGE -gt 90 ]; then
        echo -e "${RED}$DISK_USAGE% (${DISK_FREE} free)${NC} ⚠ CRITICAL"
    elif [ $DISK_USAGE -gt 80 ]; then
        echo -e "${YELLOW}$DISK_USAGE% (${DISK_FREE} free)${NC} ⚠ Warning"
    else
        echo -e "${GREEN}$DISK_USAGE% (${DISK_FREE} free)${NC}"
    fi

    # Memory usage
    MEM_USAGE=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100}')
    MEM_FREE=$(free -h | grep Mem | awk '{print $7}')
    echo "Memory usage: $MEM_USAGE% ($MEM_FREE available)"

    # System uptime
    UPTIME=$(uptime -p | sed 's/up //')
    echo "Uptime: $UPTIME"

    # Load average
    LOAD=$(uptime | awk -F'load average:' '{print $2}')
    echo "Load average:$LOAD"
}

show_quick_actions() {
    print_section "QUICK ACTIONS"

    echo "Commands:"
    echo "  crontab -e              Edit cron jobs"
    echo "  crontab -l              List cron jobs"
    echo "  tail -f $LOG_DIR/journal_agent.log   Watch journal log"
    echo "  ~/scripts/morning_setup.sh    Run morning setup"
    echo "  ~/scripts/evening_cleanup.sh  Run evening cleanup"
    echo ""
    echo "Logs:"
    echo "  ls -lh $LOG_DIR/"
    echo ""
    echo "Backups:"
    echo "  ls -lh $BACKUP_DIR/"
}

show_today_summary() {
    print_section "TODAY'S ACTIVITY"

    # Count today's commits across all repos
    TOTAL_COMMITS=0
    for repo in "${REPOS[@]}"; do
        if [ -d "$repo" ]; then
            cd "$repo"
            TODAY_COMMITS=$(git log --since="$(date +%Y-%m-%d) 00:00" --oneline 2>/dev/null | wc -l)
            TOTAL_COMMITS=$((TOTAL_COMMITS + TODAY_COMMITS))

            if [ $TODAY_COMMITS -gt 0 ]; then
                echo "$(basename "$repo"): $TODAY_COMMITS commits"
            fi
        fi
    done

    if [ $TOTAL_COMMITS -eq 0 ]; then
        echo "No commits yet today"
    else
        echo -e "\n${GREEN}Total: $TOTAL_COMMITS commits today${NC}"
    fi
}

# Main execution
clear
print_header
show_today_summary
check_cron_status
check_repositories
check_journal_status
check_backups
check_logs
check_system_health
show_quick_actions

echo -e "\n${CYAN}════════════════════════════════════════════════════════════════${NC}\n"
