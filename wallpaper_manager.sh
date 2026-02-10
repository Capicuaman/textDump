#!/bin/bash

# Universal Wallpaper Setter
# Sets wallpaper for all connected displays and monitors for new connections

WALLPAPER_PATH="$1"

if [ -z "$WALLPAPER_PATH" ]; then
    echo "Usage: $0 \"/path/to/wallpaper.jpg\""
    echo "Example: $0 \"$HOME/Pictures/wallpaper.jpg\""
    exit 1
fi

if [ ! -f "$WALLPAPER_PATH" ]; then
    echo "Error: Wallpaper file not found at $WALLPAPER_PATH"
    exit 1
fi

# Function to set wallpaper on all displays
set_wallpaper() {
    local wallpaper="$1"
    
    # Use osascript to set wallpaper on all desktops
    osascript -e "tell application \"System Events\" to set picture of every desktop to \"$wallpaper\"" 2>/dev/null
    
    # Alternative method using sqlite
    local db_path="$HOME/Library/Application Support/Dock/desktoppicture.db"
    if [ -f "$db_path" ]; then
        sqlite3 "$db_path" "UPDATE pictures SET path='$wallpaper';" 2>/dev/null
        killall Dock 2>/dev/null
    fi
}

# Function to detect and set wallpaper on new displays
monitor_displays() {
    while true; do
        current_displays=$(system_profiler SPDisplaysDataType | grep -c "Display Type:" || echo "1")
        
        if [ "$current_displays" -gt "$last_displays" ]; then
            echo "New display detected, applying wallpaper..."
            set_wallpaper "$WALLPAPER_PATH"
            last_displays=$current_displays
        fi
        
        sleep 5
    done
}

# Initial wallpaper setup
echo "Setting wallpaper to: $WALLPAPER_PATH"
set_wallpaper "$WALLPAPER_PATH"

echo "Wallpaper applied to current displays."
echo "Starting display monitor (press Ctrl+C to stop)..."

# Initialize display count
last_displays=$(system_profiler SPDisplaysDataType | grep -c "Display Type:" || echo "1")

# Start monitoring for new displays
monitor_displays