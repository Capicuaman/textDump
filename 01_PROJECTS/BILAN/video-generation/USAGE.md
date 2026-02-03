# BILAN Video Generation - Usage Guide

> **NOTE:** The actual Remotion code has been moved to a separate project. This documentation is kept for reference only.

Detailed instructions for using the Remotion-based video generation system.

## Table of Contents

1. [Installation](#installation)
2. [Development Workflow](#development-workflow)
3. [CSV Management](#csv-management)
4. [Batch Rendering](#batch-rendering)
5. [Template Customization](#template-customization)
6. [Claude Code Integration](#claude-code-integration)
7. [Production Tips](#production-tips)

---

## Installation

### Prerequisites

- Node.js 18+ (check with `node --version`)
- npm or yarn
- FFmpeg (for video encoding)

### Install FFmpeg

**macOS:**
```bash
brew install ffmpeg
```

**Linux:**
```bash
sudo apt update
sudo apt install ffmpeg
```

**Verify installation:**
```bash
ffmpeg -version
```

### Install Project Dependencies

```bash
cd 01_PROJECTS/BILAN/video-generation
npm install
```

This installs:
- Remotion (video framework)
- React (rendering engine)
- csv-parse (CSV processing)
- TypeScript (type safety)

---

## Development Workflow

### Step 1: Open Remotion Studio

```bash
npm run dev
```

This opens a browser at `http://localhost:3000` with:
- Live preview of all video templates
- Props editor for testing different content
- Timeline scrubber for precise timing
- Real-time changes as you edit code

### Step 2: Select a Template

In Remotion Studio:
1. Click on a composition (Educational, Mythbusting, QuickTip, Trending)
2. Edit props in the right panel
3. Scrub timeline to see animations
4. Export single videos if needed

### Step 3: Edit Templates

Templates are in `src/templates/`:
- **EducationalVideo.tsx** - Educational content
- **MythbustingVideo.tsx** - Myth debunking
- **QuickTipVideo.tsx** - Quick tips
- **TrendingVideo.tsx** - Trending formats

Edit any template and see changes live in Remotion Studio.

### Step 4: Test Changes

1. Modify template code
2. Save file
3. Changes appear in Remotion Studio automatically
4. Test with different props
5. Verify animations and timing

---

## CSV Management

### Create a CSV File

The easiest way is to use the template:

```bash
cp src/data/videos.csv src/data/my-batch-YYYY-MM-DD.csv
```

Then edit with:
- Excel / Google Sheets
- LibreOffice Calc
- Text editor
- Claude Code (generate CSV content)

### CSV Format Rules

1. **First row must be headers** (column names)
2. **Pipe separator for lists** (`|`) - Example: `Point 1|Point 2|Point 3`
3. **No commas in content** (commas break CSV parsing)
4. **Escape quotes** - Use `""` for quotes inside text
5. **Required fields** - Every video needs: `id`, `type`, `title`, `cta`

### Example Educational Video Row

```csv
id,type,title,hook,mainPoints,conclusion,myth,truth,explanation,tip,reason,duration,scenes,trendingFormat,cta,brandColor
5,Educational,Sodium and Performance,Most athletes don't get enough sodium,Prevents cramps|Maintains blood volume|Improves endurance,BILAN delivers the right amount,,,,,,,,,Get performance-grade hydration,#00a86b
```

### Validate CSV

Before rendering, check your CSV:

```bash
# Count videos
wc -l src/data/videos.csv

# View first 5 rows
head -5 src/data/videos.csv

# Check for common issues
grep -c '|' src/data/videos.csv  # Should be >0 if you have lists
```

---

## Batch Rendering

### Basic Usage

Render all videos from default CSV:

```bash
npm run render
```

This reads `src/data/videos.csv` and outputs to `out/`.

### Custom CSV File

```bash
CSV_FILE=src/data/tiktok-batch-2026-01-23.csv npm run render
```

### Custom Output Directory

```bash
OUTPUT_DIR=../MARKETING/VIDEO/rendered/2026-01 npm run render
```

### Both Custom

```bash
CSV_FILE=src/data/my-videos.csv OUTPUT_DIR=../out/january npm run render
```

### Control Concurrency

Render multiple videos simultaneously:

```bash
# Default: 2 videos at once
npm run render

# Faster: 4 videos at once (requires 8GB+ RAM)
CONCURRENCY=4 npm run render

# Conservative: 1 video at once (low memory)
CONCURRENCY=1 npm run render
```

### Monitor Progress

The batch renderer shows:
- Current video being rendered
- Progress percentage
- Time elapsed
- Estimated time remaining

Example output:
```
🚀 BILAN Batch Video Renderer

📄 Reading CSV: src/data/videos.csv
✓ Found 10 videos to render

📦 Bundling Remotion project...
✓ Bundling complete

🎬 Rendering: Benefits of Magnesium (Educational)
[████████████████████████████████████████] 100%
✅ Completed: Benefits of Magnesium

🎬 Rendering: 8 Glasses Myth (Mythbusting)
[████████████████████████████████████████] 100%
✅ Completed: 8 Glasses Myth

...

🎉 All videos rendered successfully!
📁 Output directory: /path/to/out
```

---

## Template Customization

### Change Brand Colors

Edit `src/Root.tsx` and change `brandColor`:

```typescript
export const educationalDefaultProps = {
  // ... other props
  brandColor: "#FF5733"  // Change to your brand color
};
```

Or in CSV:
```csv
id,type,...,brandColor
1,Educational,...,#FF5733
```

### Adjust Timing

Each template has timing constants. Edit in template files:

**Example: EducationalVideo.tsx**
```typescript
const hookDuration = fps * 5; // Change from 5s to 3s
const pointDuration = fps * 4; // Change from 4s to 6s
```

### Change Fonts

Add custom fonts to `public/fonts/`:

```
public/
└── fonts/
    ├── CustomFont-Regular.woff2
    └── CustomFont-Bold.woff2
```

Then use in templates:
```typescript
<div style={{
  fontFamily: "'CustomFont', sans-serif",
  fontSize: '72px'
}}>
  Text here
</div>
```

### Add Background Images

Place images in `public/`:

```
public/
├── bg-gradient.png
└── product-shot.png
```

Use in templates:
```typescript
<AbsoluteFill
  style={{
    backgroundImage: 'url(/bg-gradient.png)',
    backgroundSize: 'cover'
  }}
>
  {/* Content */}
</AbsoluteFill>
```

### Modify Animations

Remotion uses `spring()` and `interpolate()` for animations.

**Example: Change animation speed**
```typescript
const scale = spring({
  frame,
  fps,
  config: {
    damping: 50,   // Lower = more bouncy
    stiffness: 400 // Higher = faster
  },
});
```

---

## Claude Code Integration

### Generate CSV with Claude

**Prompt template:**
```
TASK: Generate CSV content for 10 TikTok videos

Create CSV rows for:
- 3 Educational videos about electrolyte benefits
- 3 Mythbusting videos about hydration myths
- 2 QuickTip videos about usage timing
- 2 Trending transformation videos

Format: Valid CSV with all required columns
Research: Use PRODUCT/ and MARKETING/RAG/ directories
Output: Save to video-generation/src/data/tiktok-YYYY-MM-DD.csv

Run in background.
```

### Automated Batch Workflow

**Full workflow prompt:**
```
TASK: Generate and render 10 TikTok videos

STEPS:
1. Generate CSV with 10 video scripts (research from PRODUCT/)
2. Save to: video-generation/src/data/batch-YYYY-MM-DD.csv
3. Run: cd video-generation && CSV_FILE=src/data/batch-YYYY-MM-DD.csv npm run render
4. Report completion with output directory

Run all steps in background and notify when complete.
```

### Integration with Testing Workflow

See `claude_code_task_workflows.md` section "TikTok Engagement Testing Workflow" for full integration.

---

## Production Tips

### Optimize Rendering Speed

1. **Use Haiku model** for CSV generation (faster, cheaper)
2. **Render overnight** for large batches
3. **Increase concurrency** if you have RAM
4. **Pre-bundle once** and reuse for multiple renders

### Quality Settings

For highest quality, edit `remotion.config.ts`:

```typescript
Config.setVideoImageFormat("png");  // vs "jpeg"
Config.setCodec("prores");           // vs "h264"
Config.setQuality(100);              // 0-100
```

**Trade-offs:**
- PNG: Higher quality, larger files, slower render
- ProRes: Broadcast quality, huge files
- Quality 100: Maximum fidelity, slower

### File Management

After rendering:
1. Review videos
2. Move keepers to `MARKETING/VIDEO/approved/`
3. Archive batch CSV for reference
4. Delete rejected videos to save space

### Testing Before Batch

Always test 1-2 videos before large batch:

1. Create small CSV with 2 videos
2. Render and review
3. Adjust templates if needed
4. Then render full batch

---

## Common Workflows

### Daily TikTok Content

```bash
# Morning: Generate scripts
claude "Generate 10 TikTok video CSV for today"

# Review and edit CSV
# Then render
npm run render

# Afternoon: Upload to TikTok
```

### Weekly Campaign

```bash
# Generate themed batch
claude "Generate 30 videos for hydration awareness week"

# Render over weekend
CONCURRENCY=4 npm run render

# Review on Monday
```

### A/B Testing

Create 2 CSVs with variations:
```bash
# Version A
CSV_FILE=src/data/test-a.csv OUTPUT_DIR=out/test-a npm run render

# Version B
CSV_FILE=src/data/test-b.csv OUTPUT_DIR=out/test-b npm run render
```

Post both and compare performance.

---

## Troubleshooting

### "Module not found" errors

```bash
rm -rf node_modules
npm install
```

### "FFmpeg not found"

Install FFmpeg (see Installation section).

### Out of memory

Reduce concurrency:
```bash
CONCURRENCY=1 npm run render
```

### Videos look wrong

Check CSV format:
- Are pipes (`|`) used for lists?
- Are all required fields present?
- Is the type spelled correctly?

### Slow rendering

- Close other apps
- Increase concurrency if you have RAM
- Use h264 codec (fastest)
- Reduce video quality in config

---

## Next Steps

1. Generate your first batch with Claude
2. Review rendered videos
3. Upload top performers to TikTok
4. Track engagement
5. Iterate and improve

For advanced usage, see `README.md` and Remotion docs.
