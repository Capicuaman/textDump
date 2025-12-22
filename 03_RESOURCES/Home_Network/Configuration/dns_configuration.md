# DNS Configuration

DNS (Domain Name System) configuration for Zapata.

## DNS Overview

This system uses multiple DNS resolvers with different priorities for different purposes:
- **Tailscale DNS** (100.100.100.100) - For Tailscale network queries
- **Cloudflare DNS** (1.1.1.1) - Primary public DNS
- **Google DNS** (8.8.8.8) - Secondary public DNS
- **mDNS** (.local domains) - For local network service discovery

## Primary DNS Resolvers

### Resolver #1 - Tailscale Supplemental
**Domain:** tailfd62a.ts.net, default
**Nameservers:**
- 100.100.100.100

**Configuration:**
- Interface: utun3 (Tailscale VPN)
- Flags: Supplemental, Request A records, Request AAAA records
- Status: Reachable, Transient Connection
- Order: 101000
- Purpose: Handles DNS for Tailscale network resources

### Resolver #2 - Public DNS (Primary)
**Nameservers:**
- 1.1.1.1 (Cloudflare)
- 8.8.8.8 (Google)

**Configuration:**
- Flags: Request A records, Request AAAA records
- Status: Reachable
- Order: 200000
- Purpose: General internet DNS resolution

### Resolver #3 - Tailscale Domain-Specific
**Domain:** tailfd62a.ts.net
**Nameservers:**
- 100.100.100.100

**Configuration:**
- Interface: utun3
- Flags: Supplemental, Request A records, Request AAAA records
- Status: Reachable, Transient Connection
- Order: 101001
- Purpose: Dedicated resolver for Tailscale domain

### Resolver #4 - mDNS (Local)
**Domain:** .local
**Type:** mDNS (Multicast DNS)

**Configuration:**
- Timeout: 5 seconds
- Flags: Request A records, Request AAAA records
- Status: Not Reachable (multicast-based)
- Order: 300000
- Purpose: Bonjour/Zeroconf service discovery

### Resolvers #5-9 - Link-Local IPv6 Domains
**Domains:**
- 254.169.in-addr.arpa (Order: 300200)
- 8.e.f.ip6.arpa (Order: 300400)
- 9.e.f.ip6.arpa (Order: 300600)
- a.e.f.ip6.arpa (Order: 300800)
- b.e.f.ip6.arpa (Order: 301000)

**Type:** mDNS
**Purpose:** Link-local IPv6 reverse DNS lookups

## Scoped DNS Configuration

### Scoped Resolver #1 - Wi-Fi (en0)
**Search Domain:** default
**Nameservers:**
- 1.1.1.1
- 8.8.8.8

**Configuration:**
- Interface: en0 (Wi-Fi)
- Flags: Scoped, Request A records, Request AAAA records
- Status: Reachable

### Scoped Resolver #2 - Tailscale (utun3)
**Search Domain:** tailfd62a.ts.net
**Nameserver:**
- 100.100.100.100

**Configuration:**
- Interface: utun3
- Flags: Scoped, Request A records, Request AAAA records
- Status: Reachable, Transient Connection

## DNS Resolution Priority

1. **Tailscale network queries** → 100.100.100.100 (utun3)
2. **General internet queries** → 1.1.1.1, 8.8.8.8
3. **Local .local domains** → mDNS
4. **IPv6 link-local** → mDNS

## DNS Features

**IPv4 (A Records):** Enabled
**IPv6 (AAAA Records):** Enabled
**DNSSEC:** Status unknown (check with DNS provider)
**DNS over HTTPS (DoH):** Not configured
**DNS over TLS (DoT):** Not configured

## Common DNS Commands

### View DNS configuration:
```bash
scutil --dns
```

### Query DNS manually:
```bash
# Using dig
dig example.com
dig example.com @1.1.1.1

# Using nslookup
nslookup example.com
nslookup example.com 1.1.1.1

# Using host
host example.com
```

### Flush DNS cache:
```bash
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
```

### Test DNS resolution:
```bash
# Test A record
dig +short google.com

# Test AAAA record (IPv6)
dig +short AAAA google.com

# Test reverse DNS
dig -x 8.8.8.8

# Check which DNS server is being used
scutil --dns | grep 'nameserver\[0\]'
```

### View DNS statistics:
```bash
# DNS cache stats
sudo killall -INFO mDNSResponder
sudo log show --predicate 'process == "mDNSResponder"' --last 1m
```

## DNS Provider Information

### Cloudflare (1.1.1.1)
- **Speed:** Very fast (~14-20ms)
- **Privacy:** Does not log personally identifiable information
- **Features:** DNSSEC validation, malware blocking available (1.1.1.2)
- **Family Filter:** 1.1.1.3 (blocks adult content)

### Google Public DNS (8.8.8.8)
- **Speed:** Fast (~20-30ms)
- **Reliability:** Very high uptime
- **Features:** DNSSEC validation
- **Secondary:** 8.8.4.4

### Tailscale DNS (100.100.100.100)
- **Purpose:** Internal Tailscale network name resolution
- **Features:** MagicDNS - resolve device names on your Tailscale network
- **Scope:** Only works within Tailscale network

## Configuration Changes

### Set DNS servers manually:
```bash
# Set DNS servers for Wi-Fi
sudo networksetup -setdnsservers "Wi-Fi" 1.1.1.1 8.8.8.8

# Use DHCP-provided DNS
sudo networksetup -setdnsservers "Wi-Fi" empty
```

### Alternative DNS Providers:

**Quad9 (Security-focused):**
- Primary: 9.9.9.9
- Secondary: 149.112.112.112

**OpenDNS:**
- Primary: 208.67.222.222
- Secondary: 208.67.220.220

**NextDNS (Privacy & Ad-blocking):**
- Custom configuration available

## Troubleshooting

### DNS not resolving:
1. Check DNS servers: `scutil --dns`
2. Flush DNS cache: `sudo dscacheutil -flushcache`
3. Test with specific server: `dig @1.1.1.1 example.com`
4. Check connectivity: `ping 1.1.1.1`

### Slow DNS resolution:
1. Test resolution speed: `time dig google.com`
2. Try alternative DNS servers
3. Check for DNS leaks: Visit https://dnsleaktest.com
4. Consider using DNS over HTTPS (DoH)

### mDNS not working:
1. Check if mDNSResponder is running: `ps aux | grep mDNSResponder`
2. Restart service: `sudo killall -HUP mDNSResponder`
3. Check firewall settings for port 5353 (UDP)

## Notes

- Using multiple DNS providers provides redundancy
- Cloudflare and Google DNS are privacy-conscious options
- Tailscale DNS (MagicDNS) enables easy device access by name
- mDNS enables .local domain resolution for AirDrop, printers, etc.
- Current configuration supports both IPv4 and IPv6 resolution
