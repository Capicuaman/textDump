# IP Address Scheme

Detailed IP address allocation and planning for home network.

## Network Subnets

### Primary Network: 192.168.1.0/24

**Network Information:**
- Network Address: 192.168.1.0
- Subnet Mask: 255.255.255.0
- CIDR: /24
- Broadcast: 192.168.1.255
- Usable IPs: 192.168.1.1 - 192.168.1.254 (254 addresses)
- Gateway: 192.168.1.254

**Address Allocation Plan:**

| Range | Purpose | Status |
|-------|---------|--------|
| 192.168.1.1 | Reserved | Available |
| 192.168.1.2-192.168.1.50 | Static assignments | Mostly available |
| 192.168.1.51-192.168.1.200 | DHCP pool | Active |
| 192.168.1.201-192.168.1.253 | Reserved for servers | Available |
| 192.168.1.254 | Gateway/Router | In use |

### VM Network: 192.168.64.0/24

**Network Information:**
- Network Address: 192.168.64.0
- Subnet Mask: 255.255.255.0
- CIDR: /24
- Broadcast: 192.168.64.255
- Usable IPs: 192.168.64.1 - 192.168.64.254 (254 addresses)
- Gateway: 192.168.64.1 (bridge100)

**Address Allocation:**

| Range | Purpose | Status |
|-------|---------|--------|
| 192.168.64.1 | Bridge gateway | In use |
| 192.168.64.2-192.168.64.254 | VM DHCP pool | Available |

### Tailscale Network: 100.64.0.0/10

**Network Information:**
- Network Address: 100.64.0.0
- Subnet Mask: 255.192.0.0
- CIDR: /10
- Address Range: 100.64.0.0 - 100.127.255.255
- Total IPs: 4,194,304 addresses
- Purpose: Carrier-Grade NAT (CGNAT) / Tailscale VPN

**Special Addresses:**
- 100.100.100.100: Tailscale coordination server
- 100.110.53.154: This device (Zapata)

**Note:** Tailscale automatically assigns IPs from this range

## Static IP Assignments

### Current Static Assignments

| IP Address | Hostname | MAC Address | Device Type | Location |
|------------|----------|-------------|-------------|----------|
| 192.168.1.254 | Gateway | e4:26:86:72:0d:f0 | Router | TBD |
| 192.168.64.1 | vm-bridge | 7e:04:d0:4c:39:64 | Virtual Bridge | Zapata |

### DHCP Assignments (Dynamic)

| IP Address | MAC Address | Device Name | Last Seen |
|------------|-------------|-------------|-----------|
| 192.168.1.71 | 7c:04:d0:c4:b5:62 | Zapata | Active |
| 192.168.1.64 | a8:80:55:f1:2c:83 | Unknown | Active |
| 192.168.1.68 | 7e:a9:f9:aa:d7:fe | Unknown | Active |

### Recommended Static IP Assignments

**Servers and Infrastructure:**
- 192.168.1.1: [Available for secondary router/switch]
- 192.168.1.10: NAS device
- 192.168.1.11: Media server
- 192.168.1.12: Home automation hub
- 192.168.1.13: Print server

**Computers:**
- 192.168.1.20-29: Desktop computers
- 192.168.1.30-39: Laptops
- 192.168.1.40-49: Tablets

**IoT Devices:**
- 192.168.1.100-150: Smart home devices
- 192.168.1.151-160: Security cameras
- 192.168.1.161-170: Smart speakers

**Network Equipment:**
- 192.168.1.201: Managed switch
- 192.168.1.202: Wireless access point
- 192.168.1.203: Secondary access point
- 192.168.1.254: Primary router/gateway

## IPv6 Address Scheme

### Global Unicast (2806:104e:16:2889::/64)

**Prefix:** 2806:104e:16:2889::/64
**Source:** ISP-assigned (autoconfigured via SLAAC)

**Zapata Addresses:**
- Stable: 2806:104e:16:2889:1416:485c:7784:c068/64
- Privacy: 2806:104e:16:2889:14ce:4a1c:6422:5c74/64
- Link-Local: fe80::1838:7f5c:b50b:be06/64

### Unique Local Address (ULA)

**Tailscale ULA:** fd7a:115c:a1e0::/48
- Zapata: fd7a:115c:a1e0:ab12:4843:cd96:626e:359a/48

**VM Network ULA:** fd09:e29d:3df9:5226::/64
- Bridge: fd09:e29d:3df9:5226:4ae:3961:dcd9:e63/64

### Link-Local Addresses (fe80::/10)

Each interface has its own link-local address:
- en0: fe80::1838:7f5c:b50b:be06/64
- awdl0: fe80::543d:bfff:fe5d:ce67/64
- llw0: fe80::543d:bfff:fe5d:ce67/64
- utun3: fe80::7e04:d0ff:fec4:b562/64
- bridge100: fe80::7c04:d0ff:fe4c:3964/64

## Subnet Calculator

### /24 Network (Most home networks)

```
Network:     192.168.1.0/24
Mask:        255.255.255.0
Wildcard:    0.0.0.255
First IP:    192.168.1.1
Last IP:     192.168.1.254
Broadcast:   192.168.1.255
Total Hosts: 254
```

### Common Subnet Masks

| CIDR | Subnet Mask | Hosts | Common Use |
|------|-------------|-------|------------|
| /8   | 255.0.0.0 | 16,777,214 | Class A networks |
| /16  | 255.255.0.0 | 65,534 | Class B networks |
| /24  | 255.255.255.0 | 254 | Most home networks |
| /25  | 255.255.255.128 | 126 | Split networks |
| /26  | 255.255.255.192 | 62 | Small segments |
| /27  | 255.255.255.224 | 30 | Very small segments |
| /28  | 255.255.255.240 | 14 | Point-to-point |
| /30  | 255.255.255.252 | 2 | Router links |
| /32  | 255.255.255.255 | 1 | Host route |

## Private IP Ranges (RFC 1918)

| Range | CIDR | Addresses | Usage |
|-------|------|-----------|-------|
| 10.0.0.0 - 10.255.255.255 | 10.0.0.0/8 | 16,777,216 | Large networks |
| 172.16.0.0 - 172.31.255.255 | 172.16.0.0/12 | 1,048,576 | Medium networks |
| 192.168.0.0 - 192.168.255.255 | 192.168.0.0/16 | 65,536 | Home/small networks |

**Current Network:** 192.168.1.0/24 (common home router default)

## Special IP Addresses

### Reserved/Special IPv4:

- **0.0.0.0/8:** "This network"
- **10.0.0.0/8:** Private network (RFC 1918)
- **100.64.0.0/10:** Carrier-grade NAT (RFC 6598) - Tailscale
- **127.0.0.0/8:** Loopback
- **169.254.0.0/16:** Link-local (APIPA)
- **172.16.0.0/12:** Private network (RFC 1918)
- **192.0.0.0/24:** IETF Protocol Assignments
- **192.0.2.0/24:** Documentation (TEST-NET-1)
- **192.168.0.0/16:** Private network (RFC 1918)
- **224.0.0.0/4:** Multicast
- **240.0.0.0/4:** Reserved
- **255.255.255.255/32:** Broadcast

### Reserved/Special IPv6:

- **::/128:** Unspecified address
- **::1/128:** Loopback
- **fe80::/10:** Link-local
- **fc00::/7:** Unique local addresses (ULA)
- **ff00::/8:** Multicast

## DHCP Configuration

**Router DHCP Server:** 192.168.1.254

**Estimated Settings:**
- Pool Start: 192.168.1.51 (assumed)
- Pool End: 192.168.1.200 (assumed)
- Lease Time: 24 hours (typical)
- DNS Servers: 1.1.1.1, 8.8.8.8 (configured)
- Default Gateway: 192.168.1.254

**VM DHCP Server:** bridge100 (192.168.64.1)
- Pool: 192.168.64.2-254
- Purpose: Automatic VM IP assignment

## IP Assignment Best Practices

### Documentation:
1. Always document static IP assignments
2. Keep MAC address records
3. Note device purpose and location
4. Track lease information for important devices

### Static vs. DHCP:
- **Static:** Servers, network equipment, printers
- **DHCP:** Laptops, phones, tablets, guest devices
- **Reserved DHCP:** IoT devices, smart home (DHCP reservation by MAC)

### Organization:
- Group by device type (servers, workstations, IoT)
- Use sequential numbering within groups
- Leave gaps for future expansion
- Document everything

### Security:
- Avoid using .1 for gateway (prevents scanning guess)
- Consider using non-standard private ranges (172.16.x.x)
- Implement network segmentation with multiple subnets
- Use DHCP snooping if switches support it

## IP Planning Commands

### Check current IP:
```bash
ifconfig en0 | grep "inet "
```

### Check DHCP lease:
```bash
ipconfig getpacket en0
```

### Renew DHCP lease:
```bash
sudo ipconfig set en0 DHCP
```

### Set static IP:
```bash
sudo networksetup -setmanual "Wi-Fi" 192.168.1.71 255.255.255.0 192.168.1.254
```

### View all IPs on network:
```bash
arp -a
sudo nmap -sn 192.168.1.0/24
```

## Future Network Planning

### If Network Grows:

**Option 1: Expand current subnet**
- Change to /23 (192.168.1.0/23)
- Provides 512 addresses (192.168.0-1.x)

**Option 2: Add VLANs**
- VLAN 10: 192.168.10.0/24 (Trusted devices)
- VLAN 20: 192.168.20.0/24 (IoT)
- VLAN 30: 192.168.30.0/24 (Guest)
- VLAN 40: 192.168.40.0/24 (Servers)

**Option 3: Move to larger private range**
- Use 10.0.0.0/8 or 172.16.0.0/12
- Provides much more address space

## Notes

- Current network is simple /24 (adequate for most homes)
- 254 addresses sufficient for typical home use
- Tailscale handles VPN addressing automatically
- IPv6 uses SLAAC (automatic configuration) from ISP
- Consider static IPs for devices you access by IP
- Document any changes to IP scheme immediately
