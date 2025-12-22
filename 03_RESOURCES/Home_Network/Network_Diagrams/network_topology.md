# Network Topology

Visual representation and description of the home network layout.

## Network Overview

```
                                 Internet
                                    |
                                    |
                         [ISP Router/Modem]
                         192.168.1.254
                         e4:26:86:72:0d:f0
                                    |
                                    |
                        -------------------------
                        |           |           |
                        |           |           |
                  [Device 1]  [Device 2]  [Zapata MacBook Air]
                192.168.1.64  192.168.1.68   192.168.1.71
                                              7c:04:d0:c4:b5:62
                                                    |
                                                    |
                                          ---------------------
                                          |                   |
                                   [Tailscale VPN]      [VM Bridge]
                                   100.110.53.154     192.168.64.1
                                      utun3            bridge100
                                          |                   |
                                          |                   |
                                   [Tailscale Net]     [Virtual Machines]
                                   100.64.0.0/10      192.168.64.0/24
```

## Network Layers

### Layer 1: Internet Connection
- **ISP Connection** → External network (details TBD)
- **Public IP:** [Check with: curl ifconfig.me]

### Layer 2: Home Gateway
- **Router:** 192.168.1.254
- **MAC:** e4:26:86:72:0d:f0
- **Function:** Gateway, DHCP server, NAT, firewall
- **Network:** 192.168.1.0/24

### Layer 3: Local Devices
**Connected to 192.168.1.0/24:**
- Zapata (MacBook Air): 192.168.1.71
- Device 1: 192.168.1.64
- Device 2: 192.168.1.68
- [Additional devices to be documented]

### Layer 4: Virtual Networks

**Tailscale VPN (utun3):**
- Local Endpoint: 100.110.53.154
- Network Range: 100.64.0.0/10
- Tailscale Network: tailfd62a.ts.net
- Purpose: Secure remote access and mesh networking

**VM Bridge (bridge100):**
- Bridge IP: 192.168.64.1
- VM Network: 192.168.64.0/24
- Purpose: NAT networking for virtual machines

## IP Address Allocation

### 192.168.1.0/24 (Home Network)

| IP Address | Device | MAC Address | Type | Status |
|------------|--------|-------------|------|--------|
| 192.168.1.1 | Reserved | - | Reserved | - |
| 192.168.1.64 | Unknown Device | a8:80:55:f1:2c:83 | ? | Active |
| 192.168.1.68 | Unknown Device | 7e:a9:f9:aa:d7:fe | ? | Active |
| 192.168.1.71 | Zapata MacBook Air | 7c:04:d0:c4:b5:62 | Computer | Active |
| 192.168.1.254 | Gateway/Router | e4:26:86:72:0d:f0 | Router | Active |

**Available Range:** 192.168.1.2-192.168.1.63, 192.168.1.72-192.168.1.253

### 192.168.64.0/24 (VM Network)

| IP Address | Device | Type | Status |
|------------|--------|------|--------|
| 192.168.64.1 | Bridge Gateway | Bridge | Active |
| 192.168.64.2-254 | VM Pool | VMs | Available |

### 100.64.0.0/10 (Tailscale Network)

| IP Address | Device | Network | Status |
|------------|--------|---------|--------|
| 100.100.100.100 | Tailscale Coordination | Control Plane | Active |
| 100.110.53.154 | Zapata (Tailscale) | Data Plane | Active |

## VLAN Configuration

**Current Setup:** No VLANs configured (flat network)

**Recommended VLANs for Future:**
- VLAN 1: Management (192.168.1.0/24)
- VLAN 10: Trusted devices (computers, phones)
- VLAN 20: IoT devices (smart home devices)
- VLAN 30: Guest network
- VLAN 40: Servers/NAS

## Network Segmentation

**Current Segmentation:**
1. **Physical Network:** 192.168.1.0/24 (Home LAN)
2. **Virtual Network:** 192.168.64.0/24 (VMs)
3. **VPN Network:** 100.64.0.0/10 (Tailscale)

**Communication Rules:**
- Physical ↔ Internet: Allowed (via NAT)
- Physical ↔ Virtual: Allowed (via bridge NAT)
- Physical ↔ VPN: Allowed (via Tailscale)
- Virtual ↔ Internet: Allowed (via NAT through physical)
- VPN ↔ Internet: Allowed (via Tailscale)

## Traffic Flow Diagrams

### Outbound Internet Traffic (from Zapata)

```
[Zapata] → en0 (192.168.1.71)
    ↓
[Router] (192.168.1.254) → NAT
    ↓
[Internet]
```

### VM to Internet Traffic

```
[VM] → bridge100 (192.168.64.x)
    ↓
[Bridge Gateway] (192.168.64.1) → NAT
    ↓
[Zapata en0] (192.168.1.71)
    ↓
[Router] (192.168.1.254) → NAT
    ↓
[Internet]
```

### Tailscale VPN Traffic

```
[Zapata] → utun3 (100.110.53.154)
    ↓
[Tailscale Network] (encrypted tunnel)
    ↓
[Remote Tailscale Device]
```

### Local Device Communication

```
[Zapata] (192.168.1.71) ↔ [Router] (192.168.1.254) ↔ [Other Device] (192.168.1.x)
```

## IPv6 Topology

**Home Network (2806:104e:16:2889::/64):**
- Gateway: fe80::e626:86ff:fe72:df0
- Zapata: 2806:104e:16:2889:1416:485c:7784:c068
- Privacy Address: 2806:104e:16:2889:14ce:4a1c:6422:5c74

**Tailscale ULA (fd7a:115c:a1e0::/48):**
- Zapata: fd7a:115c:a1e0:ab12:4843:cd96:626e:359a

**VM Network (fd09:e29d:3df9:5226::/64):**
- Bridge: fd09:e29d:3df9:5226:4ae:3961:dcd9:e63

## Wireless Configuration

**Primary Wi-Fi (en0):**
- Standard: 802.11ac (assumed based on 2015 MacBook Air)
- Frequency: 2.4 GHz and 5 GHz capable
- Security: [Check router settings]
- SSID: [Check with: networksetup -getairportnetwork en0]

**Apple Wireless Direct Link (awdl0):**
- Purpose: AirDrop, AirPlay
- Peer-to-peer mesh network
- MAC: 56:3d:bf:5d:ce:67

## Network Services

### Active Services:
- **DNS:** Cloudflare (1.1.1.1), Google (8.8.8.8), Tailscale (100.100.100.100)
- **DHCP:** Provided by router (192.168.1.254)
- **mDNS:** Enabled (Bonjour, .local domains)
- **VPN:** Tailscale (active)

### Multicast Services:
- **224.0.0.251:** mDNS (service discovery)
- **239.255.255.250:** SSDP (UPnP device discovery)

## Physical Connections

**Zapata MacBook Air:**
- Connection Type: Wi-Fi (en0)
- No Ethernet port (USB adapter required for wired)

## Network Diagram Legend

```
[Device]     - Network device
→           - Unidirectional traffic flow
↔           - Bidirectional traffic flow
|           - Network connection
```

## Topology Type

**Current:** Star topology (all devices connect to central router)

**Characteristics:**
- ✅ Simple to set up and manage
- ✅ Easy to add/remove devices
- ✅ Failure of one device doesn't affect others
- ❌ Single point of failure (router)
- ❌ Router performance bottleneck

## Recommended Improvements

1. **Document Unknown Devices:** Identify 192.168.1.64 and 192.168.1.68
2. **Static IP Assignment:** Assign static IPs to critical devices
3. **Network Segmentation:** Implement VLANs for security
4. **Additional Access Point:** For better Wi-Fi coverage (if needed)
5. **Guest Network:** Separate network for guests
6. **IoT Isolation:** Separate IoT devices from main network

## Drawing Tools

To create visual network diagrams:

**Online Tools:**
- draw.io (diagrams.net) - Free, web-based
- Lucidchart - Professional diagrams
- Cloudcraft - AWS-focused but good for networks
- Gliffy - Simple network diagrams

**Desktop Tools:**
- Microsoft Visio - Professional (paid)
- OmniGraffle (Mac) - Professional (paid)
- yEd - Free graph editor
- Inkscape - Free vector graphics

**CLI Tools:**
- Graphviz - Generate diagrams from code
- PlantUML - UML and network diagrams from text

## Export Current Network Map

```bash
# Scan network and create map
sudo nmap -sn 192.168.1.0/24 -oX network_scan.xml

# Convert to visual format (requires tools)
# Various third-party tools can parse nmap XML output
```

## Notes

- This is a simplified home network topology
- No managed switches currently in use
- No separate firewall device (router handles firewall)
- Tailscale provides mesh VPN without complex port forwarding
- VM networking is NAT-based (not bridged to physical network)
