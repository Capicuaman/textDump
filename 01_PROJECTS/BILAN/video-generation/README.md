# BILAN Video Generation with Remotion

> **NOTE:** The actual Remotion code and source files have been moved to a separate project repository. This directory now contains documentation only for reference purposes. If you need the working code, please refer to the external video generation project.

Automated batch video generation system for creating TikTok, Instagram Reels, and YouTube Shorts at scale.

## Overview

This system allows you to generate multiple videos from a CSV file, with 4 pre-built templates:

1. **Educational** - Deep-dive educational content (60s)
2. **Mythbusting** - Debunk common myths (30s)
3. **QuickTip** - Fast, actionable tips (15s)
4. **Trending** - Leverage trending formats (40s)

## Project Structure

```
video-generation/
├── src/
│   ├── templates/          # Video template components
│   │   ├── EducationalVideo.tsx
│   │   ├── MythbustingVideo.tsx
│   │   ├── QuickTipVideo.tsx
│   │   └── TrendingVideo.tsx
│   ├── utils/              # Utility functions
│   │   └── csvParser.ts
│   ├── data/               # CSV data files
│   │   └── videos.csv
│   ├── index.ts            # Remotion entry point
│   ├── Root.tsx            # Root component
│   └── batch-render.js     # Batch rendering script
├── out/                    # Rendered videos output
├── public/                 # Public assets
├── package.json
├── tsconfig.json
└── remotion.config.ts
```

## Quick Start

### 1. Install Dependencies

```bash
cd 01_PROJECTS/BILAN/video-generation
npm install
```

### 2. Preview Templates

```bash
npm run dev
```

This opens the Remotion Studio where you can preview and edit templates.

### 3. Prepare Your CSV

Edit `src/data/videos.csv` with your video content. See [CSV Format](#csv-format) below.

### 4. Render Videos

```bash
# Render all videos from default CSV
npm run render

# Render from specific CSV
CSV_FILE=path/to/your/videos.csv npm run render

# Specify output directory
OUTPUT_DIR=../MARKETING/VIDEO/rendered npm run render

# Control concurrency (default: 2)
CONCURRENCY=4 npm run render
```

## CSV Format

### Required Columns (All Videos)

- `id` - Unique identifier
- `type` - Video type: `Educational`, `Mythbusting`, `QuickTip`, or `Trending`
- `title` - Video title
- `cta` - Call to action text
- `brandColor` - Hex color (optional, defaults to `#00a86b`)

### Educational Videos

- `hook` - Opening hook text
- `mainPoints` - Pipe-separated points (`Point 1|Point 2|Point 3`)
- `conclusion` - Closing statement

### Mythbusting Videos

- `myth` - The myth to debunk
- `truth` - The actual truth
- `explanation` - Detailed explanation

### QuickTip Videos

- `tip` - The tip text
- `reason` - Why this tip works
- `duration` - Duration in seconds (15-30)

### Trending Videos

- `hook` - Opening hook
- `scenes` - Pipe-separated scenes (`Scene 1|Scene 2|Scene 3`)
- `trendingFormat` - Format type: `transformation`, `pov`, `challenge`, or `duet`

### Example CSV Row

```csv
1,Educational,Benefits of Magnesium,Did you know magnesium affects 300+ body functions?,Improves muscle recovery|Reduces cramps and fatigue|Supports better sleep,That's why BILAN uses magnesium glycinate,,,,,,,,,Try BILAN today,#00a86b
```

## Video Templates

### Educational Video (60s)

**Structure:**
- Hook (5s)
- Main points (4s each)
- Conclusion (4s)
- CTA (3s)

**Best for:**
- Product benefits
- Ingredient education
- Scientific explanations

### Mythbusting Video (30s)

**Structure:**
- Title card (3s)
- Myth presentation (6s)
- Truth reveal (8s)
- Explanation (8s)
- CTA (5s)

**Best for:**
- Correcting misconceptions
- Competitive differentiation
- Building credibility

### QuickTip Video (15s)

**Structure:**
- Hook (3s)
- Tip (6s)
- Reason (4s)
- CTA (2s)

**Best for:**
- Fast, actionable advice
- High-volume testing
- Viral potential

### Trending Video (40s)

**Structure:**
- Hook (3s)
- Scenes (8s each)
- CTA (3s)

**Best for:**
- Leveraging TikTok trends
- Transformation stories
- Relatable content

## Customization

### Modify Templates

Edit files in `src/templates/` to customize:
- Colors and branding
- Fonts and typography
- Animations and transitions
- Timing and pacing

### Add New Templates

1. Create new component in `src/templates/`
2. Add composition in `src/Root.tsx`
3. Update CSV parser in `src/utils/csvParser.ts`
4. Update batch render script to handle new type

### Brand Assets

Place brand assets in `public/`:
- `public/logo.png` - Logo
- `public/fonts/` - Custom fonts
- `public/images/` - Background images, products

## Integration with Claude Code

### Generate Videos from Claude

Use Claude Code tasks to generate CSV data and render videos:

```
TASK: Generate 10 TikTok video scripts and render them

1. Create CSV with video data at src/data/tiktok-batch-YYYY-MM-DD.csv
2. Run batch render: CSV_FILE=src/data/tiktok-batch-YYYY-MM-DD.csv npm run render
3. Report when complete

Types to generate:
- 3 Educational videos
- 3 Mythbusting videos
- 2 QuickTip videos
- 2 Trending videos

Research from: 01_PROJECTS/BILAN/PRODUCT/ and MARKETING/RAG/
```

### Automated Workflow

See `01_PROJECTS/BILAN/claude_code_task_workflows.md` for integration with the TikTok testing workflow.

## Performance

### Rendering Speed

- QuickTip (15s): ~2-3 minutes
- Mythbusting (30s): ~4-5 minutes
- Trending (40s): ~5-6 minutes
- Educational (60s): ~7-8 minutes

### Batch Rendering

With `CONCURRENCY=2`:
- 10 videos: ~30-45 minutes
- 20 videos: ~60-90 minutes

With `CONCURRENCY=4` (requires more RAM):
- 10 videos: ~15-25 minutes
- 20 videos: ~30-45 minutes

## Troubleshooting

### Bundle Errors

```bash
# Clear Remotion cache
rm -rf node_modules/.cache

# Reinstall dependencies
rm -rf node_modules package-lock.json
npm install
```

### Memory Issues

Reduce concurrency:
```bash
CONCURRENCY=1 npm run render
```

### Video Quality

Adjust quality in `remotion.config.ts`:
```typescript
Config.setVideoImageFormat("png"); // Higher quality
Config.setCodec("h264-mkv"); // Different codec
```

## Output

Videos are saved to `out/` directory with format:
```
{id}-{title-slug}.mp4
```

Example:
```
1-benefits-of-magnesium.mp4
2-8-glasses-myth.mp4
```

## Next Steps

1. **Test the system**: Run `npm run dev` to preview templates
2. **Create your first batch**: Edit `src/data/videos.csv` and render
3. **Integrate with workflow**: Use Claude Code tasks for automation
4. **Scale up**: Generate 10 videos daily for TikTok testing

## Resources

- [Remotion Documentation](https://remotion.dev)
- [TikTok Best Practices](https://www.tiktok.com/creators/)
- [BILAN Video Strategy](../MARKETING/VIDEO/)

## Support

For issues or questions, see:
- `USAGE.md` - Detailed usage guide
- `CSV_TEMPLATE.md` - CSV format documentation
- BILAN Claude Code docs in `01_PROJECTS/BILAN/`
