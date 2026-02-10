# Rekordbox Primer - Power User Guide

## Overview

**Rekordbox** is Pioneer DJ's professional DJ software and music management platform. It's the industry-standard tool for organizing, analyzing, and preparing music for performance on Pioneer DJ hardware (CDJs, XDJs, controllers).

**Key Features:**
- Music library management with intelligent tagging
- Advanced track analysis (BPM, key, waveform)
- Hot cues, memory cues, and loops
- Playlist and smart playlist creation
- USB drive export for CDJ/XDJ performance
- Performance mode (with DJ controller)
- Cloud library sync (with subscription)

**Version Types:**
- **Rekordbox Free:** Basic library management and export
- **Rekordbox Core Plan:** Performance mode, DVS, cloud sync
- **Rekordbox Professional Plan:** Full feature set including video, Ableton Link

---

## Quick Start

### Initial Setup

1. **Import Music:**
   - Drag folders from Finder into Rekordbox
   - Or: File → Import → Track/Folder
   - Recommended: Keep music in organized folder structure outside Rekordbox

2. **Analyze Tracks:**
   - Select tracks → Right-click → Analyze
   - Or: Select all (Cmd+A) → Analyze entire library
   - Analysis provides: BPM, key, waveform, beat grid

3. **Set Master Folder:**
   - Preferences → Advanced → Database Management
   - Set "rekordbox" folder location for organized exports

---

## USB Drive Export Workflow

### Preparing USB Drive

**Required Format:**
- **File System:** FAT32 or exFAT
- **Partition Scheme:** MBR (Master Boot Record)
- **Recommended:** exFAT for files >4GB support

**Formatting on macOS:**
```bash
# Option 1: Disk Utility
# 1. Open Disk Utility
# 2. Select USB drive
# 3. Erase → Format: exFAT, Scheme: Master Boot Record

# Option 2: Terminal
diskutil list  # Find your USB drive identifier (e.g., disk2)
diskutil eraseDisk exFAT REKORDBOX_USB MBR /dev/diskX  # Replace diskX
```

### Export Process

**Method 1: Standard Export**
1. Insert USB drive
2. Rekordbox will detect it in sidebar under "DEVICE"
3. Drag playlists or tracks from Collection to USB drive
4. Wait for "export complete" notification
5. Eject safely: Right-click USB → Eject

**Method 2: Sync Manager (Faster)**
1. Create playlists in Collection
2. Right-click USB drive → Link Playlist
3. Select playlists to sync
4. Click "Sync" - only new/changed tracks transfer

**What Gets Exported:**
- Audio files (copied to USB)
- All cue points, loops, hot cues
- Beat grid and BPM analysis
- Track metadata (key, genre, comments)
- Playlist structure
- Artwork (embedded)

### Import from USB Drive

**Scenario 1: Import Analyzed Tracks**
1. Insert USB with Rekordbox database
2. Rekordbox detects USB in sidebar
3. Drag tracks/playlists from USB to Collection
4. Analysis data imports automatically

**Scenario 2: Import from Another DJ's USB**
1. Insert USB → Right-click → Import Playlist
2. Select playlists to import
3. Choose "Copy" or "Reference" tracks
4. Import hot cues and analysis: Preferences → Advanced → Import/Export → "Import hot cues and memory cues from other DJ's tracks"

---

## Power User Tips & Tricks

### Library Management

**1. Related Tracks**
- Right-click track → Related Tracks
- Find tracks by same artist, key, BPM range
- Build playlists faster

**2. Smart Playlists**
- Playlists (bottom left) → + icon → Smart Playlist
- Auto-update based on rules (BPM, key, genre, date added)
- Example: "New House 120-128 BPM" auto-fills

**3. Tag System**
- Add custom tags: Right-click → Tag → Add Tag
- Color-code tracks for energy levels, set times, etc.
- Filter by tags in browser

**4. My Tags (Color Coding)**
- Preferences → View → My Tag
- Assign up to 10 color tags
- Quick visual organization: pink = peak time, green = warm-up

**5. Bulk Editing**
- Select multiple tracks → Right-click → Edit Properties
- Change genre, BPM, key, artwork for many tracks at once
- Cmd+Click for non-contiguous selection

### Track Preparation

**6. Beat Grid Editing**
- Click "GRID" button below waveform
- Adjust grid if auto-analysis is off: Shift+scroll to move, Cmd+scroll to zoom
- Essential for looping and sync accuracy

**7. Memory Cues**
- Set cue points during prep, trigger on hardware
- Cmd+Click on waveform to set memory cue
- Label them: intro, verse, drop, outro
- 10 memory cues + 8 hot cues per track

**8. Quick Hot Cue Setting**
- Load track → Press "CUE" to set default cue
- Set hot cues at key moments: intro, breakdown, drop
- Shortcut: Cmd+1 through Cmd+8 for hot cues

**9. Loop Presets**
- Set loops at strategic points
- Active Loop saves automatically
- Manual loops: Click/drag on waveform

**10. Key Analysis Modes**
- Standard mode (general mixing)
- DJ mode (harmonic mixing focused)
- Preferences → Analysis → Key Analysis Mode
- Use with Camelot Wheel for harmonic sets

### Performance Optimization

**11. Custom Columns**
- Right-click column headers → Add custom columns
- Show/hide: Date Added, Comment, Original Artist, Label
- Create workflow-specific views

**12. Rating System**
- Rate tracks 1-5 stars during prep
- Filter: "My Library" → Rating → 5 stars only
- Build A-list playlists for gigs

**13. Sorting Hacks**
- Sort by BPM → Group similar tempos
- Sort by Key → Build harmonic mixes
- Sort by Date Added → Find newest tracks fast
- Multi-level sorting: Hold Shift while clicking column headers

**14. Playlist Folders**
- Organize playlists into folders (genre, venue, set type)
- Right-click Playlists → New Folder
- Drag playlists into folders

**15. Duplicate Track Finder**
- File → Display All Duplicated Files
- Clean library by removing duplicates
- Keeps highest quality version

### USB & Hardware Integration

**16. Multiple USB Drives**
- Prepare 2+ USB drives with same content
- Backup in case of drive failure at gig
- Name them clearly: "USB_A", "USB_B"

**17. USB Drive Optimization**
- Use high-quality, fast USB 3.0+ drives
- SanDisk, Samsung recommended
- Avoid cheap drives - corruption risk

**18. Offline Music Management**
- Keep master library on computer
- Export curated sets to USB
- Don't store entire library on USB (performance issues on CDJs)

**19. CDJ/XDJ Best Practices**
- Eject USB from Rekordbox before removing
- On CDJ: Press "MENU" → "Eject USB" before removing
- Prevents database corruption

**20. Playlist Limit Awareness**
- CDJs handle up to ~10,000 tracks efficiently
- More than that = slower browsing
- Curate smaller, focused collections for gigs

### Keyboard Shortcuts (macOS)

**Library Navigation:**
- `Cmd+F` - Search
- `Cmd+A` - Select all
- `Cmd+Click` - Multi-select (non-contiguous)
- `Shift+Click` - Select range
- `Spacebar` - Play/pause
- `←/→` - Skip through track
- `↑/↓` - Navigate track list

**Track Management:**
- `Cmd+I` - Track info
- `Cmd+1-8` - Set hot cues 1-8
- `Cmd+Delete` - Remove from playlist (not from library)
- `Cmd+Opt+Delete` - Delete file from computer
- `Cmd+D` - Duplicate playlist

**Analysis:**
- `Cmd+Shift+A` - Analyze selected tracks
- `Cmd+Shift+R` - Re-analyze

**View:**
- `Cmd+1` - Tree view
- `Cmd+2` - Browse view
- `Cmd+3` - Performance view (if unlocked)
- `Cmd+Opt+I` - Show/hide info panel

### Advanced Features

**21. iTunes/Music App Integration**
- Preferences → View → iTunes/Music → "Display iTunes Library"
- Access Apple Music/iTunes playlists
- Analyze and add to Rekordbox Collection

**22. Recordbox XML Export**
- File → Export Collection in XML format
- Use for backup or importing to other software
- Compatible with some third-party tools

**23. Track Stacks**
- Group multiple versions of same track
- Right-click tracks → Group Tracks
- Clean library view, quick version switching

**24. Custom Waveform Colors**
- Preferences → View → Waveform Color
- Change by frequency bands
- Blue = low, green = mid, red = high

**25. Auto Backup**
- Preferences → Advanced → Database → Backup Library
- Schedule automatic backups
- Essential for protecting years of cue point work

**26. Cloud Library Sync (Core/Professional Plan)**
- Sync library across devices
- Access on mobile (iOS/Android app)
- Cloud playlists auto-update

**27. Matching Tracks (BPM/Key)**
- Right-click track → Matching → By Key/BPM
- Instantly find compatible mix-out tracks
- Saves time during set preparation

**28. Comment Field Power Use**
- Add personal notes: energy level, crowd reactions, mix notes
- Search by comments later
- Example: "!!!" for peak-time bangers

**29. Preparation View**
- Switch to "Preparation" view (top bar)
- See both decks side-by-side
- Practice transitions before gigs

**30. Lighting Integration (Professional Plan)**
- Control compatible DJ lights from Rekordbox
- Sync lighting to beat grid and hot cues
- Create full audio-visual performances

---

## Troubleshooting

### USB Drive Not Recognized on CDJ

**Solutions:**
1. Reformat drive: exFAT, MBR partition scheme
2. Try different USB port on CDJ
3. Check drive health: Replace if old/failing
4. Remove USB from Rekordbox before ejecting

### Tracks Missing on USB

**Solutions:**
1. Verify files are on USB in Finder (check PIONEER folder)
2. Re-export playlist to USB
3. Check "Missing Files" in Collection - relocate if needed
4. Ensure track format is supported: MP3, AAC, WAV, FLAC, AIFF

### BPM/Beat Grid Wrong

**Solutions:**
1. Select track → Right-click → Analyze Again
2. Manually adjust: Click "GRID" button, adjust beat markers
3. For complex tracks: Set beat grid to half-time or double-time

### Slow Performance

**Solutions:**
1. Analyze tracks in batches (not all at once)
2. Limit USB library size (<10,000 tracks)
3. Close other applications during Rekordbox use
4. Check storage space on computer (20GB+ free recommended)

---

## Workflow Examples

### Pre-Gig USB Preparation

1. **Create Set Playlist:**
   - New Playlist → Name by venue/date
   - Drag 50-100 tracks for 2-3 hour set
   - Add backups (extra 20-30 tracks)

2. **Review & Prep:**
   - Check all tracks have hot cues
   - Verify beat grids are accurate
   - Set memory cues at key moments
   - Rate tracks for quick filtering

3. **Export to USB:**
   - Insert USB drive (formatted exFAT/MBR)
   - Drag playlist to USB device in sidebar
   - Wait for export complete
   - Eject safely

4. **Create Backup:**
   - Insert second USB
   - Repeat export process
   - Label USBs clearly

5. **Test on CDJ:**
   - Insert USB into CDJ
   - Browse playlists
   - Load tracks, test hot cues
   - Verify everything works

### Post-Gig Library Update

1. **Import Performance Data:**
   - Insert USB from gig
   - Check "Play History" on USB
   - Drag played tracks to "Played [Date]" playlist

2. **Rate Tracks:**
   - Review which tracks worked
   - Update ratings based on crowd response
   - Add comments: "floor filler", "empty floor", etc.

3. **Update Master Library:**
   - Add new tracks
   - Remove underperformers
   - Refine playlists for next gig

---

## Integration with Music Production

### Exporting from DAW to Rekordbox

1. **Export Settings:**
   - Format: WAV (uncompressed) or 320kbps MP3
   - Sample rate: 44.1kHz or 48kHz
   - Bit depth: 16-bit or 24-bit

2. **Metadata:**
   - Add: Artist, Title, BPM, Key
   - Embed artwork (1400x1400px minimum)
   - Use ID3v2.3 tags for best compatibility

3. **Import to Rekordbox:**
   - Drag exported file into Collection
   - Analyze track
   - Set hot cues at: intro, build, drop, breakdown, outro
   - Add to relevant playlists

---

## Resources

**Official:**
- [Rekordbox Download](https://rekordbox.com/)
- [Rekordbox Support](https://rekordbox.com/en/support/)
- [Pioneer DJ Forum](https://forums.pioneerdj.com/)

**Learning:**
- YouTube: "DJ Carlo Atendido" (Rekordbox tutorials)
- YouTube: "Crossfader" (DJ tips)
- Digital DJ Tips blog

**File Management:**
- Music Brainz Picard - Auto-tag music files
- Mp3tag - Batch metadata editing
- MixedInKey - Advanced key detection (alternative to Rekordbox)

**Harmonic Mixing:**
- Camelot Wheel reference
- Mixed In Key integration
- Key notation: 1A-12A (minor), 1B-12B (major)

---

## Pro Tips Summary

1. **Always prepare hot cues and memory cues before gigs**
2. **Use smart playlists to auto-organize by BPM/key/genre**
3. **Maintain 2 USB drives as backup**
4. **Format USB drives as exFAT with MBR partition scheme**
5. **Keep master library under 10,000 tracks per USB for CDJ performance**
6. **Rate tracks 1-5 stars, filter by rating for curated sets**
7. **Use tags and My Tags for visual organization**
8. **Enable "Related Tracks" and "Matching" features for quick discovery**
9. **Back up Rekordbox database regularly**
10. **Test USBs on actual CDJ hardware before important gigs**

---

## Next Steps

- [ ] Import music library and analyze all tracks
- [ ] Set hot cues on top 100 most-played tracks
- [ ] Create smart playlists by genre and BPM ranges
- [ ] Format 2 USB drives (exFAT, MBR)
- [ ] Export first curated set to USB
- [ ] Practice with USB on CDJ/XDJ hardware
- [ ] Develop personal tagging/rating system
- [ ] Learn harmonic mixing with Camelot Wheel
