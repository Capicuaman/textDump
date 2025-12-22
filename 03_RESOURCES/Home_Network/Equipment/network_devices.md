# Network Devices

This document lists all detected devices on the home network.

## Router/Gateway

**Primary Gateway:**
- IP Address: 192.168.1.254
- MAC Address: e4:26:86:72:0d:f0
- Type: Router/Gateway
- Interface: Connected via en0 (Wi-Fi)
- Status: Active (default gateway)

**Manufacturer:** [Run `nmap` or lookup MAC vendor to identify]

## Active Network Devices

### Device 1
- IP Address: 192.168.1.64
- MAC Address: a8:80:55:f1:2c:83
- Status: Active
- Interface: en0 (Wi-Fi)
- Notes: [Add device name/description]

### Device 2
- IP Address: 192.168.1.68
- MAC Address: 7e:a9:f9:aa:d7:fe
- Status: Active
- Interface: en0 (Wi-Fi)
- Notes: [Add device name/description]

### This Computer (Zapata)
- IP Address: 192.168.1.71
- MAC Address: 7c:04:d0:c4:b5:62
- Hostname: Zapata
- Type: MacBook Air (2015)
- Status: Active

### VM Bridge Network
- IP Address: 192.168.64.1
- MAC Address: 7e:04:d0:4c:39:64
- Interface: bridge100
- Type: Virtual machine bridge
- Purpose: Provides networking for local VMs

## Tailscale VPN Network

### Tailscale Gateway
- IP Address: 100.100.100.100
- Interface: utun3
- Purpose: Tailscale DNS and coordination server

### This Computer (Tailscale)
- Tailscale IP: 100.110.53.154
- IPv6 ULA: fd7a:115c:a1e0:ab12:4843:cd96:626e:359a
- Network Name: tailfd62a.ts.net
- Interface: utun3
- Status: Active

## Multicast Addresses

- 224.0.0.251 (mdns.mcast.net) - mDNS/Bonjour service discovery
- 239.255.255.250 - SSDP (Simple Service Discovery Protocol)

## Network Scanning Commands

To discover more devices on your network:

```bash
# Scan local network
sudo nmap -sn 192.168.1.0/24

# Detailed device scan
sudo nmap -sS -O 192.168.1.0/24

# ARP scan (faster)
arp-scan --localnet

# Show current ARP cache
arp -a
```

## Device Inventory Template

When adding new devices, include:

```markdown
### [Device Name]
- IP Address:
- MAC Address:
- Manufacturer:
- Device Type:
- Operating System:
- Purpose:
- Purchase Date:
- Warranty Info:
- Notes:
```

## Notes

- Update this list regularly as devices join/leave the network
- Use static IP assignments for critical devices
- Document MAC addresses for MAC filtering if needed
- Keep track of DHCP lease information
