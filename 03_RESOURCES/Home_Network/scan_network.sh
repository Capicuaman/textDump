#!/bin/bash

# This script scans the local network to find and list all active IP addresses.
# It depends on nmap, a powerful network scanning tool.

# --- Dependency Check ---
# Check if nmap is installed. If not, exit with an error message.
if ! command -v nmap &> /dev/null; then
    echo "Error: nmap is not installed." >&2
    echo "Please install it to use this script." >&2
    echo "On Debian/Ubuntu: sudo apt-get install nmap" >&2
    echo "On Fedora/CentOS: sudo yum install nmap" >&2
    echo "On macOS (with Homebrew): brew install nmap" >&2
    exit 1
fi

# --- Network Detection ---
# Automatically find the local network range (e.g., 192.168.1.0/24).
# This command finds the active network interface and its corresponding IP address in CIDR notation.
NETWORK_RANGE=$(ip -o -4 addr show | awk '!/127.0.0.1/ {print $4}' | head -n1)

if [ -z "$NETWORK_RANGE" ]; then
    echo "Error: Could not determine the local network range." >&2
    exit 1
fi

# --- Scanning ---
echo "Scanning your network: ${NETWORK_RANGE}"
echo "This may take a minute..."
echo "----------------------------------------"

# Use nmap to perform a ping scan (-sn) on the detected network range.
# This type of scan is fast because it doesn't perform a port scan on the hosts.
# The output is then filtered with awk to show only the IP addresses of hosts that are up.
nmap -sn "${NETWORK_RANGE}" | awk '/Nmap scan report for/{print $5}'

echo "----------------------------------------"
echo "Scan complete."
