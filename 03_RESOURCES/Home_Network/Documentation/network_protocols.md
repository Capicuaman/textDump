# Network Protocols

Reference guide for common network protocols used in home networking.

## OSI Model Layers

```
Layer 7: Application  - HTTP, DNS, SSH, FTP
Layer 6: Presentation - SSL/TLS, Encryption
Layer 5: Session      - NetBIOS, RPC
Layer 4: Transport    - TCP, UDP
Layer 3: Network      - IP, ICMP, IPsec
Layer 2: Data Link    - Ethernet, Wi-Fi, ARP
Layer 1: Physical     - Cables, Radio Waves
```

## Layer 1-2: Physical and Data Link

### Ethernet (IEEE 802.3)
**Purpose:** Wired local area network
**Speeds:**
- 10 Mbps (Ethernet)
- 100 Mbps (Fast Ethernet)
- 1 Gbps (Gigabit Ethernet)
- 10 Gbps (10 Gigabit Ethernet)

**Frame Format:**
- Preamble: 7 bytes
- Start delimiter: 1 byte
- Destination MAC: 6 bytes
- Source MAC: 6 bytes
- Type/Length: 2 bytes
- Payload: 46-1500 bytes
- FCS (Checksum): 4 bytes

### Wi-Fi (IEEE 802.11)
**Purpose:** Wireless local area network

**Standards:**
| Standard | Year | Frequency | Max Speed | Range |
|----------|------|-----------|-----------|-------|
| 802.11b | 1999 | 2.4 GHz | 11 Mbps | ~35m |
| 802.11g | 2003 | 2.4 GHz | 54 Mbps | ~38m |
| 802.11n | 2009 | 2.4/5 GHz | 600 Mbps | ~70m |
| 802.11ac | 2013 | 5 GHz | 1300 Mbps | ~35m |
| 802.11ax (Wi-Fi 6) | 2019 | 2.4/5 GHz | 9.6 Gbps | ~30m |
| 802.11ax (Wi-Fi 6E) | 2020 | 6 GHz | 9.6 Gbps | ~30m |

**Security:**
- WEP (Deprecated, broken)
- WPA (Deprecated, broken)
- WPA2 (Current standard)
- WPA3 (Newest, most secure)

### ARP (Address Resolution Protocol)
**Purpose:** Map IP addresses to MAC addresses
**Port:** N/A (Layer 2)
**Type:** Request/Reply

**How it works:**
1. Device needs to send packet to 192.168.1.254
2. Broadcasts: "Who has 192.168.1.254?"
3. Router replies: "I have it, my MAC is e4:26:86:72:0d:f0"
4. Device caches this in ARP table

**View ARP cache:**
```bash
arp -a
```

## Layer 3: Network

### IP (Internet Protocol)

#### IPv4
**Purpose:** Network layer addressing and routing
**Address Format:** 32-bit (4 octets)
**Example:** 192.168.1.71
**Address Classes:**
- Class A: 0.0.0.0 - 127.255.255.255 (16.7M hosts)
- Class B: 128.0.0.0 - 191.255.255.255 (65K hosts)
- Class C: 192.0.0.0 - 223.255.255.255 (254 hosts)

**Private Ranges (RFC 1918):**
- 10.0.0.0/8 (10.0.0.0 - 10.255.255.255)
- 172.16.0.0/12 (172.16.0.0 - 172.31.255.255)
- 192.168.0.0/16 (192.168.0.0 - 192.168.255.255)

**Packet Header:**
- Version: 4 bits
- Header Length: 4 bits
- Type of Service: 8 bits
- Total Length: 16 bits
- Identification: 16 bits
- Flags: 3 bits
- Fragment Offset: 13 bits
- TTL: 8 bits
- Protocol: 8 bits
- Header Checksum: 16 bits
- Source IP: 32 bits
- Destination IP: 32 bits

#### IPv6
**Purpose:** Next generation IP protocol
**Address Format:** 128-bit (8 groups of 4 hex digits)
**Example:** 2806:104e:16:2889:1416:485c:7784:c068

**Address Types:**
- **Unicast:** Single interface
- **Multicast:** Multiple interfaces (ff00::/8)
- **Anycast:** Nearest interface (same as unicast)

**Special Addresses:**
- ::1/128 - Loopback
- ::/128 - Unspecified
- fe80::/10 - Link-local
- fc00::/7 - Unique local (ULA)
- ff00::/8 - Multicast

**Current Network:**
- Global: 2806:104e:16:2889::/64
- ULA (Tailscale): fd7a:115c:a1e0::/48
- ULA (VM): fd09:e29d:3df9:5226::/64

### ICMP (Internet Control Message Protocol)
**Purpose:** Error messages and diagnostics
**Common Types:**
- Type 0: Echo Reply (ping response)
- Type 3: Destination Unreachable
- Type 5: Redirect
- Type 8: Echo Request (ping)
- Type 11: Time Exceeded (TTL=0)

**Tools using ICMP:**
- ping (echo request/reply)
- traceroute (TTL exceeded)

### IPsec (IP Security)
**Purpose:** Secure IP communications
**Components:**
- AH (Authentication Header)
- ESP (Encapsulating Security Payload)
- IKE (Internet Key Exchange)

**Used by:** VPNs, secure communications

## Layer 4: Transport

### TCP (Transmission Control Protocol)
**Purpose:** Reliable, ordered, connection-oriented delivery
**Port Range:** 0-65535

**Characteristics:**
- ✅ Connection-oriented (handshake)
- ✅ Reliable (acknowledgments, retransmission)
- ✅ Ordered delivery
- ✅ Flow control
- ✅ Congestion control
- ❌ Higher overhead

**Three-Way Handshake:**
1. Client → Server: SYN
2. Server → Client: SYN-ACK
3. Client → Server: ACK

**Common TCP Ports:**
- 20/21: FTP (File Transfer)
- 22: SSH (Secure Shell)
- 23: Telnet
- 25: SMTP (Email)
- 53: DNS (also UDP)
- 80: HTTP (Web)
- 110: POP3 (Email)
- 143: IMAP (Email)
- 443: HTTPS (Secure Web)
- 445: SMB (File Sharing)
- 3389: RDP (Remote Desktop)
- 5432: PostgreSQL
- 3306: MySQL/MariaDB
- 8080: HTTP Alternative

### UDP (User Datagram Protocol)
**Purpose:** Fast, connectionless, best-effort delivery
**Port Range:** 0-65535

**Characteristics:**
- ✅ Connectionless (no handshake)
- ✅ Fast (low overhead)
- ✅ Good for streaming
- ❌ Unreliable (no acknowledgment)
- ❌ No ordering guarantee
- ❌ No flow control

**Common UDP Ports:**
- 53: DNS (also TCP)
- 67/68: DHCP
- 69: TFTP
- 123: NTP (Time sync)
- 161/162: SNMP (Monitoring)
- 500: IPsec/IKE
- 514: Syslog
- 1194: OpenVPN
- 5353: mDNS (Bonjour)
- 51820: WireGuard VPN

**Used by:**
- DNS queries
- VoIP
- Video streaming
- Online gaming
- VPN (WireGuard, OpenVPN)

## Layer 7: Application

### HTTP (Hypertext Transfer Protocol)
**Purpose:** Web content transfer
**Port:** 80 (TCP)
**Version:** HTTP/1.1, HTTP/2, HTTP/3

**Methods:**
- GET: Retrieve resource
- POST: Submit data
- PUT: Update resource
- DELETE: Remove resource
- HEAD: Get headers only
- OPTIONS: Query options

**Status Codes:**
- 200: OK
- 301/302: Redirect
- 304: Not Modified
- 400: Bad Request
- 401: Unauthorized
- 403: Forbidden
- 404: Not Found
- 500: Internal Server Error
- 502: Bad Gateway
- 503: Service Unavailable

### HTTPS (HTTP Secure)
**Purpose:** Encrypted web content
**Port:** 443 (TCP)
**Encryption:** TLS/SSL

**TLS Handshake:**
1. Client Hello (supported ciphers)
2. Server Hello (chosen cipher, certificate)
3. Client verifies certificate
4. Key exchange
5. Encrypted communication begins

### DNS (Domain Name System)
**Purpose:** Translate domain names to IP addresses
**Port:** 53 (UDP primary, TCP for large responses)

**Record Types:**
- **A:** IPv4 address
- **AAAA:** IPv6 address
- **CNAME:** Canonical name (alias)
- **MX:** Mail server
- **NS:** Name server
- **TXT:** Text information
- **SOA:** Start of authority
- **PTR:** Reverse DNS
- **SRV:** Service record

**Resolution Process:**
1. Check local cache
2. Query recursive resolver (1.1.1.1)
3. Query root server
4. Query TLD server (.com)
5. Query authoritative server (google.com)
6. Return result and cache

**Your DNS:**
- Primary: 1.1.1.1 (Cloudflare)
- Secondary: 8.8.8.8 (Google)
- Tailscale: 100.100.100.100

### DHCP (Dynamic Host Configuration Protocol)
**Purpose:** Automatic IP address assignment
**Ports:** 67 (server), 68 (client) - UDP

**DORA Process:**
1. **Discover:** Client broadcasts "I need an IP"
2. **Offer:** Server offers IP address
3. **Request:** Client requests offered IP
4. **Acknowledge:** Server confirms assignment

**Information Provided:**
- IP address
- Subnet mask
- Default gateway
- DNS servers
- Lease time
- Domain name

**Current Network:**
- DHCP Server: 192.168.1.254 (router)
- Range: ~192.168.1.51-200 (estimated)
- Your IP: 192.168.1.71 (dynamic)

### SSH (Secure Shell)
**Purpose:** Secure remote access
**Port:** 22 (TCP)
**Encryption:** Public key + symmetric encryption

**Features:**
- Remote command execution
- File transfer (SCP, SFTP)
- Port forwarding
- Tunneling

**Authentication:**
- Password
- Public key (more secure)
- Two-factor

### FTP (File Transfer Protocol)
**Purpose:** File transfer
**Ports:** 20 (data), 21 (control) - TCP
**Note:** Unencrypted, use SFTP or FTPS instead

**Modes:**
- Active: Server connects to client
- Passive: Client connects to server (better for NAT)

### SMTP/POP3/IMAP (Email Protocols)

**SMTP (Simple Mail Transfer Protocol):**
- Purpose: Sending email
- Port: 25 (plain), 587 (TLS), 465 (SSL)
- Direction: Client → Server, Server → Server

**POP3 (Post Office Protocol v3):**
- Purpose: Retrieving email
- Port: 110 (plain), 995 (SSL)
- Behavior: Downloads and deletes from server

**IMAP (Internet Message Access Protocol):**
- Purpose: Retrieving email
- Port: 143 (plain), 993 (SSL)
- Behavior: Syncs with server, keeps on server

### mDNS (Multicast DNS)
**Purpose:** Local network name resolution (.local)
**Port:** 5353 (UDP)
**Multicast:** 224.0.0.251 (IPv4), ff02::fb (IPv6)

**Used by:**
- Bonjour (Apple)
- Avahi (Linux)
- Service discovery
- Printer discovery
- AirPlay, AirDrop

**Example:**
- MacBook.local → 192.168.1.71
- Printer.local → 192.168.1.100

### NTP (Network Time Protocol)
**Purpose:** Time synchronization
**Port:** 123 (UDP)
**Accuracy:** Milliseconds

**Stratum Levels:**
- Stratum 0: Reference clock (GPS, atomic)
- Stratum 1: Primary servers (sync with stratum 0)
- Stratum 2: Secondary servers (sync with stratum 1)
- Your computer: Typically stratum 3-4

### SNMP (Simple Network Management Protocol)
**Purpose:** Network device monitoring
**Ports:** 161 (agent), 162 (trap) - UDP
**Versions:** v1, v2c (insecure), v3 (secure)

## VPN Protocols

### WireGuard
**Purpose:** Modern, fast VPN
**Port:** 51820 (UDP, configurable)
**Used by:** Tailscale

**Features:**
- ✅ Very fast (faster than OpenVPN)
- ✅ Modern cryptography
- ✅ Simple configuration
- ✅ Small codebase (~4,000 lines)
- ✅ Built into Linux kernel

**Encryption:**
- ChaCha20 for symmetric encryption
- Poly1305 for authentication
- Curve25519 for key exchange

### OpenVPN
**Purpose:** Popular open-source VPN
**Ports:** 1194 (UDP preferred), 443 (TCP)

**Features:**
- ✅ Highly configurable
- ✅ Cross-platform
- ✅ Mature and stable
- ❌ Slower than WireGuard
- ❌ Complex configuration

### IPsec/IKEv2
**Purpose:** Standard VPN protocol
**Ports:** 500, 4500 (UDP)

**Features:**
- ✅ Native support in most OSes
- ✅ Fast
- ✅ Secure
- ❌ Complex setup
- ❌ Can be blocked by firewalls

### L2TP/IPsec
**Purpose:** Layer 2 Tunneling Protocol
**Ports:** 500, 1701, 4500 (UDP)

**Note:** Less secure, being phased out

## Security Protocols

### TLS/SSL
**Purpose:** Transport layer security
**Ports:** Variable (443 for HTTPS)

**Versions:**
- SSL 2.0/3.0: Deprecated (insecure)
- TLS 1.0/1.1: Deprecated (insecure)
- TLS 1.2: Secure (current standard)
- TLS 1.3: Most secure (newest)

**Used by:**
- HTTPS
- Email (SMTP, IMAP, POP3)
- VPN
- Many other protocols

### DNSSEC
**Purpose:** Secure DNS with cryptographic signatures
**Status:** Supported by major DNS providers

**Prevents:**
- DNS spoofing
- Cache poisoning
- Man-in-the-middle attacks

### DNS over HTTPS (DoH)
**Purpose:** Encrypt DNS queries
**Port:** 443 (HTTPS)
**Providers:** Cloudflare, Google, Mozilla

### DNS over TLS (DoT)
**Purpose:** Encrypt DNS queries
**Port:** 853 (TCP)
**Providers:** Cloudflare, Google, Quad9

## Protocol Summary Table

| Protocol | Layer | Port | Transport | Purpose |
|----------|-------|------|-----------|---------|
| HTTP | 7 | 80 | TCP | Web content |
| HTTPS | 7 | 443 | TCP | Secure web |
| DNS | 7 | 53 | UDP/TCP | Name resolution |
| DHCP | 7 | 67/68 | UDP | IP assignment |
| SSH | 7 | 22 | TCP | Secure shell |
| FTP | 7 | 20/21 | TCP | File transfer |
| SMTP | 7 | 25/587 | TCP | Send email |
| POP3 | 7 | 110/995 | TCP | Receive email |
| IMAP | 7 | 143/993 | TCP | Sync email |
| mDNS | 7 | 5353 | UDP | Local discovery |
| NTP | 7 | 123 | UDP | Time sync |
| TCP | 4 | N/A | N/A | Reliable transport |
| UDP | 4 | N/A | N/A | Fast transport |
| IP | 3 | N/A | N/A | Routing |
| ICMP | 3 | N/A | N/A | Diagnostics |
| ARP | 2 | N/A | N/A | MAC resolution |

## Common Port Numbers (Quick Reference)

```
20/21  - FTP
22     - SSH
23     - Telnet
25     - SMTP
53     - DNS
67/68  - DHCP
80     - HTTP
110    - POP3
123    - NTP
143    - IMAP
161/162- SNMP
443    - HTTPS
445    - SMB
465    - SMTPS
587    - SMTP (submission)
993    - IMAPS
995    - POP3S
1194   - OpenVPN
3306   - MySQL
3389   - RDP
5353   - mDNS
5432   - PostgreSQL
8080   - HTTP Alt
51820  - WireGuard
```

## Well-Known vs Registered vs Dynamic Ports

- **0-1023:** Well-known ports (system services)
- **1024-49151:** Registered ports (user applications)
- **49152-65535:** Dynamic/private ports (ephemeral)

## Notes

- Most protocols have secure variants (HTTP → HTTPS)
- Always prefer encrypted protocols when available
- Port numbers are standardized but configurable
- UDP is connectionless, TCP is connection-oriented
- Layer 7 protocols rely on layers 1-6 for transport
- Understanding protocols helps with troubleshooting
