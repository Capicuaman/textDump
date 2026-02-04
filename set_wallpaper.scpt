#!/usr/bin/osascript

# Quick wallpaper setter for all displays
# Usage: osascript set_wallpaper.scpt "/path/to/image.jpg"

on run argv
    if (count of argv) = 0 then
        display dialog "Usage: osascript set_wallpaper.scpt \"/path/to/image.jpg\"" buttons {"OK"} default button "OK"
        return
    end if
    
    set wallpaperPath to item 1 of argv
    
    try
        tell application "Finder"
            set desktop picture to (POSIX file wallpaperPath) as alias
        end tell
        
        tell application "System Events"
            set picture of every desktop to wallpaperPath
        end tell
        
        display notification "Wallpaper applied to all displays" with title "Wallpaper Set"
        
    on error errMsg
        display dialog "Error setting wallpaper: " & errMsg buttons {"OK"} default button "OK"
    end try
end run