# Rekordbox Beginner USB Workflow

A simple step-by-step guide for analyzing music and exporting to USB drive for DJ performance.

---

## What You'll Need

- Rekordbox software (free version works fine)
- Your music files (MP3, WAV, FLAC, AIFF)
- USB drive (minimum 16GB recommended)
- CDJ/XDJ hardware (for performance)

---

## Step 1: Format Your USB Drive

**Important: This will erase everything on the USB drive.**

### Using Disk Utility (Easiest):
1. Open **Disk Utility** (search in Spotlight)
2. Select your USB drive from the left sidebar
3. Click **Erase** button at the top
4. Choose these settings:
   - **Format:** exFAT
   - **Scheme:** Master Boot Record
   - **Name:** REKORDBOX_USB (or whatever you prefer)
5. Click **Erase**
6. Wait for it to complete, then click **Done**

### Why These Settings?
- **exFAT** works with both Mac and CDJ hardware
- **Master Boot Record** is required for CDJs to recognize the drive

---

## Step 2: Import Your Music to Rekordbox

1. Open Rekordbox
2. Drag your music folder from Finder into the Rekordbox window
   - Or: Click **File** → **Import** → **Folder**
3. Your tracks will appear in the **Collection** view (left sidebar)

**Tip:** Keep your music organized in folders by genre before importing.

---

## Step 3: Analyze Your Tracks

This is the most important step - analysis gives you BPM, key, waveforms, and beat grids.

### Analyze All Tracks:
1. Select all tracks: Press **Cmd+A**
2. Right-click on selected tracks
3. Choose **Analyze**
4. Wait for analysis to complete (this can take time for large libraries)

### What Analysis Does:
- Detects BPM (beats per minute)
- Detects musical key
- Creates waveform visualization
- Sets beat grid for loops and sync

**Tip:** You can keep using your computer while tracks analyze in the background.

---

## Step 4: Create a Playlist

1. In the bottom left, find **Playlists** section
2. Click the **+** icon
3. Choose **New Playlist**
4. Name it (example: "First Gig" or "Practice Set")
5. Drag tracks from your **Collection** into this new playlist
6. Aim for 50-100 tracks for a 2-3 hour set

**Tip:** Organize by energy level - start mellow, build to peak, wind down at the end.

---

## Step 5: Set Hot Cues (Optional but Recommended)

Hot cues let you jump to important parts of a track instantly.

### For Each Track:
1. Double-click a track to load it in the player at bottom
2. Listen and find key moments:
   - **Intro** (where track actually starts)
   - **Verse** (main section)
   - **Drop** (the climax/hook)
   - **Breakdown** (quiet part)
   - **Outro** (where it ends)
3. Click on the waveform where you want a hot cue
4. Press **Cmd+1** (for hot cue 1), **Cmd+2** (for hot cue 2), etc.
5. Hot cues appear as colored markers on the waveform

**Beginner Tip:** Start with just 3 hot cues per track:
- Hot Cue 1: Intro/first drop
- Hot Cue 2: Main drop/hook
- Hot Cue 3: Outro/mix-out point

---

## Step 6: Export to USB Drive

### Method 1: Export Playlist (Recommended)
1. Insert your formatted USB drive
2. Rekordbox should automatically detect it
3. Look for your USB in the left sidebar under **DEVICE**
4. Drag your playlist from **Playlists** onto the USB device
5. Wait for the export to complete (progress bar appears)
6. You'll see a notification when done

### Method 2: Export Tracks Without Playlist
If you have tracks that aren't in a playlist:

1. Insert your USB drive (appears under **DEVICE**)
2. Go to **Collection** view
3. Select tracks you want to export:
   - Click individual tracks
   - Cmd+Click for multiple tracks
   - Cmd+A to select all
4. Drag selected tracks directly onto the USB device
5. Wait for export to complete

**Note:** Tracks exported without a playlist will appear in the root level on your CDJ. Using playlists (Method 1) makes browsing much easier during performance.

### What Gets Copied:
- All audio files
- BPM and key analysis
- Hot cues and cue points
- Beat grids
- Playlist structure (if using Method 1)

---

## Step 7: Safely Eject USB

**IMPORTANT:** Always eject properly to prevent corruption.

1. Right-click on the USB drive in Rekordbox sidebar
2. Choose **Eject**
3. Wait for confirmation
4. Remove USB from computer

---

## Step 8: Test on CDJ/XDJ

1. Insert USB into CDJ Link port
2. Press **LINK** button on CDJ
3. Use the rotary knob to browse
4. Navigate to your playlist
5. Load a track by pressing the track load button
6. Your hot cues and analysis are ready to use

---

## Quick Reference

### Essential Keyboard Shortcuts:
- **Cmd+A** - Select all tracks
- **Cmd+F** - Search tracks
- **Spacebar** - Play/pause preview
- **Cmd+1 through Cmd+8** - Set hot cues 1-8
- **Cmd+Shift+A** - Analyze selected tracks

### Workflow Checklist:
- [ ] Format USB (exFAT, MBR)
- [ ] Import music to Rekordbox
- [ ] Analyze all tracks
- [ ] Create playlist
- [ ] Set hot cues on key tracks
- [ ] Export playlist to USB
- [ ] Eject USB safely
- [ ] Test on CDJ hardware

---

## Common Beginner Mistakes to Avoid

1. **Not analyzing tracks** - CDJs won't show proper waveforms or BPM without analysis
2. **Wrong USB format** - Must be exFAT or FAT32 with MBR partition scheme
3. **Unplugging USB without ejecting** - Can corrupt your database
4. **Too many tracks on USB** - Keep under 10,000 tracks for best CDJ performance
5. **Not setting hot cues** - Makes live mixing much harder
6. **Not having a backup USB** - Always prepare 2 USB drives with same content

---

## Next Steps After Mastering the Basics

1. Learn beat grid adjustment for tracks with incorrect analysis
2. Explore memory cues for more detailed track preparation
3. Use smart playlists to auto-organize by BPM/key
4. Learn harmonic mixing with the Camelot Wheel
5. Practice rating tracks (1-5 stars) to build A-list playlists
6. Try color tags for quick visual organization

---

## Troubleshooting

### USB Not Showing in CDJ:
- Reformat as exFAT with MBR partition scheme
- Try different USB drive (some cheap drives don't work well)
- Check USB is properly ejected from Rekordbox first

### Analysis Taking Forever:
- Normal for large libraries (1000+ tracks can take hours)
- Let it run overnight
- Analyze in smaller batches

### Track Sounds Wrong (BPM/Beat Grid Off):
- Right-click track → **Analyze Again**
- Or manually adjust beat grid in waveform editor

### Tracks Missing on USB:
- Check file format (MP3, WAV, FLAC, AIFF supported)
- Verify files actually copied (check PIONEER folder on USB in Finder)
- Re-export playlist to USB

---

## Additional Resources

**Official:**
- [Rekordbox Download](https://rekordbox.com/)
- [Rekordbox Support Videos](https://rekordbox.com/en/support/)

**YouTube Tutorials:**
- "DJ Carlo Atendido" - Excellent Rekordbox beginner series
- "Crossfader" - DJ technique and software tips

**Full Reference:**
- See `rekordbox_primer.md` in this folder for advanced features and power user tips

---

## Summary: The Absolute Minimum

If you only remember 5 things:

1. **Format USB as exFAT/MBR**
2. **Analyze your tracks** (Cmd+A, right-click, Analyze)
3. **Create a playlist** and add your tracks
4. **Drag playlist to USB** to export
5. **Eject properly** before removing USB

That's it. Start here, and add complexity as you get comfortable.
