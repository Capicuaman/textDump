# Security Best Practices

Comprehensive security guidelines for home network and computer.

## Network Security

### Router Security

**Essential Steps:**

1. **Change Default Credentials** ⚠️ Critical
   - Never use admin/admin or admin/password
   - Use strong, unique password (20+ characters)
   - Use password manager to store

2. **Update Firmware Regularly**
   - Check monthly for updates
   - Enable automatic updates if available
   - Visit manufacturer website for latest firmware

3. **Wi-Fi Encryption**
   - ✅ Use WPA3 (preferred) or WPA2-PSK
   - ❌ Never use WEP or WPA (broken)
   - ❌ Never use Open/Unencrypted
   - Use strong passphrase (20+ random characters)

4. **Disable Unnecessary Features**
   - WPS (Wi-Fi Protected Setup) - Vulnerable
   - UPnP (if not needed) - Security risk
   - Remote management (unless needed)
   - Guest network (if unused)
   - IPv6 (if not using it)

5. **Network Segmentation**
   - Separate guest network from main network
   - Isolate IoT devices (separate VLAN if possible)
   - Keep work devices on separate network
   - Use VLANs for advanced segmentation

6. **MAC Address Filtering** (Optional)
   - Add whitelist of allowed devices
   - Note: Can be bypassed (security through obscurity)
   - Better than nothing, but not foolproof

7. **Disable SSID Broadcast** (Optional)
   - Hides network name from casual discovery
   - Again, security through obscurity
   - Legitimate users need to know SSID

### DNS Security

**Current Setup:**
- Cloudflare: 1.1.1.1 ✅
- Google: 8.8.8.8 ✅

**Improvements:**

1. **DNS over HTTPS (DoH)**
   - Encrypts DNS queries
   - Prevents ISP snooping
   - Configure in browser or system-wide

2. **DNS over TLS (DoT)**
   - Similar to DoH, different protocol
   - Port 853 vs HTTPS port 443

3. **DNSSEC**
   - Validates DNS responses
   - Prevents DNS spoofing
   - Most major DNS providers support it

4. **Alternative DNS Providers:**
   - **Quad9** (9.9.9.9) - Blocks malicious domains
   - **OpenDNS** - Filtering options
   - **NextDNS** - Privacy + ad blocking
   - **AdGuard DNS** - Ad blocking

### Firewall Configuration

**macOS Firewall:**
```bash
# Enable firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# Enable stealth mode (ignore pings)
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

# Enable logging
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on
```

**Router Firewall:**
- Enable SPI (Stateful Packet Inspection)
- Block incoming WAN requests
- Disable DMZ unless specifically needed
- Only forward ports when absolutely necessary

### VPN Best Practices

**Tailscale (Current):**
- ✅ Zero-trust mesh VPN
- ✅ End-to-end encryption
- ✅ No port forwarding needed
- ✅ Automatic key rotation

**Configuration Tips:**
1. Enable MFA on Tailscale account
2. Set up ACLs to restrict access
3. Enable key expiration
4. Regularly review connected devices
5. Use tags for device organization
6. Enable subnet routing only if needed

**Alternative VPNs:**
- ProtonVPN (privacy-focused)
- Mullvad (anonymous)
- IVPN (privacy-focused)
- WireGuard (self-hosted)

## Device Security

### macOS Security

**System Settings:**

1. **FileVault (Disk Encryption)** ⚠️ Critical
   ```bash
   # Check status
   fdesetup status
   ```
   - System Preferences > Security & Privacy > FileVault
   - Encrypts entire disk
   - Essential for laptops

2. **Firmware Password** ⚠️ Critical
   - Prevents booting from external drives
   - Set in Recovery Mode
   - Protects against physical attacks

3. **Automatic Updates** ✅
   - System Preferences > Software Update
   - Enable automatic security updates
   - Check weekly for other updates

4. **Gatekeeper** ✅
   - Only install apps from App Store and identified developers
   - System Preferences > Security & Privacy > General

5. **Screen Lock** ✅
   - Require password immediately
   - System Preferences > Security & Privacy > General
   - Set hot corner for screen lock

6. **Disable Auto-login**
   - System Preferences > Users & Groups
   - Require password on wake

### Password Security

**Password Manager:**
- ✅ Use password manager (1Password, Bitwarden, etc.)
- ✅ Enable MFA/2FA everywhere possible
- ✅ Use unique passwords for every service
- ✅ Minimum 16 characters
- ✅ Random generation preferred

**Password Requirements:**
- 16+ characters minimum
- Mix of uppercase, lowercase, numbers, symbols
- No dictionary words
- No personal information
- No reuse across services

**MFA/2FA:**
- Use authenticator app (Authy, 1Password, etc.)
- Avoid SMS 2FA (SIM swapping risk)
- Use hardware keys (YubiKey) for critical accounts
- Store backup codes securely

### Browser Security

**Privacy Settings:**

1. **Firefox:**
   - Enable Enhanced Tracking Protection (Strict)
   - Enable DNS over HTTPS
   - Disable telemetry
   - Use Multi-Account Containers

2. **Chrome/Brave:**
   - Enable "Do Not Track"
   - Block third-party cookies
   - Enable Safe Browsing
   - Use privacy extensions

3. **Safari:**
   - Prevent cross-site tracking
   - Block all cookies (or allow from current website only)
   - Enable fraudulent website warning

**Extensions (Use Judiciously):**
- uBlock Origin (ad blocker)
- Privacy Badger (tracker blocker)
- HTTPS Everywhere (force HTTPS)
- Decentraleyes (CDN privacy)
- Note: Too many extensions = performance issues

### Application Security

**Best Practices:**

1. **Only install from trusted sources**
   - App Store (preferred)
   - Official developer websites
   - Verified downloads only

2. **Keep apps updated**
   - Enable automatic updates where possible
   - Check for updates weekly

3. **Review app permissions**
   - System Preferences > Security & Privacy > Privacy
   - Grant only necessary permissions
   - Regularly audit permissions

4. **Remove unused apps**
   - Reduces attack surface
   - Improves performance
   - Use AppCleaner for complete removal

### Physical Security

**Critical for Laptops:**

1. **Never leave unattended**
   - Lock screen when away
   - Use Kensington lock in public

2. **Secure storage**
   - Store in locked location when not in use
   - Don't leave in vehicles

3. **Firmware password** ⚠️ Critical
   - Prevents unauthorized boot
   - Required for high-security environments

4. **Serial number tracking**
   - Document serial numbers
   - Register with manufacturer
   - Enable Find My Mac

## Data Security

### Backup Strategy

**3-2-1 Backup Rule:**
- **3** copies of data
- **2** different media types
- **1** off-site copy

**Backup Solutions:**

1. **Time Machine** (macOS built-in)
   - Hourly incremental backups
   - Connect external drive
   - Set up automatically

2. **Cloud Backup**
   - Backblaze (unlimited, $7/month)
   - iCloud (limited free, paid tiers)
   - Google Drive, Dropbox, etc.

3. **Clone Backup**
   - Carbon Copy Cloner
   - SuperDuper!
   - Bootable clone for emergencies

**Encryption:**
- Encrypt all backups
- Time Machine encrypts if enabled
- Use encrypted external drives
- Verify cloud backup encryption

### Sensitive Data Handling

**Storage:**
- Use FileVault (full disk encryption)
- Use encrypted disk images for extra sensitive data
- Use password manager for passwords
- Never store passwords in plain text

**Sharing:**
- Use encrypted file sharing (Tresorit, ProtonDrive)
- Avoid email for sensitive files
- Use Signal for sensitive messages
- Use PGP/GPG for email encryption (advanced)

**Disposal:**
- Securely erase before selling/disposing
- Use Disk Utility > Erase with security options
- Or: `diskutil secureErase 3 /dev/diskX`
- Physical destruction for highly sensitive

## Email Security

**Best Practices:**

1. **Phishing Awareness** ⚠️ Critical
   - Verify sender addresses carefully
   - Never click suspicious links
   - Don't download unexpected attachments
   - When in doubt, contact sender directly

2. **Email Encryption**
   - Use ProtonMail or Tutanota for encrypted email
   - Or use PGP/GPG (advanced)

3. **Spam Filtering**
   - Use built-in spam filters
   - Report spam/phishing
   - Never unsubscribe from spam (confirms address)

4. **Email Aliases**
   - Use different addresses for different purposes
   - Use "+" addressing (gmail: user+label@gmail.com)
   - Use SimpleLogin or AnonAddy for disposable addresses

## Social Engineering Defense

**Common Attacks:**

1. **Phishing**
   - Fake emails requesting credentials
   - Look for: wrong domains, urgency, threats, poor grammar
   - Verify via separate channel

2. **Vishing (Voice Phishing)**
   - Phone calls pretending to be support/bank/IRS
   - Never give personal info over phone
   - Hang up and call back on official number

3. **Smishing (SMS Phishing)**
   - Text messages with malicious links
   - Same rules as email phishing

4. **Pretexting**
   - Attacker creates scenario to extract info
   - Be skeptical of requests for information
   - Verify identity independently

**Defense:**
- ✅ Verify identity independently
- ✅ Don't trust caller ID (can be spoofed)
- ✅ Never give passwords over phone/email
- ✅ Be wary of urgency/threats
- ✅ When in doubt, hang up and call back

## Incident Response Plan

**If Device Compromised:**

1. **Disconnect from network**
   - Turn off Wi-Fi
   - Unplug Ethernet
   - Disable Bluetooth

2. **Document**
   - Take photos/screenshots
   - Note unusual behavior
   - Record timeline

3. **Change passwords** (from different device)
   - Email
   - Banking
   - Critical accounts
   - Enable MFA if not already

4. **Scan for malware**
   - Malwarebytes
   - ClamAV
   - Full system scan

5. **Check for unauthorized access**
   ```bash
   last
   who
   sudo lsof -i
   ```

6. **Review logs**
   ```bash
   log show --last 24h > incident.log
   ```

7. **Consider clean install**
   - If severely compromised
   - Restore from clean backup

8. **Report**
   - Report to affected services
   - Report to authorities if necessary
   - File identity theft report if needed

**Prevention After Incident:**
- Analyze how breach occurred
- Implement additional controls
- Update security procedures
- Educate household members

## Security Monitoring

**Daily Checks:**
- Unusual network activity
- Unexpected popups/alerts
- Performance degradation
- Unknown processes

**Weekly Tasks:**
- Check for system updates
- Review recent logins
- Check firewall logs
- Scan for malware

**Monthly Tasks:**
- Review all account activity
- Update passwords (critical accounts)
- Check backup integrity
- Review app permissions

**Quarterly Tasks:**
- Full security audit
- Review network devices
- Update recovery plan
- Test backups

## Privacy Best Practices

**Online Privacy:**

1. **Use VPN** (Tailscale or commercial)
2. **Use privacy-focused search** (DuckDuckGo, Startpage)
3. **Use private browsing mode** for sensitive searches
4. **Disable location services** when not needed
5. **Review app permissions** regularly
6. **Use encrypted messaging** (Signal)
7. **Limit social media** sharing

**Data Minimization:**
- Share only what's necessary
- Use temporary/disposable emails
- Use privacy.com for online purchases (virtual cards)
- Opt out of data brokers (Privacy.com, DeleteMe)

**Tracking Prevention:**
- Block third-party cookies
- Use tracking protection in browser
- Use privacy extensions
- Disable ad personalization

## Compliance and Legal

**For Home Networks:**
- Generally no compliance requirements
- GDPR applies if in EU
- COPPA applies if children under 13
- Keep sensitive data secure

**For Work From Home:**
- Follow company security policies
- Use company VPN if provided
- Separate work and personal devices if possible
- Encrypt work data
- Report security incidents to IT

## Resources

**Security Tools:**
- https://www.malwarebytes.com
- https://objective-see.com (Mac security tools)
- https://www.grc.com/shieldsup (port scanning)
- https://haveibeenpwned.com (breach checking)

**Education:**
- https://security.berkeley.edu
- https://www.sans.org
- https://www.nist.gov/cyberframework
- https://www.cisa.gov/cybersecurity

**News:**
- https://krebsonsecurity.com
- https://www.schneier.com
- https://thehackernews.com

## Security Checklist Summary

### Critical (Do Immediately):
- [ ] Enable FileVault (disk encryption)
- [ ] Enable macOS firewall
- [ ] Set firmware password
- [ ] Use password manager
- [ ] Enable MFA on all critical accounts
- [ ] Change router default password
- [ ] Update router firmware
- [ ] Use WPA2/WPA3 encryption
- [ ] Disable router WPS

### Important (Do Soon):
- [ ] Set up Time Machine backups
- [ ] Set up cloud backup
- [ ] Review app permissions
- [ ] Enable automatic updates
- [ ] Install security updates
- [ ] Configure DNS over HTTPS
- [ ] Enable stealth mode on firewall
- [ ] Review network devices

### Ongoing (Regular Maintenance):
- [ ] Weekly: Check for updates
- [ ] Monthly: Review account activity
- [ ] Monthly: Scan for malware
- [ ] Quarterly: Audit security settings
- [ ] Quarterly: Test backups
- [ ] Annually: Full security review

## Notes

- Security is a process, not a product
- Convenience often trades off with security
- Perfect security is impossible; aim for reasonable protection
- Stay informed about current threats
- Educate all household members about security
- When in doubt, err on the side of caution