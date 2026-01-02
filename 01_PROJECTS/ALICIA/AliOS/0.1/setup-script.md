#!/bin/bash
# Child-Friendly Kiosk Desktop Environment Setup
# Run as root or with sudo

set -e

echo "=== Child-Friendly Kiosk Desktop Setup ==="
echo "This will create a restricted desktop environment for children"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root or with sudo"
    exit 1
fi

# Variables
CHILD_USER="kiduser"
PARENT_PASSWORD=""
KIOSK_DIR="/opt/child-kiosk"

# Prompt for parent password
echo "Enter a parent/admin password for unlocking the kiosk:"
read -s PARENT_PASSWORD
echo ""

# Install required packages
echo "Installing required packages..."
apt-get update
apt-get install -y \
    i3-wm \
    xinit \
    xorg \
    feh \
    rofi \
    unclutter \
    tuxpaint \
    gcompris-qt \
    firefox-esr \
    pcmanfm \
    python3 \
    python3-tk \
    zenity

# Create kiosk user
echo "Creating child user account..."
if id "$CHILD_USER" &>/dev/null; then
    echo "User $CHILD_USER already exists"
else
    useradd -m -s /bin/bash "$CHILD_USER"
    echo "$CHILD_USER:child123" | chpasswd
fi

# Create kiosk directory structure
echo "Setting up kiosk directories..."
mkdir -p "$KIOSK_DIR"/{config,scripts,icons,backgrounds}
mkdir -p /home/$CHILD_USER/{Documents,Pictures,Downloads}

# Create i3 config
cat > "$KIOSK_DIR/config/i3config" << 'EOF'
# i3 config for child kiosk mode

# Mod key (Super/Windows key)
set $mod Mod4

# Font for window titles
font pango:DejaVu Sans Mono 16

# Remove window borders and titles
default_border none
default_floating_border none
for_window [class=".*"] border none

# Colors - bright and friendly
client.focused          #FF6B6B #FF6B6B #FFFFFF #FFE66D
client.focused_inactive #4ECDC4 #4ECDC4 #FFFFFF #4ECDC4
client.unfocused        #95E1D3 #95E1D3 #000000 #95E1D3

# Always fullscreen applications
for_window [class=".*"] fullscreen enable

# Disable workspace switching with mouse
bindsym button4 nop
bindsym button5 nop

# Application shortcuts
bindsym $mod+1 exec --no-startup-id $HOME/.config/i3/launch-app.sh browser
bindsym $mod+2 exec --no-startup-id $HOME/.config/i3/launch-app.sh paint
bindsym $mod+3 exec --no-startup-id $HOME/.config/i3/launch-app.sh games
bindsym $mod+4 exec --no-startup-id $HOME/.config/i3/launch-app.sh files

# Home button to return to launcher
bindsym $mod+Home exec --no-startup-id $HOME/.config/i3/show-launcher.py

# Disable dangerous shortcuts
bindsym $mod+Shift+e nop
bindsym $mod+Shift+r nop
bindsym $mod+Shift+c nop

# Disable terminal shortcuts
bindsym $mod+Return nop
bindsym $mod+d nop

# Start launcher on startup
exec --no-startup-id $HOME/.config/i3/show-launcher.py
exec --no-startup-id unclutter -idle 3
exec --no-startup-id feh --bg-scale $HOME/.config/i3/background.jpg
EOF

# Create Python launcher GUI
cat > "$KIOSK_DIR/scripts/launcher.py" << 'EOF'
#!/usr/bin/env python3
import tkinter as tk
from tkinter import simpledialog
import subprocess
import os

PARENT_PASSWORD = "PARENT_PASS_PLACEHOLDER"

class KioskLauncher:
    def __init__(self):
        self.root = tk.Tk()
        self.root.title("Kids Apps")
        self.root.attributes('-fullscreen', True)
        self.root.configure(bg='#87CEEB')
        
        # Title
        title = tk.Label(
            self.root,
            text="🎈 Choose an Activity! 🎈",
            font=("Comic Sans MS", 48, "bold"),
            bg='#87CEEB',
            fg='#FF6B6B'
        )
        title.pack(pady=50)
        
        # Button frame
        btn_frame = tk.Frame(self.root, bg='#87CEEB')
        btn_frame.pack(expand=True)
        
        # Apps configuration
        apps = [
            ("🌐\nWeb Browser", "browser", "#FF6B6B"),
            ("🎨\nDrawing", "paint", "#4ECDC4"),
            ("🎮\nGames", "games", "#FFE66D"),
            ("📁\nMy Files", "files", "#95E1D3"),
        ]
        
        # Create app buttons (2x2 grid)
        for idx, (text, cmd, color) in enumerate(apps):
            row = idx // 2
            col = idx % 2
            
            btn = tk.Button(
                btn_frame,
                text=text,
                font=("Comic Sans MS", 32, "bold"),
                bg=color,
                fg="white",
                width=12,
                height=6,
                relief="raised",
                bd=8,
                command=lambda c=cmd: self.launch_app(c),
                cursor="hand2"
            )
            btn.grid(row=row, column=col, padx=30, pady=30)
        
        # Parent unlock button (small, bottom corner)
        unlock_btn = tk.Button(
            self.root,
            text="🔒",
            font=("Arial", 16),
            command=self.parent_unlock,
            bg='#E8E8E8',
            relief="flat"
        )
        unlock_btn.place(relx=0.98, rely=0.98, anchor="se")
        
    def launch_app(self, app_name):
        script = os.path.expanduser("~/.config/i3/launch-app.sh")
        subprocess.Popen([script, app_name])
        self.root.destroy()
        
    def parent_unlock(self):
        password = simpledialog.askstring(
            "Parent Access",
            "Enter parent password:",
            show='*'
        )
        
        if password == PARENT_PASSWORD:
            subprocess.run(["i3-msg", "exit"])
        else:
            tk.messagebox.showerror("Error", "Wrong password!")
    
    def run(self):
        self.root.mainloop()

if __name__ == "__main__":
    app = KioskLauncher()
    app.run()
EOF

# Create app launcher script
cat > "$KIOSK_DIR/scripts/launch-app.sh" << 'EOF'
#!/bin/bash
# Launch applications for kiosk

APP=$1

case $APP in
    browser)
        # Launch Firefox in kiosk mode with restricted profile
        firefox --kiosk --new-instance -P kids https://pbskids.org
        ;;
    paint)
        tuxpaint --fullscreen
        ;;
    games)
        gcompris-qt --fullscreen
        ;;
    files)
        pcmanfm ~/Documents
        ;;
    *)
        echo "Unknown app: $APP"
        ;;
esac

# Return to launcher when app closes
sleep 1
~/.config/i3/show-launcher.py
EOF

# Create Firefox profile with restrictions
echo "Setting up restricted Firefox profile..."
sudo -u $CHILD_USER firefox -CreateProfile "kids"
FIREFOX_PROFILE=$(sudo -u $CHILD_USER firefox -ProfileManager -list 2>/dev/null | grep kids | awk '{print $2}')

if [ -n "$FIREFOX_PROFILE" ]; then
    cat > "$FIREFOX_PROFILE/user.js" << 'EOF'
// Kiosk mode restrictions
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.tabs.warnOnClose", false);
user_pref("browser.sessionstore.resume_from_crash", false);
user_pref("browser.privatebrowsing.autostart", true);
user_pref("privacy.clearOnShutdown.cache", true);
user_pref("privacy.clearOnShutdown.cookies", true);
user_pref("privacy.clearOnShutdown.history", true);
user_pref("dom.disable_open_during_load", true);
user_pref("browser.link.open_newwindow", 1);
user_pref("browser.download.folderList", 2);
user_pref("browser.download.dir", "/home/kiduser/Downloads");
EOF
fi

# Download a child-friendly background
echo "Setting up background..."
wget -O "$KIOSK_DIR/backgrounds/background.jpg" \
    "https://images.unsplash.com/photo-1519682337058-a94d519337bc?w=1920&h=1080&fit=crop" \
    2>/dev/null || echo "Skipping background download"

# Copy files to user directory
echo "Copying configuration to user directory..."
sudo -u $CHILD_USER mkdir -p /home/$CHILD_USER/.config/i3
cp "$KIOSK_DIR/config/i3config" /home/$CHILD_USER/.config/i3/config
cp "$KIOSK_DIR/scripts/launcher.py" /home/$CHILD_USER/.config/i3/show-launcher.py
cp "$KIOSK_DIR/scripts/launch-app.sh" /home/$CHILD_USER/.config/i3/launch-app.sh
cp "$KIOSK_DIR/backgrounds/background.jpg" /home/$CHILD_USER/.config/i3/background.jpg 2>/dev/null || true

# Set parent password in launcher
sed -i "s/PARENT_PASS_PLACEHOLDER/$PARENT_PASSWORD/" /home/$CHILD_USER/.config/i3/show-launcher.py

# Make scripts executable
chmod +x /home/$CHILD_USER/.config/i3/*.sh
chmod +x /home/$CHILD_USER/.config/i3/*.py

# Set ownership
chown -R $CHILD_USER:$CHILD_USER /home/$CHILD_USER

# Restrict user permissions
echo "Setting up user restrictions..."
# Remove ability to install packages
usermod -G audio,video,plugdev $CHILD_USER

# Create .xinitrc to auto-start i3
cat > /home/$CHILD_USER/.xinitrc << 'EOF'
#!/bin/bash
exec i3
EOF
chmod +x /home/$CHILD_USER/.xinitrc
chown $CHILD_USER:$CHILD_USER /home/$CHILD_USER/.xinitrc

# Create auto-login configuration (optional)
echo "Setup complete!"
echo ""
echo "=== Next Steps ==="
echo "1. Log out and select 'i3' as the session type"
echo "2. Log in as user: $CHILD_USER (password: child123)"
echo "3. Or set up auto-login by editing /etc/lightdm/lightdm.conf:"
echo "   autologin-user=$CHILD_USER"
echo ""
echo "=== Usage ==="
echo "- Press Super+Home to show the launcher"
echo "- Use Super+1,2,3,4 to launch apps directly"
echo "- Click the lock icon (🔒) and enter parent password to exit"
echo ""
echo "Parent password set: $PARENT_PASSWORD"
echo "Save this password securely!"
EOF