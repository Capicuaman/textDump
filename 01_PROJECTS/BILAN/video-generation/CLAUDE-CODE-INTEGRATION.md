# Claude Code + Remotion Integration Guide

Complete guide for using Claude Code to automate video generation.

## Overview

Claude Code can generate video scripts as CSV data, then trigger Remotion to render them into finished videos - fully automated.

## Workflow Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Claude Code                             │
│  (Research → Generate CSV → Render → Organize)              │
└──────┬────────────────────────────┬─────────────────────────┘
       │                            │
       │ Generates CSV              │ Executes rendering
       ▼                            ▼
┌─────────────────┐         ┌──────────────────┐
│  videos-mx-     │────────>│   Remotion       │
│  2026-01-23.csv │         │   (batch-render) │
└─────────────────┘         └────────┬─────────┘
                                     │
                                     │ Outputs videos
                                     ▼
                            ┌─────────────────┐
                            │   out/          │
                            │   (MP4 files)   │
                            └─────────────────┘
```

## Integration Methods

### Method 1: Single Task (Recommended)

Claude generates CSV and renders in one background task.

**Prompt:**
```
TASK: Generate and render 10 TikTok videos for Mexican market

PROCESS:
1. Research electrolyte benefits from PRODUCT/ directory
2. Research customer questions from MARKETING/RAG/faq.json
3. Generate CSV with 10 video scripts in Mexican Spanish
   - 3 Educational
   - 3 Mythbusting
   - 2 QuickTip
   - 2 Trending
4. Save CSV to: video-generation/src/data/videos-mx-YYYY-MM-DD.csv
5. Execute: cd video-generation && CSV_FILE=src/data/videos-mx-YYYY-MM-DD.csv npm run render
6. Report completion with video list

REQUIREMENTS:
- Language: Mexican Spanish (informal tú)
- Tone: Cercano, motivacional
- References: Mexican climate, altitude, local sports
- Brand: BILAN green (#00a86b)

Run entire task in background. Notify when videos are ready.
```

### Method 2: Separate Tasks

Generate CSV first, review, then render.

**Step 1: Generate CSV**
```
TASK: Generate 10 TikTok video scripts in CSV format

Create for Mexican market with:
- 3 Educational videos about electrolyte benefits
- 3 Mythbusting videos about hydration myths
- 2 QuickTip videos about usage timing
- 2 Trending transformation videos

Research from:
- PRODUCT/ for science
- MARKETING/RAG/faq.json for common questions
- MARKETING/ for brand voice

Output:
- Format: Valid CSV matching template
- Language: Mexican Spanish (tú informal)
- Save to: video-generation/src/data/videos-mx-YYYY-MM-DD.csv
- Include all required columns

Run in background.
```

**Step 2: Review CSV (Manual)**

Open and review the generated CSV, make any edits.

**Step 3: Render Videos**
```
TASK: Render videos from CSV

Execute:
cd video-generation
CSV_FILE=src/data/videos-mx-YYYY-MM-DD.csv npm run render

Report when complete.
```

### Method 3: Parallel Generation

Generate multiple CSV batches simultaneously, render all.

**Prompt:**
```
TASK: Generate 3 different CSV batches in parallel

Batch A - Educational Focus (10 videos)
- Save to: videos-educational-YYYY-MM-DD.csv
- All Educational and Mythbusting types

Batch B - Quick Tips (10 videos)
- Save to: videos-quicktips-YYYY-MM-DD.csv
- All QuickTip types (15s videos)

Batch C - Trending Formats (10 videos)
- Save to: videos-trending-YYYY-MM-DD.csv
- All Trending types with various formats

Run all 3 in parallel as background tasks.

After all complete, render each batch:
CSV_FILE=src/data/videos-educational-YYYY-MM-DD.csv npm run render
CSV_FILE=src/data/videos-quicktips-YYYY-MM-DD.csv npm run render
CSV_FILE=src/data/videos-trending-YYYY-MM-DD.csv npm run render
```

## Prompt Templates

### Daily Content Generation

```
Generate today's 10 TikTok videos for BILAN Mexico

Date: [YYYY-MM-DD]
Theme: [optional theme, e.g., "Summer Hydration"]

Types:
- 3 Educational (research from PRODUCT/)
- 3 Mythbusting (use common myths)
- 2 QuickTip (practical advice)
- 2 Trending (leverage current TikTok trends)

Language: Mexican Spanish
Tone: Informal, motivational
CTAs: "Prueba BILAN", "Link en bio", "Ordena hoy"

Save to: video-generation/src/data/daily-YYYY-MM-DD.csv
Then render: CSV_FILE=src/data/daily-YYYY-MM-DD.csv npm run render

Run in background, notify on completion.
```

### Weekly Batch

```
Generate 50 videos for next week (Mon-Fri, 10/day)

Research topics:
- PRODUCT/ for accurate science
- MARKETING/RAG/ for FAQs
- COMPETITIVEANALYSIS/ for differentiation

Distribution per day:
- Monday: Educational focus
- Tuesday: Mythbusting focus
- Wednesday: QuickTips focus
- Thursday: Trending formats
- Friday: Mixed variety

Create 5 CSV files:
- monday-YYYY-MM-DD.csv (10 videos)
- tuesday-YYYY-MM-DD.csv (10 videos)
- wednesday-YYYY-MM-DD.csv (10 videos)
- thursday-YYYY-MM-DD.csv (10 videos)
- friday-YYYY-MM-DD.csv (10 videos)

All in Mexican Spanish, informal tú tone.

Run in background. Render each batch when complete.
```

### A/B Testing Batch

```
Generate 2 versions of same content for A/B testing

Batch A - Formal Approach:
- More scientific language
- Data-driven hooks
- Professional tone
- Save to: videos-test-a-YYYY-MM-DD.csv

Batch B - Casual Approach:
- Conversational language
- Relatable hooks
- Friendly tone
- Save to: videos-test-b-YYYY-MM-DD.csv

Same 10 video topics, different approaches.

Render both:
CSV_FILE=src/data/videos-test-a-YYYY-MM-DD.csv OUTPUT_DIR=out/test-a npm run render
CSV_FILE=src/data/videos-test-b-YYYY-MM-DD.csv OUTPUT_DIR=out/test-b npm run render
```

### Campaign-Specific

```
Generate launch campaign for new flavor: [Flavor Name]

Campaign: 20 videos over 2 weeks

Week 1 - Teaser (10 videos):
- Build anticipation
- Hint at flavor
- Generate curiosity
- Save to: campaign-launch-week1-YYYY-MM-DD.csv

Week 2 - Reveal (10 videos):
- Announce flavor
- Show product
- Benefits focus
- Drive to purchase
- Save to: campaign-launch-week2-YYYY-MM-DD.csv

Language: Mexican Spanish
Theme: [campaign theme]

Research: PRODUCT/ for new flavor details
Render both batches when complete.
```

## Advanced Integration

### With TikTok Testing Workflow

Integrate into existing workflow from `claude_code_task_workflows.md`:

**Enhanced Phase 1:**
```
TASK: Generate and render 10 TikTok test videos

TESTING GOALS:
- Test different hooks (question vs statement)
- Test different video lengths (15s, 30s, 60s)
- Test different formats (educational, mythbusting, tips, trending)

PROCESS:
1. Generate CSV with testing variations
2. Mark each video with testing hypothesis
3. Render all videos
4. Output ready for upload and tracking

TESTING METADATA:
Include in title or filename:
- Hook type (Q for question, S for statement)
- Video length (15/30/60)
- Format abbreviation (ED/MB/QT/TR)

Example filenames:
- 1-Q-30-ED-magnesium-benefits.mp4
- 2-S-15-QT-pre-workout-tip.mp4

Save CSV to: video-generation/src/data/testing-YYYY-MM-DD.csv
Render and report completion.
```

### With Content Calendar

```
TASK: Generate month's video content based on calendar

Read content calendar from: MARKETING/content-calendar-YYYY-MM.md

For each week:
- Generate CSV matching weekly theme
- 10 videos per week = 4 CSVs
- All aligned with monthly campaign

Output:
- week1-YYYY-MM-DD.csv
- week2-YYYY-MM-DD.csv
- week3-YYYY-MM-DD.csv
- week4-YYYY-MM-DD.csv

Render all 4 batches in parallel.
Total: 40 videos for the month.
```

### With Performance Data

```
TASK: Generate videos based on last week's top performers

ANALYSIS:
1. Read: MARKETING/SOCIAL-MEDIA/tiktok/testing/engagement-tracking-YYYY-MM.md
2. Identify top 5 performing videos
3. Analyze what made them successful:
   - Hook style
   - Topic
   - Format
   - Length
   - Tone

GENERATION:
Create 10 new videos using insights:
- Apply winning hook style to new topics
- Use successful format patterns
- Match optimal video length
- Maintain engaging tone

Save to: videos-optimized-YYYY-MM-DD.csv
Render and track as new test batch.
```

## Monitoring Progress

### Check Task Status

```
/tasks
```

Shows all running background tasks including video generation and rendering.

### View Output

After task completes, videos are in:
```
video-generation/out/
```

Each video named:
```
{id}-{title-slug}.mp4
```

### Review Generated CSV

Before rendering (if using 2-step method):
```
cat video-generation/src/data/videos-mx-YYYY-MM-DD.csv
```

Or open in your editor for review.

## Error Handling

### If CSV Generation Fails

```
TASK: Fix and regenerate CSV

Previous attempt failed. Review requirements:
- All required columns must be present
- Use | (pipe) to separate list items
- No commas in content (breaks CSV)
- Proper escaping of quotes
- Type must be: Educational, Mythbusting, QuickTip, or Trending

Regenerate CSV with corrections.
```

### If Rendering Fails

```
TASK: Debug rendering issue

Error occurred during render. Troubleshoot:
1. Verify FFmpeg is installed (ffmpeg -version)
2. Check CSV format validity
3. Verify all required fields present
4. Try rendering single video first
5. Check available memory (reduce CONCURRENCY if needed)

Report findings and retry.
```

## Best Practices

### 1. Research First

Always instruct Claude to research before generating:
```
Research from:
- PRODUCT/ for accurate science
- MARKETING/RAG/faq.json for common questions
- COMPETITIVEANALYSIS/ for positioning
```

### 2. Specify Language Clearly

For Mexican market:
```
Language: Mexican Spanish (not Spain Spanish)
Tone: Informal tú (not vos or usted)
Cultural references: Mexican climate, sports, lifestyle
```

### 3. Test Before Scale

Generate 2-3 videos first, verify output, then scale:
```
First generate 3 test videos, render, review.
If satisfactory, then generate full batch of 10.
```

### 4. Use Descriptive Filenames

Include metadata in CSV filenames:
```
videos-mx-educational-2026-01-23.csv
videos-mx-mythbusting-2026-01-23.csv
videos-mx-testing-batch-a-2026-01-23.csv
```

### 5. Track Everything

Always save:
- CSV files (for reference)
- Rendering logs
- Performance data
- Winning formulas

## Example Complete Workflow

```
========================================
COMPLETE VIDEO GENERATION WORKFLOW
========================================

Morning (9:00 AM):
------------------
Claude Task 1: Research & Generate
- Research PRODUCT/ and MARKETING/RAG/
- Generate 10 video scripts (CSV)
- Save to: videos-mx-2026-01-23.csv

Claude Task 2: Render
- Execute: npm run render
- Output to: out/

Total time: 45 minutes
Result: 10 videos ready

Afternoon (2:00 PM):
-------------------
Manual: Review & Upload
- Review rendered videos (15 min)
- Upload to TikTok (30 min)
- Set up tracking spreadsheet (10 min)

Total time: 55 minutes

Evening (8:00 PM):
-----------------
Claude Task 3: Track Initial Performance
- Record first 6-hour metrics
- Note early engagement patterns

Next Day (9:00 AM):
------------------
Claude Task 4: Analyze & Plan
- Review 24-hour performance
- Identify top 3 performers
- Generate today's batch based on insights

Total daily time: ~2 hours
Output: 10 videos/day
========================================
```

## Automation Level

### Level 1: Semi-Automated (Current)
- Claude generates CSV
- Manual review
- Claude renders
- Manual upload

### Level 2: Mostly Automated (Recommended)
- Claude generates + renders in one task
- Manual review of output videos only
- Manual upload
- Claude tracks performance

### Level 3: Fully Automated (Advanced)
- Claude generates + renders
- Automatic upload (via TikTok API)
- Automatic performance tracking
- Daily optimization reports

Current setup supports **Level 1 & 2**. Level 3 requires TikTok API integration.

## Next Steps

1. Test the integration:
   ```
   Generate 3 test videos and render them
   ```

2. Scale to daily production:
   ```
   Generate 10 videos daily for one week
   ```

3. Implement testing workflow:
   ```
   Use TikTok testing workflow from claude_code_task_workflows.md
   ```

4. Optimize based on data:
   ```
   Weekly analysis and content optimization
   ```

## Resources

- `claude_code_tasks_guide.md` - Tasks overview
- `claude_code_task_templates.md` - Ready templates
- `claude_code_task_workflows.md` - Full workflows
- `MEXICO-GUIDE.md` - Mexican market guide
- `QUICKSTART.md` - Quick reference

---

**Ready to automate video generation! 🚀**

Start with: "Generate 3 test videos for Mexican market"
