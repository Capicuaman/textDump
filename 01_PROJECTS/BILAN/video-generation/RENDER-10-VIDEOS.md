# Render 10 TikTok Videos - Mexican Market Campaign
## January 23, 2026 Batch

**Created:** 2026-01-23
**CSV File:** `src/data/videos-mx-2026-01-23.csv`
**Output Directory:** `out/`
**Total Videos:** 10

---

## Quick Start

### 1. Install Dependencies (First Time Only)

```bash
cd 01_PROJECTS/BILAN/video-generation
npm install
```

This will take 2-3 minutes.

### 2. Preview Videos in Browser

```bash
npm run dev
```

Opens `http://localhost:3000` - you can preview how videos will look.

### 3. Render All 10 Videos

```bash
CSV_FILE=src/data/videos-mx-2026-01-23.csv npm run render
```

**Expected time:** 5-10 minutes for all 10 videos
**Output location:** `out/videos-mx-2026-01-23/`

---

## Video List (10 Videos)

### Educational (2 videos)
1. **La Verdad sobre la Sal** (60s)
   - Hook: "¿Por qué los atletas consumen sal a montones?"
   - Focus: Sodium science, sweat loss

### Myth-Busting (2 videos)
3. **El Mito de los 8 Vasos** (45s)
   - Debunks 8 glasses myth
   - Mexican climate references (CDMX, Monterrey)

4. **Trampa de Bebidas Deportivas** (45s)
   - Exposes low sodium in sports drinks
   - Sugar comparison

### Quick Tips (3 videos)
2. **3 Señales de Deshidratación** (30s)
   - Warning signs: dark urine, fatigue, cravings

7. **Tip de Hidratación 15s** (15s)
   - Skin pinch test

8. **Secreto de los Atletas** (30s)
   - Professional hydration protocol

### Trending Formats (3 videos)
5. **Cómo Me Curé de los Calambres** (60s)
   - Transformation: cramps → playing full 90 min

6. **Transformación en el Gym** (60s)
   - +15% performance improvement

9. **POV Olvidas Electrolitos** (30s)
   - Humorous POV format

10. **Tutorial Hidratación Perfecta** (45s)
    - 3-step hydration protocol

---

## Rendering Options

### Render All Videos

```bash
CSV_FILE=src/data/videos-mx-2026-01-23.csv npm run render
```

### Render Single Video (for testing)

```bash
CSV_FILE=src/data/videos-mx-2026-01-23.csv VIDEO_ID=1 npm run render
```

Replace `VIDEO_ID=1` with any video number (1-10).

### Render Specific Category

**Educational only (videos 1, 3):**
```bash
# Edit CSV temporarily to include only those rows, or:
# Manually specify IDs in batch-render.js
```

---

## Output Files

Videos will be saved to:
```
out/videos-mx-2026-01-23/
├── 01-Educational-La_Verdad_sobre_la_Sal.mp4
├── 02-QuickTip-3_Senales_de_Deshidratacion.mp4
├── 03-Mythbusting-El_Mito_de_los_8_Vasos.mp4
├── 04-Mythbusting-Trampa_de_Bebidas_Deportivas.mp4
├── 05-Trending-Como_Me_Cure_de_los_Calambres.mp4
├── 06-Trending-Transformacion_en_el_Gym.mp4
├── 07-QuickTip-Tip_de_Hidratacion_15s.mp4
├── 08-QuickTip-Secreto_de_los_Atletas.mp4
├── 09-Trending-POV_Olvidas_Electrolitos.mp4
└── 10-Trending-Tutorial_Hidratacion_Perfecta.mp4
```

**Specifications:**
- Format: MP4 (H.264)
- Resolution: 1080 x 1920 (9:16 TikTok format)
- Frame rate: 30 fps
- File size: ~5-25 MB per video (depending on length)

---

## Moving Videos to TikTok Folder

After rendering:

```bash
# Create batch folder
mkdir -p ../MARKETING/SOCIAL-MEDIA/TikTok/testing/videos/batch_2026-01-23/

# Move rendered videos
mv out/videos-mx-2026-01-23/*.mp4 ../MARKETING/SOCIAL-MEDIA/TikTok/testing/videos/batch_2026-01-23/

# Or copy to keep originals
cp out/videos-mx-2026-01-23/*.mp4 ../MARKETING/SOCIAL-MEDIA/TikTok/testing/videos/batch_2026-01-23/
```

---

## Customization

### Edit Video Content

Edit the CSV file:
```bash
nano src/data/videos-mx-2026-01-23.csv
```

**CSV Columns:**
- `id` - Video number (1-10)
- `type` - Educational, Mythbusting, QuickTip, Trending
- `title` - Video title
- `hook` - Opening hook (first 3 seconds)
- `mainPoints` - Key points separated by `|`
- `conclusion` - Closing message
- `myth` - (For Mythbusting) The myth
- `truth` - (For Mythbusting) The truth
- `explanation` - (For Mythbusting) Explanation
- `tip` - (For QuickTip) The tip
- `reason` - (For QuickTip) Why it works
- `duration` - Video length in seconds
- `scenes` - (For Trending) Scene descriptions separated by `|`
- `trendingFormat` - transformation, pov, tutorial
- `cta` - Call to action
- `brandColor` - BILAN blue (#0066CC)

### Change Colors

Edit `src/templates/[TemplateName].tsx` to adjust:
- Background colors
- Text colors
- Brand colors
- Animations

### Add Background Music

1. Add MP3 files to `public/audio/`
2. Edit template files to include audio
3. Re-render

---

## Troubleshooting

### "Cannot find module 'remotion'"

```bash
npm install
```

### "FFmpeg not found"

Already installed! If issues:
```bash
ffmpeg -version
```

### Videos rendering slowly

Use fewer concurrent renders:
```bash
CONCURRENCY=1 CSV_FILE=src/data/videos-mx-2026-01-23.csv npm run render
```

### Out of memory

Render one at a time:
```bash
for i in {1..10}; do
  CSV_FILE=src/data/videos-mx-2026-01-23.csv VIDEO_ID=$i npm run render
done
```

### Preview not working

Ensure port 3000 is available:
```bash
lsof -ti:3000 | xargs kill -9
npm run dev
```

---

## Next Steps After Rendering

1. **Review Videos**
   - Watch each video
   - Check text readability on phone
   - Verify animations and timing

2. **Create Captions**
   - Copy CTAs from CSV to caption files
   - Add hashtags from `video_content_categories.md`

3. **Schedule Publishing**
   - Use TikTok Creator Studio
   - Follow publishing calendar from `engagement-tracking-2025-01-es-MX.md`

4. **Track Performance**
   - Use `engagement-tracking-2025-01-es-MX.md` template
   - Monitor metrics for each video

---

## Video Specifications by Type

### Educational (60s)
- Hook: 3s
- Main content: 50s
- CTA: 7s
- Style: Clean, informative overlays

### Mythbusting (45s)
- Hook: 3s
- Myth statement: 10s
- Truth reveal: 20s
- Explanation: 10s
- CTA: 7s
- Style: Dramatic, contrasting

### QuickTip (15-30s)
- Hook: 3s
- Tip: 5-15s
- Reason: 5-10s
- CTA: 5s
- Style: Fast-paced, actionable

### Trending (30-60s)
- Varies by format:
  - **Transformation:** Before → Discovery → After → CTA
  - **POV:** Scene 1 → Scene 2 → Scene 3 → Punchline → CTA
  - **Tutorial:** Step 1 → Step 2 → Step 3 → Summary → CTA

---

## Performance Expectations

Based on `video_content_categories.md`:

| Video Type | Expected Views (24h) | Engagement Rate | Best Metric |
|------------|---------------------|-----------------|-------------|
| Educational | 3,000-8,000 | 6-8% | Saves |
| Mythbusting | 4,000-12,000 | 9-12% | Comments |
| QuickTip | 15,000-50,000 | 14-18% | Completion |
| Trending | 8,000-70,000 | 15-20% | Shares |

---

## File References

- **Campaign Scripts:** `../MARKETING/SOCIAL-MEDIA/TikTok/testing/2025-01-23-batch-es-MX.md`
- **Tracking Template:** `../MARKETING/SOCIAL-MEDIA/TikTok/testing/engagement-tracking-2025-01-es-MX.md`
- **Content Categories:** `../MARKETING/SOCIAL-MEDIA/TikTok/video_content_categories.md`
- **Canva Strategy:** `../MARKETING/SOCIAL-MEDIA/TikTok/testing/canva_tiktok_bulk_strategy.md`

---

## Command Cheat Sheet

```bash
# Navigate to project
cd 01_PROJECTS/BILAN/video-generation

# Install (first time)
npm install

# Preview in browser
npm run dev

# Render all 10 videos
CSV_FILE=src/data/videos-mx-2026-01-23.csv npm run render

# Render single video for testing
CSV_FILE=src/data/videos-mx-2026-01-23.csv VIDEO_ID=7 npm run render

# Check output
ls -lh out/videos-mx-2026-01-23/

# Move to TikTok folder
mkdir -p ../MARKETING/SOCIAL-MEDIA/TikTok/testing/videos/batch_2026-01-23/
cp out/videos-mx-2026-01-23/*.mp4 ../MARKETING/SOCIAL-MEDIA/TikTok/testing/videos/batch_2026-01-23/
```

---

**Ready to render?**

```bash
cd 01_PROJECTS/BILAN/video-generation
npm install
CSV_FILE=src/data/videos-mx-2026-01-23.csv npm run render
```

Videos will be ready in ~10 minutes!
