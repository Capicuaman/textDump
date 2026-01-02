# Child-Friendly Linux Kiosk Desktop Environment
## Complete Setup and Configuration Guide

## Overview

This guide creates a locked-down, colorful desktop environment perfect for young children. It features large buttons, restricted access, and parental controls.

### What's Included

- **Simple tile-based launcher** with 4 kid-friendly apps
- **Automatic fullscreen** for all applications
- **Parental password lock** to exit the environment
- **Restricted file system** access (only Documents, Pictures, Downloads)
- **Safe web browser** that starts at kid-friendly sites
- **No terminal or system settings** access

---

## Prerequisites

- Ubuntu 20.04+ or Debian 11+ based system
- Root/sudo access
- Internet connection for downloading packages
- 30 minutes setup time

---

## Installation Steps

### 1. Download and Run Setup Script

```bash
# Download the setup script
sudo wget -O /tmp/setup-child-kiosk.sh [script-url]

# Make it executable
sudo chmod +x /tmp/setup-child-kiosk.sh

# Run the setup
sudo /tmp/setup-child-kiosk.sh
```

During setup, you'll be prompted to create a **parent password**. This password will be needed to exit the kiosk mode.

### 2. Configure Display Manager (Optional Auto-Login)

For automatic login to the child kiosk on boot:

**For LightDM** (Ubuntu default):
```bash
sudo nano /etc/lightdm/lightdm.conf
```

Add under `[Seat:*]`:
```ini
autologin-user=kiduser
autologin-session=i3
```

**For GDM3** (GNOME default):
```bash
sudo nano /etc/gdm3/custom.conf
```

Add under `[daemon]`:
```ini
AutomaticLoginEnable=true
AutomaticLogin=kiduser
```

### 3. Reboot and Test

```bash
sudo reboot
```

After reboot:
- Log out of your current session
- Select "i3" from the session menu
- Log in as `kiduser` (password: `child123`)

---

## Using the Kiosk

### For Children

The launcher shows 4 large, colorful buttons:

1. **🌐 Web Browser** - Opens Firefox at PBS Kids (or your chosen site)
2. **🎨 Drawing** - TuxPaint for creative drawing
3. **🎮 Games** - GCompris educational games
4. **📁 My Files** - Access to Documents folder

**Keyboard Shortcuts:**
- `Super+1` - Web Browser
- `Super+2` - Drawing
- `Super+3` - Games
- `Super+4` - My Files
- `Super+Home` - Return to launcher

### For Parents

**Exiting Kiosk Mode:**
1. Click the small lock icon (🔒) in the bottom-right corner
2. Enter your parent password
3. The session will close, returning to login screen

---

## Customization

### Changing Allowed Websites

Edit the browser command in `/home/kiduser/.config/i3/launch-app.sh`:

```bash
browser)
    firefox --kiosk --new-instance -P kids https://your-safe-site.com
    ;;
```

Safe site suggestions:
- https://pbskids.org
- https://www.funbrain.com
- https://www.abcya.com
- https://www.starfall.com
- https://www.coolmathgames.com

### Adding More Applications

1. Install the application:
```bash
sudo apt-get install application-name
```

2. Edit `/home/kiduser/.config/i3/show-launcher.py` to add a new button in the `apps` list:

```python
apps = [
    ("🌐\nWeb Browser", "browser", "#FF6B6B"),
    ("🎨\nDrawing", "paint", "#4ECDC4"),
    ("🎮\nGames", "games", "#FFE66D"),
    ("📁\nMy Files", "files", "#95E1D3"),
    ("📚\nBooks", "books", "#A8E6CF"),  # New app
]
```

3. Add the launch command in `/home/kiduser/.config/i3/launch-app.sh`:

```bash
books)
    your-ebook-reader-command
    ;;
```

### Changing Colors

Edit the color scheme in `/home/kiduser/.config/i3/show-launcher.py`:

```python
self.root.configure(bg='#87CEEB')  # Background color
title.configure(fg='#FF6B6B')      # Title color
```

Button colors are defined in the `apps` list (third parameter).

### Customizing Background

Replace the background image:
```bash
cp your-image.jpg /home/kiduser/.config/i3/background.jpg
```

---

## Security Features

### What's Blocked

✅ No terminal access
✅ No system settings
✅ No package installation
✅ Limited file system access
✅ Can't close environment without password
✅ Browser in private mode (no history saved)
✅ No keyboard shortcuts to exit applications

### What's Allowed

- Reading/writing files in Documents, Pictures, Downloads
- Using the 4 pre-approved applications
- Basic keyboard shortcuts for navigation

### Additional Hardening (Optional)

**Block internet except for specific sites:**

```bash
# Install filtering proxy
sudo apt-get install squid

# Configure whitelist
sudo nano /etc/squid/squid.conf
```

**Set time limits:**

```bash
# Install timekpr-next
sudo add-apt-repository ppa:mjasnik/ppa
sudo apt-get update
sudo apt-get install timekpr-next

# Configure time limits for kiduser
sudo timekpr-next
```

---

## Troubleshooting

### Problem: Launcher doesn't appear

**Solution:**
```bash
# Restart i3
echo "exec i3-msg restart" | i3-msg
```

### Problem: Applications don't launch

**Solution:** Check script permissions:
```bash
chmod +x /home/kiduser/.config/i3/*.sh
chmod +x /home/kiduser/.config/i3/*.py
```

### Problem: Forgot parent password

**Solution:** Reset from another admin account:
1. Log in as administrator
2. Edit `/home/kiduser/.config/i3/show-launcher.py`
3. Change the `PARENT_PASSWORD` line
4. Save and restart kiosk session

### Problem: Screen resolution issues

**Solution:** Configure X resolution:
```bash
# Add to /home/kiduser/.xinitrc before "exec i3"
xrandr --output HDMI-1 --mode 1920x1080
```

### Problem: Child can switch to TTY terminals

**Solution:** Disable TTY switching:
```bash
sudo nano /etc/X11/xorg.conf

# Add section:
Section "ServerFlags"
    Option "DontVTSwitch" "true"
EndSection
```

---

## Recommended Applications

### Drawing & Creativity
- **TuxPaint** (included) - Simple drawing program
- **Krita** - More advanced painting
- **GIMP** - Photo editing

### Educational Games
- **GCompris** (included) - 100+ educational activities
- **ChildsPlay** - Memory, matching, puzzles
- **Tux Math** - Math practice game

### Reading
- **Calibre** - E-book reader
- **FBReader** - E-book reader

### Videos (Local Only)
- **VLC** - Media player (disable network features)

---

## Maintenance

### Updating Applications

```bash
# Switch to admin account
sudo apt-get update
sudo apt-get upgrade
```

### Checking Usage

Monitor what the child accesses:
```bash
# View recent files accessed
sudo -u kiduser ls -lt /home/kiduser/Documents
sudo -u kiduser ls -lt /home/kiduser/Downloads

# View browser history (if not in private mode)
sudo -u kiduser cat ~/.mozilla/firefox/*/places.sqlite
```

### Backing Up Configuration

```bash
# Backup kiosk settings
sudo tar -czf child-kiosk-backup.tar.gz \
    /home/kiduser/.config/i3 \
    /opt/child-kiosk
```

---

## Uninstalling

To remove the kiosk environment:

```bash
# Remove user
sudo userdel -r kiduser

# Remove kiosk files
sudo rm -rf /opt/child-kiosk

# Remove packages (if desired)
sudo apt-get remove i3-wm tuxpaint gcompris-qt
```

---

## Advanced Customization

### Creating Multiple Child Profiles

```bash
# Create second child user
sudo useradd -m -s /bin/bash kiduser2

# Copy configuration
sudo cp -r /home/kiduser/.config /home/kiduser2/
sudo chown -R kiduser2:kiduser2 /home/kiduser2

# Customize for second child...
```

### Adding Educational Content

Create curated content folders:
```bash
sudo mkdir /home/kiduser/Documents/{Math,Reading,Science}

# Add PDF workbooks, educational videos, etc.
```

### Network Filtering with Pi-hole

Install Pi-hole on your router for network-wide content filtering:
1. Blocks ads automatically
2. Whitelist-only mode for children's devices
3. Time-based access controls

---

## Privacy & Safety Notes

- This kiosk is designed for supervised or monitored use
- Browser is in private mode (no history saved between sessions)
- No built-in monitoring/keylogging - respect children's privacy
- Consider age-appropriate content ratings
- Regularly review what sites children visit
- Have conversations about online safety

---

## Support Resources

- **i3 Window Manager:** https://i3wm.org/docs/
- **TuxPaint Documentation:** http://www.tuxpaint.org/docs/
- **GCompris:** https://gcompris.net/
- **Internet Safety for Kids:** https://www.commonsensemedia.org/

---

## License & Credits

This setup uses open-source software:
- i3wm (BSD License)
- TuxPaint (GPL)
- GCompris (GPL)
- Firefox (MPL)

Configuration scripts provided as-is for educational purposes.