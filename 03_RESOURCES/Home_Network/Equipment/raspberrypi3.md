# Raspberry Pi 3 - raspberrypi3

## Hardware Specifications

- **Model:** Raspberry Pi 3
- **Architecture:** aarch64

## Software Configuration

- **Operating System:** Manjaro ARM Linux 24.04
- **Kernel Version:** Linux 6.12.41-1-MANJARO-RPI4

## Network Interfaces

### Physical Interfaces
- **enu1u1u1 (Ethernet):**
  - MAC Address: `b8:27:eb:d0:9b:d2`
  - Status: UP
- **wlan0 (Wireless):**
  - MAC Address: `26:b6:37:03:71:36`
  - Status: DOWN

### Virtual Interfaces
- **tailscale0:**
  - Status: UP
- **Docker Interfaces:**
  - `docker0`
  - `br-7415c36fc5a0`
  - `br-f727e171419a`
  - Various `veth` interfaces

## Network Configuration

- **Tailscale IP:**
  - IPv4: `100.68.220.78`
  - IPv6: `fd7a:115c:a1e0::5001:dc52`
- **DNS Server:** `100.100.100.100` (via Tailscale)

## Network Diagnostics

- **Ping to 8.8.8.8:** Successful (avg. 6.567 ms)

## Services and Ports

- Information on listening ports is unavailable as the `netstat` and `lsof` commands failed during data collection.

## Data Collection Notes

The following commands failed during the information gathering process:
- `hostname`
- `ifconfig`
- `netstat`
- `arp`

This may indicate that these commands are not installed or not in the system's PATH. The hostname was inferred from the Tailscale status.
