# Common Network Issues

Troubleshooting guide for frequent network problems on macOS and home networks.

## No Internet Connection

### Symptoms:
- Can't access websites
- "No Internet" message
- Apps can't connect online

### Diagnosis:

```bash
# Check if Wi-Fi is connected
ifconfig en0 | grep "status"

# Check if you have an IP address
ifconfig en0 | grep "inet "

# Ping gateway
ping 192.168.1.254

# Ping external IP
ping 8.8.8.8

# Ping domain name (tests DNS)
ping google.com
```

### Solutions:

**1. Basic Reconnection:**
```bash
# Turn Wi-Fi off and on
networksetup -setairportpower en0 off
sleep 2
networksetup -setairportpower en0 on
```

**2. Renew DHCP Lease:**
```bash
sudo ipconfig set en0 DHCP
sudo dnsutil -flushcache
sudo killall -HUP mDNSResponder
```

**3. Check Router:**
- Restart router (unplug 30 seconds, plug back in)
- Check if other devices can connect
- Verify router lights are normal

**4. Forget and Rejoin Network:**
- System Preferences > Network > Wi-Fi > Advanced
- Select network > Click "-" to forget
- Rejoin network with password

**5. Check for ISP Outage:**
- Use cellular to check ISP status page
- Check downdetector.com
- Contact ISP if widespread

## Slow Internet Speed

### Symptoms:
- Pages load slowly
- Videos buffer frequently
- Downloads are slow

### Diagnosis:

```bash
# Check link speed
networksetup -getinfo "Wi-Fi"

# Test speed
# Use fast.com or speedtest.net in browser

# Check for bandwidth hogs
sudo lsof -i | grep ESTABLISHED
sudo iftop -i en0  # if installed

# Check Wi-Fi signal strength
/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I
```

### Solutions:

**1. Check Wi-Fi Signal:**
- Move closer to router
- Check for interference (microwaves, other Wi-Fi)
- Try 5GHz band if available
- Reduce obstacles between device and router

**2. Bandwidth Management:**
```bash
# Find processes using network
sudo lsof -i | grep -i established

# Kill bandwidth-heavy process
kill -9 <PID>
```

**3. Router Issues:**
- Restart router
- Check for firmware updates
- Change Wi-Fi channel (less congestion)
- Consider upgrading router if old (10+ years)

**4. DNS Issues:**
```bash
# Try different DNS servers
sudo networksetup -setdnsservers "Wi-Fi" 1.1.1.1 8.8.8.8
```

**5. QoS (Router Settings):**
- Enable Quality of Service (QoS) on router
- Prioritize important traffic
- Limit bandwidth for low-priority devices

## Cannot Connect to Specific Website

### Symptoms:
- One site won't load, others work fine
- "DNS_PROBE_FINISHED_NXDOMAIN" error
- Connection timeout for specific site

### Diagnosis:

```bash
# Test DNS resolution
nslookup example.com
dig example.com

# Try different DNS server
nslookup example.com 1.1.1.1

# Check if site is down for everyone
curl -I https://example.com

# Test with different protocol
ping example.com
traceroute example.com
```

### Solutions:

**1. Clear DNS Cache:**
```bash
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
```

**2. Change DNS Servers:**
```bash
sudo networksetup -setdnsservers "Wi-Fi" 1.1.1.1 8.8.8.8
```

**3. Check Hosts File:**
```bash
# View hosts file
cat /etc/hosts

# Edit if needed (remove suspicious entries)
sudo nano /etc/hosts
```

**4. Clear Browser Cache:**
- Chrome: Settings > Privacy > Clear browsing data
- Firefox: Preferences > Privacy > Clear Data
- Safari: Develop > Empty Caches

**5. Try Different Browser:**
- Test in Safari, Firefox, Chrome
- Try private/incognito mode

**6. Check if Site is Actually Down:**
- Visit downforeveryoneorjustme.com
- Check site's Twitter/status page

## Wi-Fi Keeps Disconnecting

### Symptoms:
- Frequent disconnections
- "No Internet" intermittently
- Network drops randomly

### Diagnosis:

```bash
# Check system logs for Wi-Fi issues
log show --predicate 'process == "wifid"' --last 1h

# Check for interference
/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s

# Monitor connection
ping -i 1 192.168.1.254
```

### Solutions:

**1. Forget Network and Rejoin:**
- System Preferences > Network > Wi-Fi > Advanced
- Select network, click "-"
- Rejoin with password

**2. Delete Wi-Fi Preferences:**
```bash
# Move Wi-Fi preferences
sudo mv /Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist ~/Desktop/

# Restart
sudo reboot
```

**3. Reset Network Settings:**
```bash
# Delete network configuration
cd /Library/Preferences/SystemConfiguration/
sudo rm -f com.apple.airport.preferences.plist
sudo rm -f com.apple.network.identification.plist
sudo rm -f NetworkInterfaces.plist
sudo rm -f preferences.plist

# Restart
sudo reboot
```

**4. Check Power Management:**
- System Preferences > Battery > Power Adapter
- Uncheck "Enable Power Nap"

**5. Router Issues:**
- Update router firmware
- Change Wi-Fi channel
- Reduce number of connected devices
- Check for overheating

**6. Hardware Issues:**
```bash
# Run Apple Diagnostics
# Restart Mac, hold D key during boot
```

## DNS Not Resolving

### Symptoms:
- Can ping IP addresses (8.8.8.8) but not domain names (google.com)
- "Server not found" errors
- Websites won't load but internet is connected

### Diagnosis:

```bash
# Check current DNS
scutil --dns

# Test DNS resolution
nslookup google.com

# Test with specific DNS server
nslookup google.com 1.1.1.1

# Check if DNS servers are reachable
ping 1.1.1.1
ping 8.8.8.8
```

### Solutions:

**1. Flush DNS Cache:**
```bash
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
```

**2. Set DNS Manually:**
```bash
sudo networksetup -setdnsservers "Wi-Fi" 1.1.1.1 8.8.8.8
```

**3. Reset DNS to DHCP:**
```bash
sudo networksetup -setdnsservers "Wi-Fi" empty
```

**4. Check mDNSResponder:**
```bash
# Check if running
ps aux | grep mDNSResponder

# Restart if needed
sudo killall -HUP mDNSResponder
```

**5. Try Alternative DNS:**
- Cloudflare: 1.1.1.1, 1.0.0.1
- Google: 8.8.8.8, 8.8.4.4
- Quad9: 9.9.9.9, 149.112.112.112

## Local Network Devices Not Accessible

### Symptoms:
- Can't connect to printer
- Can't access NAS
- Can't use AirDrop
- Can't see other computers

### Diagnosis:

```bash
# Check if device is on network
ping 192.168.1.X

# Check mDNS
dns-sd -B _services._dns-sd._udp local.

# Check ARP cache
arp -a

# Scan network
sudo nmap -sn 192.168.1.0/24
```

### Solutions:

**1. Check Firewall:**
```bash
# Check firewall status
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate

# Allow device through firewall if needed
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --add /Applications/[App].app
```

**2. Restart mDNSResponder:**
```bash
sudo killall -HUP mDNSResponder
```

**3. Check Network Subnet:**
- Ensure devices are on same subnet (192.168.1.x)
- Check subnet mask is 255.255.255.0

**4. Enable File Sharing:**
- System Preferences > Sharing
- Enable relevant services

**5. Check Router Settings:**
- Ensure AP Isolation is OFF
- Check if devices are on guest network (isolated)

## VPN Not Connecting (Tailscale)

### Symptoms:
- Tailscale won't connect
- Can't reach Tailscale devices
- utun3 interface not active

### Diagnosis:

```bash
# Check Tailscale status
tailscale status

# Check if utun3 exists
ifconfig utun3

# Check Tailscale logs
log show --predicate 'process == "tailscaled"' --last 30m

# Test connectivity
ping 100.100.100.100
```

### Solutions:

**1. Restart Tailscale:**
```bash
tailscale down
tailscale up
```

**2. Check Authentication:**
- Visit login.tailscale.com
- Re-authenticate if needed
- Check account status

**3. Check Firewall:**
- Ensure Tailscale is allowed through firewall
- Check router doesn't block VPN traffic

**4. Reinstall Tailscale:**
```bash
# Uninstall current version
# Download latest from tailscale.com
# Install fresh
```

**5. Check for Updates:**
- Update to latest Tailscale version
- Check for macOS updates

## Port Forwarding Not Working

### Symptoms:
- External connections can't reach service
- Port appears closed from outside
- Service works locally but not remotely

### Diagnosis:

```bash
# Check if service is listening locally
sudo lsof -i :PORT_NUMBER
netstat -an | grep LISTEN

# Test from local network
nc -zv 192.168.1.71 PORT_NUMBER

# Test from external (use canyouseeme.org or similar)
```

### Solutions:

**1. Verify Service is Running:**
```bash
# Check if service is listening
sudo lsof -i -P | grep LISTEN
```

**2. Check Router Port Forwarding:**
- Log into router (192.168.1.254)
- Navigate to Port Forwarding settings
- Ensure rule is:
  - External port → Internal IP (192.168.1.71) : Internal port
  - Protocol correct (TCP/UDP)
  - Rule is enabled

**3. Check Firewall:**
```bash
# Temporarily test by disabling firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate off

# Test if it works
# Re-enable firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# If worked, add exception for specific port
```

**4. Check Dynamic IP:**
- Verify your internal IP hasn't changed
- Consider static IP assignment
- Update port forwarding rule if IP changed

**5. ISP Restrictions:**
- Some ISPs block certain ports
- Try alternative port
- Contact ISP if persistent issue

## High Latency / Ping Spikes

### Symptoms:
- Intermittent lag
- Ping times vary wildly
- Gaming stutters
- Video calls freeze

### Diagnosis:

```bash
# Continuous ping to gateway
ping 192.168.1.254

# Continuous ping to external
ping 8.8.8.8

# Trace route
traceroute google.com

# Monitor for packet loss
ping -c 100 8.8.8.8 | grep loss
```

### Solutions:

**1. Check Wi-Fi Signal:**
```bash
# Check signal strength
/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep CtlRSSI

# Signal strength guide:
# -30 to -50 dBm: Excellent
# -51 to -60 dBm: Good
# -61 to -70 dBm: Fair
# -71 to -80 dBm: Poor
# -81 to -90 dBm: Very poor
```

**2. Reduce Interference:**
- Move closer to router
- Change Wi-Fi channel (use Wi-Fi scanner app)
- Switch to 5GHz band
- Avoid 2.4GHz interference (Bluetooth, microwaves)

**3. Check for Network Congestion:**
```bash
# View active connections
sudo lsof -i | grep ESTABLISHED

# Kill bandwidth-heavy processes
```

**4. Use Wired Connection:**
- USB-to-Ethernet adapter
- Direct connection for stability
- Eliminates Wi-Fi variables

**5. QoS on Router:**
- Enable Quality of Service
- Prioritize latency-sensitive traffic
- Limit bandwidth for background tasks

## Troubleshooting Methodology

**Step-by-Step Approach:**

1. **Identify the Problem**
   - What exactly is not working?
   - When did it start?
   - What changed recently?

2. **Isolate the Issue**
   - Is it one device or all devices?
   - Is it one service or everything?
   - Is it Wi-Fi or wired (if applicable)?

3. **Check the Basics**
   - Restart device
   - Restart router
   - Check cables
   - Check if service is down

4. **Gather Information**
   - Run diagnostic commands
   - Check logs
   - Test from different locations

5. **Try Simple Solutions First**
   - Restart services
   - Clear caches
   - Update software

6. **Try Advanced Solutions**
   - Reset network settings
   - Change configuration
   - Contact support

7. **Document**
   - Note what worked
   - Update documentation
   - Share knowledge

## Useful Commands Reference

### Network Information:
```bash
# All interfaces
ifconfig

# Specific interface
ifconfig en0

# Routing table
netstat -rn

# DNS configuration
scutil --dns

# ARP cache
arp -a
```

### Connectivity Tests:
```bash
# Ping
ping google.com

# Trace route
traceroute google.com

# Port scan
nc -zv host port
nmap -p port host

# DNS lookup
nslookup domain.com
dig domain.com
```

### Network Utilities:
```bash
# View connections
sudo lsof -i

# View listening ports
sudo lsof -i -P | grep LISTEN

# Network statistics
netstat -an

# Bandwidth monitor (if installed)
sudo iftop -i en0
```

### System Logs:
```bash
# Network logs
log show --predicate 'process == "networkd"' --last 1h

# Wi-Fi logs
log show --predicate 'process == "wifid"' --last 1h

# System log
log show --last 1h
```

## Emergency Network Reset

**Nuclear Option** (when nothing else works):

```bash
# Backup current configuration
sudo cp -r /Library/Preferences/SystemConfiguration ~/NetworkBackup/

# Delete network preferences
cd /Library/Preferences/SystemConfiguration/
sudo rm -f com.apple.airport.preferences.plist
sudo rm -f com.apple.network.identification.plist
sudo rm -f NetworkInterfaces.plist
sudo rm -f preferences.plist

# Restart
sudo reboot
```

**Warning:** This will reset ALL network settings including:
- Wi-Fi networks and passwords
- VPN configurations
- Network locations
- Custom DNS settings

## When to Contact Support

**Contact ISP when:**
- Multiple devices can't connect
- Router shows no internet light
- Issues persist after router restart
- Speed tests show much slower than plan
- Suspected service outage

**Contact Apple Support when:**
- Hardware issues suspected
- Software issues persist after reset
- AppleCare under warranty
- Need advanced diagnostics

**Contact Router Manufacturer when:**
- Router firmware issues
- Advanced configuration needed
- Hardware failure suspected

## Prevention

**Maintain Network Health:**
- Keep firmware updated (router, devices)
- Restart router monthly
- Monitor network devices
- Document configuration changes
- Keep network map updated
- Regular security audits
- Backup router configuration

## Notes

- Always try simplest solution first
- Document what you tried
- Changes may require restart to take effect
- Some issues resolve themselves after time
- Keep ISP/Apple support numbers handy
- Consider professional help for persistent issues