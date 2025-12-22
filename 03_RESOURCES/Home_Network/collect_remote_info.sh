#!/bin/bash
# Script to collect network information from a remote computer via SSH
# Usage: ./collect_remote_info.sh <username@host>

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if remote host provided
if [ -z "$1" ]; then
    echo -e "${RED}Error: No remote host specified${NC}"
    echo "Usage: $0 username@host"
    echo "Example: $0 capicuaman@100.68.220.78"
    exit 1
fi

REMOTE="$1"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR="./remote_data_${TIMESTAMP}"

echo -e "${GREEN}Collecting network information from ${REMOTE}${NC}"
echo "Output directory: ${OUTPUT_DIR}"
echo ""

# Create output directory
mkdir -p "${OUTPUT_DIR}"

# Test SSH connection
echo -e "${YELLOW}Testing SSH connection...${NC}"
if ! ssh -o ConnectTimeout=5 -o BatchMode=yes "${REMOTE}" "echo 'SSH connection successful'" 2>/dev/null; then
    echo -e "${RED}Cannot connect to ${REMOTE}${NC}"
    echo "Please ensure:"
    echo "  1. The remote host is reachable"
    echo "  2. SSH is enabled on the remote host"
    echo "  3. You have SSH key authentication set up (or use: ssh-copy-id ${REMOTE})"
    exit 1
fi

echo -e "${GREEN}SSH connection successful!${NC}\n"

# Detect remote OS
echo -e "${YELLOW}Detecting remote operating system...${NC}"
REMOTE_OS=$(ssh "${REMOTE}" "uname -s" 2>/dev/null)
echo "Remote OS: ${REMOTE_OS}"
echo ""

# Function to run command and save output
run_remote_command() {
    local cmd="$1"
    local output_file="$2"
    local description="$3"

    echo -e "${YELLOW}Collecting: ${description}${NC}"
    if ssh "${REMOTE}" "${cmd}" > "${OUTPUT_DIR}/${output_file}" 2>&1; then
        echo -e "${GREEN}✓ Saved to ${output_file}${NC}"
    else
        echo -e "${RED}✗ Failed to collect ${description}${NC}"
    fi
}

# Collect system information
echo -e "\n${GREEN}=== System Information ===${NC}"
run_remote_command "hostname" "hostname.txt" "Hostname"
run_remote_command "uname -a" "uname.txt" "System info"

# macOS-specific commands
if [[ "$REMOTE_OS" == "Darwin" ]]; then
    echo -e "\n${GREEN}=== macOS-Specific Information ===${NC}"
    run_remote_command "system_profiler SPHardwareDataType SPSoftwareDataType" "system_profiler.txt" "Hardware and software details"
    run_remote_command "scutil --dns" "dns_config.txt" "DNS configuration"
    run_remote_command "networksetup -listallhardwareports" "hardware_ports.txt" "Network hardware ports"
fi

# Linux-specific commands
if [[ "$REMOTE_OS" == "Linux" ]]; then
    echo -e "\n${GREEN}=== Linux-Specific Information ===${NC}"
    run_remote_command "cat /etc/os-release" "os_release.txt" "OS release info"
    run_remote_command "cat /etc/resolv.conf" "dns_config.txt" "DNS configuration"
    run_remote_command "ip link show" "ip_link.txt" "Network interfaces (ip)"
    run_remote_command "lsb_release -a" "lsb_release.txt" "Distribution info"
fi

# Universal network commands
echo -e "\n${GREEN}=== Network Configuration ===${NC}"
run_remote_command "ifconfig" "ifconfig.txt" "Network interfaces"
run_remote_command "netstat -rn" "routing_table.txt" "Routing table"
run_remote_command "arp -a" "arp_cache.txt" "ARP cache"

# Check if Tailscale is installed
echo -e "\n${GREEN}=== VPN Information ===${NC}"
if ssh "${REMOTE}" "command -v tailscale >/dev/null 2>&1"; then
    run_remote_command "tailscale status" "tailscale_status.txt" "Tailscale status"
    run_remote_command "tailscale ip" "tailscale_ip.txt" "Tailscale IPs"
else
    echo -e "${YELLOW}Tailscale not found on remote system${NC}"
fi

# Network diagnostics
echo -e "\n${GREEN}=== Network Diagnostics ===${NC}"
run_remote_command "ping -c 4 8.8.8.8" "ping_test.txt" "Ping test to 8.8.8.8"

# Check for open ports (if lsof available)
if ssh "${REMOTE}" "command -v lsof >/dev/null 2>&1"; then
    run_remote_command "sudo lsof -i -P | grep LISTEN" "listening_ports.txt" "Listening ports"
else
    run_remote_command "netstat -an | grep LISTEN" "listening_ports.txt" "Listening ports (netstat)"
fi

# Summary
echo -e "\n${GREEN}=== Collection Complete ===${NC}"
echo "Data saved to: ${OUTPUT_DIR}"
echo ""
echo "Files collected:"
ls -lh "${OUTPUT_DIR}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Review the collected data in ${OUTPUT_DIR}"
echo "2. Create documentation from this data"
echo "3. Add to your Home_Network documentation"
echo ""
echo "To create formatted documentation, you can ask Claude to:"
echo "  - Read the files in ${OUTPUT_DIR}"
echo "  - Generate markdown documentation"
echo "  - Add to Equipment/ or create new device folder"
