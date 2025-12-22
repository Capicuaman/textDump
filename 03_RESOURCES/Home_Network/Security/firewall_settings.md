# Firewall Settings

macOS and network firewall configuration for Zapata.

## macOS Application Firewall

**Status:** [Run: `sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate`]

**Type:** Application-based firewall (not port-based)
**Location:** System Preferences > Security & Privacy > Firewall

### Firewall Modes:

1. **Block all incoming connections**
   - Most restrictive
   - Blocks all sharing services
   - Allows only essential system services

2. **Allow specific applications** (Recommended)
   - Default mode
   - Allows built-in software
   - Prompts for third-party apps

3. **Firewall off**
   - No protection
   - Not recommended

### Common Firewall Commands:

```bash
# Check firewall status
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate

# Enable firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# Disable firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate off

# Enable stealth mode (don't respond to pings)
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

# List allowed applications
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --listapps

# Block an application
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --blockapp /path/to/app

# Allow an application
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --add /path/to/app
```

## Network Router Firewall

**Router:** 192.168.1.254

**Typical Router Firewall Features:**
- NAT (Network Address Translation) - Built-in security
- SPI (Stateful Packet Inspection)
- DoS (Denial of Service) protection
- Port forwarding rules
- DMZ configuration
- MAC filtering

**Access Router Settings:**
- URL: http://192.168.1.254 (typical)
- Check router manual for default credentials
- Common defaults: admin/admin, admin/password

### Recommended Router Security Settings:

1. **Change default admin password**
2. **Enable WPA3 or WPA2 encryption** (not WEP/WPA)
3. **Disable WPS** (Wi-Fi Protected Setup)
4. **Disable UPnP** unless needed
5. **Enable firewall**
6. **Disable remote management** unless needed
7. **Update firmware regularly**
8. **Change default SSID**
9. **Disable SSID broadcast** (optional)
10. **Enable MAC filtering** (optional)

## Open Ports

### Check open ports on this machine:

```bash
# List all listening ports
sudo lsof -i -P | grep LISTEN

# Alternative
netstat -an | grep LISTEN

# Check specific port
lsof -i :80
```

### Common Port Numbers:

| Port | Service | Status | Purpose |
|------|---------|--------|---------|
| 22 | SSH | Check | Secure shell access |
| 80 | HTTP | Check | Web server |
| 443 | HTTPS | Check | Secure web server |
| 445 | SMB | Check | File sharing |
| 548 | AFP | Check | Apple File Protocol |
| 5353 | mDNS | Active | Bonjour/service discovery |
| 8080 | HTTP Alt | Check | Alternative web server |

### Scan open ports:

```bash
# Scan localhost
nmap localhost

# Scan this machine from network
nmap 192.168.1.71

# Scan router
nmap 192.168.1.254

# Full network scan
sudo nmap -sS 192.168.1.0/24
```

## Tailscale Security

**Status:** Active (utun3)
**IP:** 100.110.53.154
**Network:** tailfd62a.ts.net

### Tailscale Security Features:

1. **End-to-end encryption** - WireGuard protocol
2. **Zero trust networking** - No open ports required
3. **Identity-based access** - Not IP-based
4. **Automatic key rotation**
5. **MFA support**
6. **Access control lists (ACLs)**

### Tailscale Commands:

```bash
# Check Tailscale status
tailscale status

# View IP addresses
tailscale ip

# Check connection quality to peers
tailscale ping <device>

# Enable/disable Tailscale
tailscale up
tailscale down

# View active routes
tailscale route
```

### Tailscale ACL Configuration:

Access Tailscale admin console:
- URL: https://login.tailscale.com/admin
- Configure ACLs to restrict access between devices
- Set up subnet routing if needed
- Enable key expiration

## macOS Security Settings

### System Integrity Protection (SIP):
**Status:** Enabled ✅

**Check status:**
```bash
csrutil status
```

**What it protects:**
- System files and directories
- Running processes
- Kernel extensions

### Secure Virtual Memory:
**Status:** Enabled ✅

**Purpose:** Encrypts swap file on disk

### FileVault (Disk Encryption):
**Status:** [Check: System Preferences > Security & Privacy > FileVault]

**Recommended:** Enable for full disk encryption

**Check status:**
```bash
fdesetup status
```

### Gatekeeper (App Security):
**Status:** [Check: System Preferences > Security & Privacy > General]

**Modes:**
- App Store only
- App Store and identified developers (Recommended)
- Anywhere (Not recommended)

### XProtect (Anti-malware):
**Status:** Enabled (automatic)

**Built-in macOS malware protection**
**Updates:** Automatic through system updates

## Network Security Best Practices

### Wi-Fi Security:
1. ✅ Use WPA3 or WPA2-PSK encryption
2. ✅ Use strong passphrase (20+ characters)
3. ❓ Consider hiding SSID (security through obscurity)
4. ❓ Enable MAC filtering (can be bypassed)
5. ✅ Disable WPS
6. ✅ Use strong admin password on router
7. ✅ Keep router firmware updated

### Network Monitoring:
```bash
# Monitor network connections
sudo lsof -i

# Watch for suspicious activity
sudo tcpdump -i en0 -n

# Check active connections
netstat -an | grep ESTABLISHED

# Monitor bandwidth by process
sudo iftop -i en0
```

### DNS Security:
- ✅ Using Cloudflare (1.1.1.1) - Privacy-focused
- ✅ Using Google (8.8.8.8) - Reliable
- ✅ DNSSEC support available
- ❌ DNS over HTTPS (DoH) not configured
- ❌ DNS over TLS (DoT) not configured

**Consider enabling DoH:**
```bash
# Firefox: Settings > Network Settings > Enable DNS over HTTPS
# Chrome: Settings > Security > Use secure DNS
# System-wide: Use dnscrypt-proxy or Cloudflare WARP
```

### Port Security:
- Close unnecessary open ports
- Use VPN (Tailscale) for remote access instead of port forwarding
- Regularly scan for open ports
- Disable unused services

## VPN Configuration

### Tailscale (Active):
- **Protocol:** WireGuard
- **Encryption:** ChaCha20-Poly1305
- **Key Exchange:** Noise_IK
- **Authentication:** OAuth (Google, Microsoft, etc.)
- **Status:** Connected

### Additional VPN Options:
- OpenVPN
- L2TP/IPsec
- IKEv2/IPsec
- PPTP (deprecated, insecure)

## Security Monitoring

### Log Files:

**System logs:**
```bash
# View system log
log show --predicate 'eventMessage contains "error"' --last 1h

# Security log
log show --predicate 'process == "securityd"' --last 1h

# Firewall log
log show --predicate 'process == "socketfilterfw"' --last 1h
```

**Network logs:**
```bash
# Connection attempts
log show --predicate 'process == "tcpd"' --last 1h
```

### Intrusion Detection:

**Consider installing:**
- Little Snitch (outbound firewall)
- LuLu (free outbound firewall)
- ReiKey (keyboard/mouse tap detection)
- BlockBlock (persistent software detection)

### Security Scanning:

```bash
# Scan for malware (if installed)
# ClamAV, Malwarebytes, etc.

# Check for suspicious processes
ps aux | grep -v "^_"

# Check for suspicious network connections
sudo lsof -i | grep -i established
```

## Incident Response

### If Compromise Suspected:

1. **Disconnect from network**
   ```bash
   sudo ifconfig en0 down
   ```

2. **Change passwords** (from different device)

3. **Check for unauthorized access**
   ```bash
   last
   who
   w
   ```

4. **Review logs**
   ```bash
   log show --last 24h > incident_log.txt
   ```

5. **Scan for malware**

6. **Backup important data**

7. **Consider fresh OS install** if severely compromised

## Security Checklist

### Daily/Weekly:
- [ ] Check for system updates
- [ ] Review unusual network activity
- [ ] Check firewall status

### Monthly:
- [ ] Update router firmware
- [ ] Review firewall rules
- [ ] Scan for malware
- [ ] Review connected devices
- [ ] Check for suspicious processes
- [ ] Review password strength

### Quarterly:
- [ ] Change Wi-Fi password
- [ ] Change router admin password
- [ ] Review Tailscale ACLs
- [ ] Audit user accounts
- [ ] Review port forwarding rules
- [ ] Test backup restoration

### Annually:
- [ ] Full security audit
- [ ] Consider penetration testing
- [ ] Review network topology
- [ ] Update disaster recovery plan

## Security Tools

### Recommended macOS Security Tools:

**Firewall:**
- Little Snitch ($45) - Outbound firewall
- LuLu (Free) - Open source outbound firewall

**Network Monitoring:**
- Wireshark (Free) - Packet analyzer
- Little Snitch (includes network monitor)

**Anti-malware:**
- Malwarebytes (Free/Paid)
- ClamAV (Free, open source)
- XProtect (Built-in)

**VPN:**
- Tailscale (Free tier available) ✅ In use
- ProtonVPN
- Mullvad VPN

**Password Management:**
- 1Password
- Bitwarden (Free)
- iCloud Keychain (Built-in)

## References

- Apple Security Guide: https://support.apple.com/guide/security/welcome/web
- Tailscale Documentation: https://tailscale.com/kb/
- NIST Cybersecurity Framework
- CIS Benchmarks for macOS

## Notes

- System Integrity Protection is enabled (good)
- Tailscale provides encrypted VPN access
- Router firewall provides NAT-based protection
- Regular updates are critical for security
- Consider enabling FileVault for full disk encryption
- DNS privacy could be improved with DoH/DoT
- Network monitoring recommended for anomaly detection
