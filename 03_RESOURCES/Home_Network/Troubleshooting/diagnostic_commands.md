# Diagnostic Commands

Quick reference for network diagnostic commands on macOS.

## Basic Network Information

### View All Network Interfaces
```bash
# Detailed interface information
ifconfig

# Just active interfaces
ifconfig | grep -A 1 "flags"

# Specific interface
ifconfig en0
```

### View IP Addresses
```bash
# All IPs
ifconfig | grep "inet "

# Just en0 IPv4
ifconfig en0 | grep "inet " | awk '{print $2}'

# IPv6 addresses
ifconfig | grep "inet6"
```

### View MAC Addresses
```bash
# All MAC addresses
ifconfig | grep "ether"

# Specific interface
ifconfig en0 | grep "ether" | awk '{print $2}'
```

## Routing Information

### View Routing Table
```bash
# Full routing table
netstat -rn

# IPv4 only
netstat -rn -f inet

# IPv6 only
netstat -rn -f inet6

# Default gateway
netstat -rn | grep default
```

### View Gateway
```bash
# Get default gateway
route -n get default

# Get gateway for specific destination
route -n get 8.8.8.8
```

## DNS Diagnostics

### View DNS Configuration
```bash
# Full DNS configuration
scutil --dns

# DNS servers only
scutil --dns | grep 'nameserver\[0\]'
```

### DNS Lookups
```bash
# Simple lookup
nslookup google.com

# Detailed lookup
dig google.com

# Short answer
dig +short google.com

# Specific DNS server
dig @1.1.1.1 google.com

# Reverse DNS lookup
dig -x 8.8.8.8

# Trace DNS resolution
dig +trace google.com

# Check specific record type
dig google.com MX    # Mail servers
dig google.com NS    # Name servers
dig google.com TXT   # Text records
dig google.com AAAA  # IPv6 address
```

### DNS Tools
```bash
# Legacy tool (simpler)
nslookup google.com

# Modern tool (more info)
host google.com

# DNS statistics
scutil --dns | grep "reach"
```

### Clear DNS Cache
```bash
# Flush DNS cache
sudo dscacheutil -flushcache

# Restart mDNS
sudo killall -HUP mDNSResponder

# Both at once
sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder
```

## Connectivity Tests

### Ping Tests
```bash
# Basic ping
ping google.com

# Specific count
ping -c 4 google.com

# Set interval (seconds)
ping -i 0.5 google.com

# Set packet size
ping -s 1000 google.com

# Flood ping (requires sudo)
sudo ping -f google.com

# IPv6 ping
ping6 google.com
```

### Ping Targets
```bash
# Test local connectivity
ping 127.0.0.1          # Loopback (self)
ping 192.168.1.71       # This computer
ping 192.168.1.254      # Gateway

# Test internet connectivity
ping 8.8.8.8            # Google DNS (IP)
ping 1.1.1.1            # Cloudflare DNS (IP)
ping google.com         # Google (tests DNS too)

# Test Tailscale
ping 100.100.100.100    # Tailscale coordination
ping 100.110.53.154     # This device on Tailscale
```

### Traceroute
```bash
# Basic traceroute
traceroute google.com

# IPv6 traceroute
traceroute6 google.com

# ICMP traceroute
sudo traceroute -I google.com

# UDP traceroute (default)
traceroute google.com

# TCP traceroute
sudo traceroute -T -p 80 google.com

# Max hops
traceroute -m 20 google.com
```

### Path MTU Discovery
```bash
# Test MTU to gateway
ping -D -s 1472 192.168.1.254

# Test MTU to internet
ping -D -s 1472 8.8.8.8

# If fragmentation needed, reduce size
ping -D -s 1400 8.8.8.8

# Standard MTU sizes:
# 1500 - Standard Ethernet
# 1492 - PPPoE
# 1280 - Minimum IPv6 MTU
# 576  - Minimum IPv4 MTU
```

## Port and Service Diagnostics

### Check Open Ports
```bash
# All listening ports
sudo lsof -i -P | grep LISTEN

# Specific port
sudo lsof -i :80

# Specific protocol
sudo lsof -i tcp
sudo lsof -i udp

# All network connections
sudo lsof -i

# Active connections only
sudo lsof -i | grep ESTABLISHED
```

### Netstat Commands
```bash
# All connections
netstat -an

# Listening ports
netstat -an | grep LISTEN

# Established connections
netstat -an | grep ESTABLISHED

# Network statistics
netstat -s

# Routing statistics
netstat -r

# Interface statistics
netstat -i
```

### Test Port Connectivity
```bash
# Test if port is open (using nc)
nc -zv google.com 80

# Test with timeout
nc -zv -w 2 google.com 80

# TCP test
nc -zv -t google.com 80

# UDP test
nc -zv -u 8.8.8.8 53

# Listen on port (server mode)
nc -l 8080

# Connect to port and interact
nc google.com 80
# Then type: GET / HTTP/1.0
```

### Test HTTPS
```bash
# Test SSL/TLS connection
openssl s_client -connect google.com:443

# Test with SNI
openssl s_client -connect google.com:443 -servername google.com

# Show certificate only
openssl s_client -connect google.com:443 2>/dev/null | openssl x509 -noout -text

# Check certificate expiration
openssl s_client -connect google.com:443 2>/dev/null | openssl x509 -noout -dates
```

## Network Scanning

### ARP Cache
```bash
# View ARP cache
arp -a

# ARP for specific IP
arp 192.168.1.254

# Delete ARP entry
sudo arp -d 192.168.1.X
```

### Network Scanning (requires nmap)
```bash
# Ping scan (find live hosts)
sudo nmap -sn 192.168.1.0/24

# Port scan
sudo nmap 192.168.1.71

# Scan specific ports
sudo nmap -p 80,443 192.168.1.71

# Scan port range
sudo nmap -p 1-1000 192.168.1.71

# TCP SYN scan (stealthy)
sudo nmap -sS 192.168.1.71

# Service version detection
sudo nmap -sV 192.168.1.71

# OS detection
sudo nmap -O 192.168.1.71

# Aggressive scan
sudo nmap -A 192.168.1.71

# Fast scan (top 100 ports)
nmap -F 192.168.1.71
```

## Bandwidth and Performance

### Bandwidth Monitoring (requires iftop)
```bash
# Monitor en0 interface
sudo iftop -i en0

# Show bytes instead of bits
sudo iftop -i en0 -B

# Show connections to/from specific host
sudo iftop -i en0 -f "host 192.168.1.254"

# Show only TCP
sudo iftop -i en0 -f "tcp"
```

### Network Statistics
```bash
# Interface statistics
netstat -ib

# Detailed interface stats
netstat -idb

# Continuous monitoring
netstat -w 1

# Protocol statistics
netstat -s
```

### Packet Capture (tcpdump)
```bash
# Capture on en0
sudo tcpdump -i en0

# Capture to file
sudo tcpdump -i en0 -w capture.pcap

# Capture specific host
sudo tcpdump -i en0 host 192.168.1.254

# Capture specific port
sudo tcpdump -i en0 port 80

# Capture HTTP traffic
sudo tcpdump -i en0 'tcp port 80'

# Capture DNS queries
sudo tcpdump -i en0 port 53

# Readable output
sudo tcpdump -i en0 -A

# Limited packet count
sudo tcpdump -i en0 -c 100

# Specific protocol
sudo tcpdump -i en0 icmp
sudo tcpdump -i en0 tcp
sudo tcpdump -i en0 udp
```

## Wi-Fi Diagnostics

### Wi-Fi Information
```bash
# Current Wi-Fi network
networksetup -getairportnetwork en0

# Wi-Fi status and details
/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I

# Scan for networks
/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s

# Signal strength (RSSI)
/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep CtlRSSI
```

### Wi-Fi Control
```bash
# Turn Wi-Fi off
networksetup -setairportpower en0 off

# Turn Wi-Fi on
networksetup -setairportpower en0 on

# Cycle Wi-Fi
networksetup -setairportpower en0 off && sleep 2 && networksetup -setairportpower en0 on
```

### Wi-Fi Configuration
```bash
# List preferred networks
networksetup -listpreferredwirelessnetworks en0

# Add network
sudo networksetup -addpreferredwirelessnetworkatindex en0 "SSID" 0 "WPA2" "password"

# Remove network
sudo networksetup -removepreferredwirelessnetwork en0 "SSID"

# Set network order
sudo networksetup -orderpreferredwirelessnetworks en0 "SSID1" "SSID2"
```

## DHCP Diagnostics

### DHCP Information
```bash
# Get DHCP packet info
ipconfig getpacket en0

# Show DHCP lease
ipconfig get en0

# IP address
ipconfig getifaddr en0

# Subnet mask
ipconfig getsubnet en0

# Router
ipconfig getoption en0 router
```

### DHCP Control
```bash
# Renew DHCP lease
sudo ipconfig set en0 DHCP

# Set manual IP (example)
sudo ipconfig set en0 INFORM 192.168.1.71

# Release DHCP
sudo ipconfig set en0 NONE

# Then renew
sudo ipconfig set en0 DHCP
```

## VPN Diagnostics (Tailscale)

### Tailscale Status
```bash
# Full status
tailscale status

# Verbose status
tailscale status --json

# IP addresses
tailscale ip

# List peers
tailscale status | grep -v "^#"

# Netcheck (connection quality)
tailscale netcheck
```

### Tailscale Testing
```bash
# Ping Tailscale peer
tailscale ping <device-name-or-ip>

# Test specific peer
ping 100.110.53.154

# Check coordination server
ping 100.100.100.100
```

### Tailscale Logs
```bash
# View Tailscale logs
log show --predicate 'process == "tailscaled"' --last 30m

# Follow live logs
log stream --predicate 'process == "tailscaled"'
```

## System Logs

### Network Logs
```bash
# Network daemon logs
log show --predicate 'process == "networkd"' --last 1h

# Wi-Fi logs
log show --predicate 'process == "wifid"' --last 1h

# DNS logs
log show --predicate 'process == "mDNSResponder"' --last 1h

# DHCP logs
log show --predicate 'process == "bootpd"' --last 1h
```

### Live Log Streaming
```bash
# Stream network logs
log stream --predicate 'process == "networkd"'

# Stream Wi-Fi logs
log stream --predicate 'process == "wifid"'

# Stream all network-related
log stream --predicate 'category contains "network"'
```

### Error Logs
```bash
# Network errors
log show --predicate 'eventMessage contains "error" AND process == "networkd"' --last 1h

# Wi-Fi errors
log show --predicate 'eventMessage contains "error" AND process == "wifid"' --last 1h
```

## Speed Tests

### Built-in Speed Test
```bash
# Use networkQuality (macOS 12+)
networkQuality

# Verbose output
networkQuality -v

# Download only
networkQuality -d

# Upload only
networkQuality -u
```

### Command Line Speed Tests
```bash
# Using curl (download test)
curl -o /dev/null https://speed.cloudflare.com/__down?bytes=100000000

# Time a large download
time curl -o /dev/null https://speed.cloudflare.com/__down?bytes=100000000

# Upload test (limited)
time curl -F "file=@largefile.bin" https://httpbin.org/post
```

### External Speed Tests
- fast.com (Netflix)
- speedtest.net (Ookla)
- speed.cloudflare.com (Cloudflare)

## Hardware Diagnostics

### Network Hardware
```bash
# List network hardware
networksetup -listallhardwareports

# Get hardware details
system_profiler SPNetworkDataType

# Check for hardware issues
system_profiler SPDiagnosticsDataType
```

### Run Diagnostics
```bash
# Network diagnostics
/System/Library/CoreServices/Applications/Network\ Utility.app/Contents/MacOS/Network\ Utility

# Or use System Preferences > Network > Assist me > Diagnostics
```

## Service Testing

### HTTP/HTTPS Testing
```bash
# Test HTTP endpoint
curl -I http://example.com

# Test HTTPS endpoint
curl -I https://example.com

# Follow redirects
curl -IL https://example.com

# Verbose output
curl -v https://example.com

# Test response time
curl -w "@-" -o /dev/null -s https://example.com <<'EOF'
time_namelookup:  %{time_namelookup}\n
time_connect:  %{time_connect}\n
time_appconnect:  %{time_appconnect}\n
time_pretransfer:  %{time_pretransfer}\n
time_redirect:  %{time_redirect}\n
time_starttransfer:  %{time_starttransfer}\n
time_total:  %{time_total}\n
EOF
```

### Email Server Testing
```bash
# Test SMTP
telnet smtp.gmail.com 587

# Test IMAP
telnet imap.gmail.com 993

# Test POP3
telnet pop.gmail.com 995
```

## Firewall Diagnostics

### Check Firewall Status
```bash
# Firewall state
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate

# Stealth mode status
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getstealthmode

# Logging status
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getloggingmode

# List applications
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --listapps
```

## Quick Diagnostic Script

Save this as `netdiag.sh`:

```bash
#!/bin/bash
echo "=== Network Diagnostics ==="
echo ""
echo "--- IP Configuration ---"
ifconfig en0 | grep "inet "
echo ""
echo "--- Gateway ---"
netstat -rn | grep default | head -1
echo ""
echo "--- DNS ---"
scutil --dns | grep 'nameserver\[0\]' | head -3
echo ""
echo "--- Connectivity Tests ---"
echo -n "Gateway: "
ping -c 1 -t 1 192.168.1.254 &>/dev/null && echo "OK" || echo "FAIL"
echo -n "Google DNS: "
ping -c 1 -t 1 8.8.8.8 &>/dev/null && echo "OK" || echo "FAIL"
echo -n "Internet: "
ping -c 1 -t 1 google.com &>/dev/null && echo "OK" || echo "FAIL"
echo ""
echo "--- Active Connections ---"
netstat -an | grep ESTABLISHED | wc -l | xargs echo "Established connections:"
echo ""
echo "--- Listening Ports ---"
sudo lsof -i -P | grep LISTEN | wc -l | xargs echo "Listening ports:"
```

Make executable: `chmod +x netdiag.sh`
Run: `./netdiag.sh`

## Notes

- Commands requiring `sudo` will prompt for password
- Some commands may not be available without installing additional tools (nmap, iftop, etc.)
- Use `man <command>` to see full documentation
- Use `<command> --help` or `<command> -h` for quick help
- Press Ctrl+C to stop continuous commands
- Output can be piped to files: `command > output.txt`
- Append to files: `command >> output.txt`
- Search output: `command | grep "search term"`