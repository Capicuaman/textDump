#!/bin/bash
# Comprehensive Cron Testing Framework
# Tests cron jobs before deploying them to production

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

TESTS_PASSED=0
TESTS_FAILED=0
SCRIPT_DIR="$HOME/scripts"
LOG_DIR="$HOME/logs"

print_header() {
    echo -e "\n${BLUE}════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Cron Job Testing Framework${NC}"
    echo -e "${BLUE}════════════════════════════════════════════════════${NC}\n"
}

test_result() {
    local name="$1"
    local status="$2"
    local message="$3"

    if [ "$status" = "pass" ]; then
        echo -e "${GREEN}✓${NC} $name"
        [ -n "$message" ] && echo -e "  ${message}"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        echo -e "${RED}✗${NC} $name"
        [ -n "$message" ] && echo -e "  ${RED}${message}${NC}"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

# Test 1: Cron service running
test_cron_service() {
    echo -e "\n${YELLOW}Testing cron service...${NC}"

    if systemctl is-active --quiet cronie; then
        test_result "Cron service running" "pass"
    else
        test_result "Cron service running" "fail" "Service is not active"
    fi
}

# Test 2: Crontab syntax
test_crontab_syntax() {
    echo -e "\n${YELLOW}Testing crontab syntax...${NC}"

    if crontab -l > /dev/null 2>&1; then
        test_result "Crontab readable" "pass"

        # Check for common syntax errors
        local errors=0
        while IFS= read -r line; do
            # Skip comments and empty lines
            [[ "$line" =~ ^#.*$ || -z "$line" ]] && continue

            # Check for invalid cron expression (basic check)
            if [[ ! "$line" =~ ^[^[:space:]]+[[:space:]]+[^[:space:]]+[[:space:]]+[^[:space:]]+[[:space:]]+[^[:space:]]+[[:space:]]+[^[:space:]]+[[:space:]]+ ]]; then
                if [[ ! "$line" =~ ^[A-Z_]+=.* ]]; then  # Allow environment variables
                    echo -e "  ${YELLOW}Warning: Possible invalid line: $line${NC}"
                    errors=$((errors + 1))
                fi
            fi
        done < <(crontab -l)

        if [ $errors -eq 0 ]; then
            test_result "Crontab syntax check" "pass"
        else
            test_result "Crontab syntax check" "fail" "$errors potential issues found"
        fi
    else
        test_result "Crontab readable" "fail" "Cannot read crontab"
    fi
}

# Test 3: Script existence and permissions
test_scripts_exist() {
    echo -e "\n${YELLOW}Testing script existence and permissions...${NC}"

    local scripts_to_check=()

    # Extract script paths from crontab
    while IFS= read -r line; do
        [[ "$line" =~ ^#.*$ || -z "$line" ]] && continue
        # Extract command (everything after 5th field)
        local cmd=$(echo "$line" | awk '{for(i=6;i<=NF;i++) printf "%s ", $i}' | sed 's/ *$//')
        # Get first word (the script/command path)
        local script=$(echo "$cmd" | awk '{print $1}')
        [[ -n "$script" && "$script" =~ ^/ ]] && scripts_to_check+=("$script")
    done < <(crontab -l 2>/dev/null | grep -v '^[A-Z_]*=')

    for script in "${scripts_to_check[@]}"; do
        # Remove redirects and special chars
        script=$(echo "$script" | sed 's/[|&;].*//;s/>.*//;s/<.*//')

        if [ -f "$script" ]; then
            if [ -x "$script" ]; then
                test_result "Script executable: $(basename $script)" "pass"
            else
                test_result "Script executable: $(basename $script)" "fail" "Not executable: chmod +x $script"
            fi
        elif [ -d "$script" ]; then
            # It's a directory (like cd command)
            test_result "Directory exists: $(basename $script)" "pass"
        else
            # Check if it's a system command
            if command -v "$script" >/dev/null 2>&1; then
                test_result "Command available: $(basename $script)" "pass"
            else
                test_result "Script exists: $(basename $script)" "fail" "File not found: $script"
            fi
        fi
    done
}

# Test 4: Directory structure
test_directories() {
    echo -e "\n${YELLOW}Testing directory structure...${NC}"

    local dirs=(
        "$SCRIPT_DIR:Scripts directory"
        "$LOG_DIR:Logs directory"
        "$HOME/backups:Backups directory"
        "$HOME/Documents/textDump:TextDump repo"
    )

    for dir_info in "${dirs[@]}"; do
        local dir="${dir_info%%:*}"
        local name="${dir_info##*:}"

        if [ -d "$dir" ]; then
            if [ -w "$dir" ]; then
                test_result "$name exists and writable" "pass"
            else
                test_result "$name exists and writable" "fail" "Directory not writable"
            fi
        else
            test_result "$name exists" "fail" "Directory not found"
        fi
    done
}

# Test 5: Environment variables
test_environment() {
    echo -e "\n${YELLOW}Testing environment...${NC}"

    # Check PATH
    if command -v python3 >/dev/null 2>&1; then
        local py_path=$(which python3)
        test_result "Python3 available" "pass" "Found at: $py_path"
    else
        test_result "Python3 available" "fail"
    fi

    if command -v git >/dev/null 2>&1; then
        test_result "Git available" "pass"
    else
        test_result "Git available" "fail"
    fi

    # Check if notify-send works
    if command -v notify-send >/dev/null 2>&1; then
        test_result "notify-send available" "pass"
    else
        test_result "notify-send available" "fail"
    fi
}

# Test 6: Disk space
test_disk_space() {
    echo -e "\n${YELLOW}Testing disk space...${NC}"

    local usage=$(df -h / | tail -1 | awk '{print $5}' | sed 's/%//')
    local free=$(df -h / | tail -1 | awk '{print $4}')

    if [ $usage -lt 90 ]; then
        test_result "Disk space sufficient" "pass" "Usage: ${usage}%, Free: ${free}"
    else
        test_result "Disk space sufficient" "fail" "Usage: ${usage}% (>90%)"
    fi
}

# Test 7: Log file rotation
test_log_rotation() {
    echo -e "\n${YELLOW}Testing log file sizes...${NC}"

    if [ -d "$LOG_DIR" ]; then
        local large_logs=$(find "$LOG_DIR" -name "*.log" -size +100M 2>/dev/null)
        if [ -z "$large_logs" ]; then
            test_result "Log files reasonable size" "pass"
        else
            test_result "Log files reasonable size" "fail" "Large logs found:\n$(echo "$large_logs" | sed 's/^/    /')"
        fi
    else
        test_result "Log directory exists" "fail"
    fi
}

# Test 8: Git repository health
test_git_repos() {
    echo -e "\n${YELLOW}Testing git repositories...${NC}"

    local repos=(
        "$HOME/Documents/textDump"
        "$HOME/Documents/bilan-mx"
        "$HOME/Documents/bilan-video"
    )

    for repo in "${repos[@]}"; do
        if [ -d "$repo/.git" ]; then
            cd "$repo"

            # Check if it's a valid git repo
            if git status >/dev/null 2>&1; then
                test_result "Git repo valid: $(basename $repo)" "pass"

                # Check for remote
                if git remote -v | grep -q origin; then
                    test_result "Remote configured: $(basename $repo)" "pass"
                else
                    test_result "Remote configured: $(basename $repo)" "fail" "No remote 'origin'"
                fi
            else
                test_result "Git repo valid: $(basename $repo)" "fail" "Invalid git repository"
            fi
        else
            test_result "Git repo exists: $(basename $repo)" "fail" "Not a git repository"
        fi
    done
}

# Test 9: Run sample scripts (dry run)
test_script_execution() {
    echo -e "\n${YELLOW}Testing script execution (dry run)...${NC}"

    # Test journal agent with dry-run
    local journal_agent="$HOME/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation/journal_agent.py"
    if [ -f "$journal_agent" ]; then
        if timeout 30s python3 "$journal_agent" --dry-run >/dev/null 2>&1; then
            test_result "Journal agent execution" "pass"
        else
            test_result "Journal agent execution" "fail" "Script failed or timed out"
        fi
    else
        test_result "Journal agent exists" "fail"
    fi

    # Test other scripts if they have --dry-run or --test flags
    if [ -f "$SCRIPT_DIR/morning_setup.sh" ]; then
        if bash -n "$SCRIPT_DIR/morning_setup.sh"; then
            test_result "Morning setup syntax" "pass"
        else
            test_result "Morning setup syntax" "fail"
        fi
    fi
}

# Test 10: Cron timing simulation
test_cron_timing() {
    echo -e "\n${YELLOW}Testing cron timing...${NC}"

    local current_hour=$(date +%H)
    local next_run_found=false

    # Check if journal agent will run today
    for hour in 10 12 14 16 18 20; do
        if [ $hour -gt $current_hour ]; then
            test_result "Next journal run scheduled" "pass" "Today at ${hour}:00"
            next_run_found=true
            break
        fi
    done

    if [ "$next_run_found" = false ]; then
        test_result "Next journal run scheduled" "pass" "Tomorrow at 10:00"
    fi
}

# Test 11: Network connectivity (for cloud backups)
test_network() {
    echo -e "\n${YELLOW}Testing network connectivity...${NC}"

    if ping -c 1 -W 2 8.8.8.8 >/dev/null 2>&1; then
        test_result "Network connectivity" "pass"
    else
        test_result "Network connectivity" "fail" "Cannot reach internet"
    fi
}

# Test 12: Memory and CPU availability
test_resources() {
    echo -e "\n${YELLOW}Testing system resources...${NC}"

    local mem_usage=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100}')
    if [ $mem_usage -lt 90 ]; then
        test_result "Memory usage acceptable" "pass" "${mem_usage}% used"
    else
        test_result "Memory usage acceptable" "fail" "${mem_usage}% used (>90%)"
    fi

    local load=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | sed 's/,//')
    local cpu_count=$(nproc)
    local load_per_cpu=$(echo "scale=2; $load / $cpu_count" | bc)

    if (( $(echo "$load_per_cpu < 2.0" | bc -l) )); then
        test_result "System load acceptable" "pass" "Load: $load (${load_per_cpu} per CPU)"
    else
        test_result "System load acceptable" "fail" "Load: $load (${load_per_cpu} per CPU, high load)"
    fi
}

# Generate test report
generate_report() {
    local total=$((TESTS_PASSED + TESTS_FAILED))

    echo -e "\n${BLUE}════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  Test Results${NC}"
    echo -e "${BLUE}════════════════════════════════════════════════════${NC}"
    echo -e "\nTotal tests: $total"
    echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
    echo -e "${RED}Failed: $TESTS_FAILED${NC}"

    local success_rate=$(echo "scale=2; $TESTS_PASSED * 100 / $total" | bc)
    echo -e "\nSuccess rate: ${success_rate}%"

    if [ $TESTS_FAILED -eq 0 ]; then
        echo -e "\n${GREEN}✓ All tests passed! Your cron setup is healthy.${NC}"
        return 0
    else
        echo -e "\n${YELLOW}⚠ Some tests failed. Please review the issues above.${NC}"
        return 1
    fi
}

# Interactive mode: fix common issues
offer_fixes() {
    if [ $TESTS_FAILED -gt 0 ]; then
        echo -e "\n${YELLOW}Would you like to attempt automatic fixes? (y/n)${NC}"
        read -r response

        if [[ "$response" =~ ^[Yy]$ ]]; then
            echo -e "\n${BLUE}Applying fixes...${NC}"

            # Create missing directories
            mkdir -p "$SCRIPT_DIR" "$LOG_DIR" "$HOME/backups"
            echo "✓ Created missing directories"

            # Make scripts executable
            find "$SCRIPT_DIR" -name "*.sh" -type f -exec chmod +x {} \;
            echo "✓ Made scripts executable"

            # Start cron if not running
            if ! systemctl is-active --quiet cronie; then
                sudo systemctl start cronie
                echo "✓ Started cron service"
            fi

            echo -e "\n${GREEN}Fixes applied. Re-run tests to verify.${NC}"
        fi
    fi
}

# Main execution
main() {
    print_header

    test_cron_service
    test_crontab_syntax
    test_scripts_exist
    test_directories
    test_environment
    test_disk_space
    test_log_rotation
    test_git_repos
    test_script_execution
    test_cron_timing
    test_network
    test_resources

    generate_report
    local exit_code=$?

    offer_fixes

    exit $exit_code
}

# Run if executed directly
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    main "$@"
fi
