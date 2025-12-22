# Routing Configuration

Routing table and gateway configuration for Zapata.

## Default Gateways

### Primary Gateway (IPv4)
- **Gateway:** 192.168.1.254
- **Interface:** en0 (Wi-Fi)
- **Flags:** UGScg (Up, Gateway, Static, Cloning, Gateway default)
- **Purpose:** Default route for all internet traffic

### Tailscale Gateway (IPv4)
- **Gateway:** utun3
- **Interface:** utun3
- **Flags:** UCSIg (Up, Cloning, Static, Ignore redirects, Gateway default)
- **Purpose:** Routes for Tailscale VPN network (100.64.0.0/10)

### IPv6 Default Gateway
- **Gateway:** fe80::e626:86ff:fe72:df0%en0
- **Interface:** en0
- **Flags:** UGcg (Up, Gateway, cloning, gateway default)
- **Purpose:** IPv6 internet traffic

## IPv4 Routing Table

### Local Network Routes

**Home Network (192.168.1.0/24):**
- Network: 192.168.1.0
- Gateway: link#4 (en0)
- Flags: UCS (Up, Cloning, Static)
- Interface: en0
- Purpose: Direct access to local devices

**VM Network (192.168.64.0/24):**
- Network: 192.168.64.0
- Gateway: link#15 (bridge100)
- Flags: UC (Up, Cloning)
- Interface: bridge100
- Purpose: Virtual machine networking

**Loopback (127.0.0.0/8):**
- Network: 127.0.0.0
- Gateway: 127.0.0.1
- Flags: UCS (Up, Cloning, Static)
- Interface: lo0
- Purpose: Local loopback traffic

### Tailscale VPN Routes

**Tailscale Network (100.64.0.0/10):**
- Network: 100.64.0.0/10
- Gateway: link#13 (utun3)
- Flags: UCS (Up, Cloning, Static)
- Interface: utun3
- Purpose: Access to Tailscale peer network

**Tailscale Coordination Server:**
- Host: 100.100.100.100/32
- Gateway: link#13 (utun3)
- Interface: utun3
- Purpose: Tailscale DNS and coordination

**This Device (Tailscale):**
- Host: 100.110.53.154
- Gateway: 100.110.53.154
- Flags: UH (Up, Host)
- Interface: utun3
- Purpose: Local Tailscale IP

### Special Routes

**Link-Local (169.254.0.0/16):**
- Network: 169.254.0.0/16
- Gateway: link#4
- Interface: en0
- Flags: UCS
- Purpose: APIPA/Zero-conf networking

**Multicast (224.0.0.0/4):**
- Network: 224.0.0.0/4
- Gateway: link#4
- Interface: en0, utun3
- Flags: UmCS (Up, multicast, Cloning, Static)
- Purpose: Multicast traffic (mDNS, SSDP, etc.)

### Known Hosts

**Gateway/Router:**
- IP: 192.168.1.254
- MAC: e4:26:86:72:0d:f0
- Flags: UHLWIir (Up, Host, LLINFO, Wascloned, Ifscope, intermediate, router)
- Expire: 1194 seconds

**Network Device #1:**
- IP: 192.168.1.64
- MAC: a8:80:55:f1:2c:83
- Flags: UHLWI
- Expire: 196 seconds

**Network Device #2:**
- IP: 192.168.1.68
- MAC: 7e:a9:f9:aa:d7:fe
- Flags: UHLWI
- Expire: 915 seconds

## IPv6 Routing Table

### Default Routes

**Primary IPv6 Gateway:**
- Gateway: fe80::e626:86ff:fe72:df0%en0
- Interface: en0
- Flags: UGcg
- Purpose: IPv6 internet access

**VPN Tunnels:**
- utun0, utun1, utun2: Additional VPN default routes
- Tailscale (utun3): fd7a:115c:a1e0:: gateway

### IPv6 Networks

**Home Network (2806:104e:16:2889::/64):**
- Gateway: link#4
- Interface: en0
- Flags: UC
- Purpose: Local IPv6 subnet

**Tailscale ULA (fd7a:115c:a1e0::/48):**
- Gateway: fe80::7e04:d0ff:fec4:b562%utun3
- Interface: utun3
- Flags: Uc
- Purpose: Tailscale unique local addresses

**VM Network (fd09:e29d:3df9:5226::/64):**
- Gateway: link#15
- Interface: bridge100
- Flags: UC
- Purpose: VM IPv6 networking

### Link-Local IPv6

Each interface has its own fe80::/64 link-local network:
- **en0:** fe80::/64
- **awdl0:** fe80::/64
- **llw0:** fe80::/64
- **utun0-3:** fe80::/64 each
- **bridge100:** fe80::/64

### IPv6 Multicast (ff00::/8)

Multicast routes configured on all active interfaces:
- lo0, en0, awdl0, llw0, utun0-3, bridge100

## Route Metrics and Priorities

**Route Selection Order:**
1. Most specific route (longest prefix match)
2. Static routes (manually configured)
3. Dynamic routes (from routing protocols)
4. Default gateway (0.0.0.0/0)

## Network Address Translation (NAT)

**Primary NAT Gateway:**
- External: 192.168.1.254 (router)
- Internal: 192.168.1.0/24

**VM NAT:**
- External: 192.168.1.71 (this computer)
- Internal: 192.168.64.0/24 (VMs)

## Routing Commands

### View routing table:
```bash
# IPv4 routing table
netstat -rn -f inet

# IPv6 routing table
netstat -rn -f inet6

# All routes
netstat -rn
```

### Add static route:
```bash
# Add route to specific network
sudo route add -net 10.0.0.0/8 192.168.1.1

# Add default gateway
sudo route add default 192.168.1.254
```

### Delete route:
```bash
# Delete specific route
sudo route delete -net 10.0.0.0/8

# Delete default gateway
sudo route delete default
```

### Flush routing table:
```bash
# Flush all routes
sudo route flush
```

### Trace route to destination:
```bash
# IPv4
traceroute google.com

# IPv6
traceroute6 google.com

# With ICMP
traceroute -I google.com
```

### Test connectivity:
```bash
# Ping gateway
ping 192.168.1.254

# Ping external host
ping 8.8.8.8

# IPv6 ping
ping6 google.com

# Ping through specific interface
ping -I en0 8.8.8.8
```

## Policy Routing

**Current Policy:**
- Default traffic → en0 (Wi-Fi) → 192.168.1.254
- Tailscale traffic → utun3 → Tailscale network
- VM traffic → bridge100 → NAT → en0

## Route Flags Explained

- **U:** Route is up
- **G:** Route is to a gateway
- **H:** Route is to a host (not a network)
- **S:** Route was statically configured
- **C:** Route was created by cloning from a network route
- **W:** Route was cloned from a network route
- **L:** Link-layer (hardware) address present
- **I:** Route is associated with an interface
- **i:** Route ignores redirects
- **r:** Route is a router
- **m:** Route is modified by a redirect

## Troubleshooting Routing Issues

### No internet connectivity:
```bash
# Check default gateway
netstat -rn | grep default

# Ping gateway
ping 192.168.1.254

# Ping external IP
ping 8.8.8.8

# Check if gateway responds
arp -a | grep 192.168.1.254
```

### Routing to specific network fails:
```bash
# Check if route exists
netstat -rn | grep <network>

# Trace route path
traceroute <destination>

# Add missing route
sudo route add -net <network> <gateway>
```

### Multiple default gateways:
```bash
# List all default gateways
netstat -rn | grep default

# Remove unwanted gateway
sudo route delete default <gateway_to_remove>
```

### VPN routing issues:
```bash
# Check VPN interface
ifconfig utun3

# Check VPN routes
netstat -rn | grep utun3

# Test VPN connectivity
ping 100.100.100.100
```

## Network Performance

### Path MTU Discovery:
- en0 MTU: 1500 bytes
- utun3 MTU: 1280 bytes (VPN overhead)
- bridge100 MTU: 1500 bytes

**Note:** VPN connections have lower MTU due to encryption overhead

### Recommended MTU Testing:
```bash
# Test MTU to gateway
ping -D -s 1472 192.168.1.254

# Test MTU to internet
ping -D -s 1472 8.8.8.8

# If fragmentation occurs, reduce packet size
```

## Notes

- Primary internet routing via en0 through 192.168.1.254
- Tailscale provides mesh VPN routing through 100.64.0.0/10
- VM networking uses NAT through bridge100 (192.168.64.0/24)
- Multiple VPN tunnels (utun0-3) for different services
- IPv6 is fully enabled with autoconfiguration
- Multicast routing enabled for service discovery (Bonjour, mDNS)
