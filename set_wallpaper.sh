#!/usr/bin/osascript

# Set wallpaper for all displays
# Usage: ./set_wallpaper.sh "/path/to/wallpaper.jpg"

on run argv
    if (count of argv) = 0 then
        display dialog "Please provide the path to your wallpaper file" buttons {"OK"} default button "OK"
        return
    end if
    
    set wallpaperPath to item 1 of argv
    
    tell application "System Events"
        -- Get all desktops (each display has a desktop)
        set allDesktops to every desktop
        
        repeat with currentDesktop in allDesktops
            try
                set picture of currentDesktop to wallpaperPath
                log "Set wallpaper for display: " & (id of currentDesktop)
            on error errMsg
                log "Error setting wallpaper: " & errMsg
            end try
        end repeat
    end tell
    
    display notification "Wallpaper set for all displays" with title "Wallpaper Applied"
end run