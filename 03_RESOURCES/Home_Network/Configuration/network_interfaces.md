# Network Interfaces Configuration

Configuration details for all network interfaces on Zapata (MacBook Air).

## Primary Wi-Fi Interface (en0)

**Status:** Active
**Type:** IEEE 802.11 Wireless

**IPv4 Configuration:**
- IP Address: 192.168.1.71
- Subnet Mask: 255.255.255.0 (/24)
- Broadcast: 192.168.1.255
- Network: 192.168.1.0/24

**IPv6 Configuration:**
- Link-Local: fe80::1838:7f5c:b50b:be06%en0/64 (secured)
- Global IPv6: 2806:104e:16:2889:1416:485c:7784:c068/64 (autoconf secured)
- Temporary IPv6: 2806:104e:16:2889:14ce:4a1c:6422:5c74/64 (autoconf temporary)

**Hardware:**
- MAC Address: 7c:04:d0:c4:b5:62
- MTU: 1500
- Media: autoselect
- Options: CHANNEL_IO

**Neighbor Discovery (nd6):**
- Options: PERFORMNUD, DAD

## Loopback Interface (lo0)

**Status:** Active
**Type:** Loopback

**Configuration:**
- IPv4: 127.0.0.1/8
- IPv6: ::1/128
- IPv6 Link-Local: fe80::1%lo0/64
- MTU: 16384
- Flags: UP, LOOPBACK, RUNNING, MULTICAST

## Tailscale VPN (utun3)

**Status:** Active
**Type:** Point-to-Point VPN Tunnel

**IPv4 Configuration:**
- IP Address: 100.110.53.154
- Point-to-Point: 100.110.53.154
- Subnet Mask: 255.255.255.255 (/32)

**IPv6 Configuration:**
- Link-Local: fe80::7e04:d0ff:fec4:b562%utun3/64
- ULA Address: fd7a:115c:a1e0:ab12:4843:cd96:626e:359a/48
- Network: tailfd62a.ts.net

**Settings:**
- MTU: 1280
- Options: RXCSUM, TXCSUM, TSO4, TSO6, CHANNEL_IO, PARTIAL_CSUM, ZEROINVERT_CSUM
- Neighbor Discovery: PERFORMNUD, DAD

## VM Bridge (bridge100)

**Status:** Active
**Type:** Network Bridge for Virtual Machines

**IPv4 Configuration:**
- IP Address: 192.168.64.1
- Subnet Mask: 255.255.255.0 (/24)
- Broadcast: 192.168.64.255

**IPv6 Configuration:**
- Link-Local: fe80::7c04:d0ff:fe4c:3964%bridge100/64
- ULA: fd09:e29d:3df9:5226:4ae:3961:dcd9:e63/64 (autoconf secured)

**Hardware:**
- MAC Address: 7e:04:d0:4c:39:64
- MTU: 1500
- Options: RXCSUM, TXCSUM, TSO4, TSO6

**Bridge Configuration:**
- Protocol: STP (Spanning Tree Protocol)
- Member: vmenet0
- Max Address: 100
- Timeout: 1200 seconds
- IP Filter: Disabled

**Purpose:** Provides NAT networking for virtual machines

## Secondary Interfaces

### en1 (Secondary Network)
- Status: Inactive
- MAC: 82:18:32:c6:58:40
- MTU: 1500
- Options: TSO4, TSO6, CHANNEL_IO
- Mode: Promiscuous (member of bridge0)

### bridge0 (Inactive Bridge)
- Status: Inactive
- MAC: 82:18:32:c6:58:40
- Member: en1
- Protocol: STP

### p2p0 (Peer-to-Peer)
- Status: Inactive
- MAC: 0e:04:d0:c4:b5:62
- MTU: 2304
- Purpose: Direct device-to-device communication

### awdl0 (Apple Wireless Direct Link)
- Status: Active
- MAC: 56:3d:bf:5d:ce:67
- IPv6: fe80::543d:bfff:fe5d:ce67%awdl0/64
- MTU: 1484
- Purpose: AirDrop, AirPlay, peer services

### llw0 (Low Latency WLAN)
- Status: Active
- MAC: 56:3d:bf:5d:ce:67
- IPv6: fe80::543d:bfff:fe5d:ce67%llw0/64
- MTU: 1500
- Purpose: Low-latency wireless communication

### utun0, utun1, utun2
- Status: Active
- Type: VPN/Tunnel interfaces
- MTU: 1380, 2000, 1000 respectively
- Purpose: Various VPN/tunneling services

## Interface Priority

**Primary Internet:** en0 (Wi-Fi)
**VPN Access:** utun3 (Tailscale)
**VM Networking:** bridge100
**Local Services:** awdl0, llw0

## Configuration Commands

### View interface configuration:
```bash
ifconfig en0
```

### View all interfaces:
```bash
ifconfig
```

### List network hardware:
```bash
networksetup -listallhardwareports
```

### Get Wi-Fi info:
```bash
networksetup -getinfo "Wi-Fi"
```

### View active connections:
```bash
netstat -an | grep ESTABLISHED
```

## Network Services

### Enable/Disable Wi-Fi:
```bash
networksetup -setairportpower en0 on
networksetup -setairportpower en0 off
```

### Set static IP:
```bash
sudo networksetup -setmanual "Wi-Fi" 192.168.1.71 255.255.255.0 192.168.1.254
```

### Set DHCP:
```bash
sudo networksetup -setdhcp "Wi-Fi"
```

## Notes

- en0 is the primary interface for internet connectivity
- Tailscale (utun3) provides secure VPN access to remote resources
- bridge100 is used for VM networking on subnet 192.168.64.0/24
- IPv6 is enabled and autoconfigured on primary interfaces
- Multiple tunnel interfaces (utun0-3) suggest various VPN/service connections
