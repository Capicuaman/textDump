# Quick Start - BILAN Video Generation

> **NOTE:** The actual Remotion code has been moved to a separate project. This documentation is kept for reference only.

Get started generating videos in 5 minutes.

## 1. Install (One Time)

```bash
cd video-generation
npm install
```

This will take 2-3 minutes.

## 2. Preview Templates

```bash
npm run dev
```

Opens browser at `http://localhost:3000` - explore the 4 video templates.

## 3. Edit Your CSV

**For Spanish (Mexican market):**
```bash
# Edit this file with your content
nano src/data/videos-es.csv
# or open in your editor
```

**For English:**
```bash
nano src/data/videos.csv
```

## 4. Render Videos

**Render Spanish videos:**
```bash
CSV_FILE=src/data/videos-es.csv npm run render
```

**Render English videos:**
```bash
npm run render
```

Videos appear in `out/` directory.

## 5. Use with Claude Code

**Generate CSV content with Claude:**

```
Generate 10 TikTok video scripts in Mexican Spanish for BILAN

Types:
- 3 Educational
- 3 Mythbusting
- 2 QuickTip
- 2 Trending

Save to: video-generation/src/data/videos-mx-2026-01-23.csv

Use informal tú, reference Mexican climate/culture, research from PRODUCT/
```

Then render:
```bash
CSV_FILE=src/data/videos-mx-2026-01-23.csv npm run render
```

## Troubleshooting

**"command not found: npm"**
- Install Node.js from nodejs.org

**"FFmpeg not found"**
- Mac: `brew install ffmpeg`
- Linux: `sudo apt install ffmpeg`

**Out of memory**
- Use: `CONCURRENCY=1 npm run render`

## What's Next?

- Read `MEXICO-GUIDE.md` for Mexican market tips
- Read `USAGE.md` for detailed instructions
- See `README.md` for full documentation

## File Reference

- `videos-es.csv` - Spanish examples (15 videos)
- `videos.csv` - English examples (10 videos)
- `MEXICO-GUIDE.md` - Mexican market guide
- `LEEME.md` - Spanish README
