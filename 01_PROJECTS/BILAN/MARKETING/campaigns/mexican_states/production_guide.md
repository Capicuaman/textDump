# BILAN Mexican States Campaign - Production Guide

## Overview

This production guide provides step-by-step workflows, quality control checklists, and technical specifications for generating all 32 state videos using VEO (Google's AI video generation platform). This is the operational handbook that should be referenced daily during the 7-week production timeline.

---

## Production Workflow Overview

### Complete Production Pipeline

```
1. Pre-Production (Per Tier)
   ↓
2. VEO Prompt Customization (Per State)
   ↓
3. VEO Generation & Iteration (2-3 attempts per state)
   ↓
4. Quality Control Review
   ↓
5. Post-Production (Text Overlays, Color Grading)
   ↓
6. Platform Optimization & Export
   ↓
7. Distribution & Scheduling
```

**Timeline:**
- Tier 1 (10 states): Weeks 1-3
- Tier 2 (14 states): Weeks 4-5
- Tier 3 (8 states): Weeks 6-7

---

## Phase 1: Pre-Production (1-2 days per tier)

### Checklist

- [ ] Review state research document for all states in current tier
- [ ] Validate landmark selections (cross-reference with local knowledge if possible)
- [ ] Prepare master template with tier-specific customizations
- [ ] Set up VEO 3 API access and test generation capabilities
- [ ] Organize asset library (if using reference images for inspiration)
- [ ] Schedule production time blocks (uninterrupted 2-4 hour sessions)

### Preparation Steps

1. **Open state research document:** `assets/state_research.md`
2. **Review tier states:** Identify all states in current tier (Tier 1: 10, Tier 2: 14, Tier 3: 8)
3. **Create checklist:** Track which states are completed/pending
4. **Set daily goals:** Realistic target is 2-3 state prompts customized + generated per day

---

## Phase 2: VEO Prompt Customization (30-45 min per state)

### Step-by-Step Process

**Step 1: Open Master Template**
- File: `assets/master_template.json`
- Create duplicate: Save as `[number]_[state_name].json` in `/prompts/` directory

**Step 2: Gather State Information**
- Reference: `assets/state_research.md`
- Extract for target state:
  - State name (Spanish)
  - Iconic landmark
  - Animation type
  - Natural surface
  - Lighting specifications
  - Cultural notes

**Step 3: Replace All [PLACEHOLDER] Variables**

Use find-and-replace or manual editing to customize:

- `[STATE_NAME]` → Full state name in English
- `[STATE_NAME_SPANISH]` → Full state name in Spanish
- `[STATE_NUMBER]` → Two-digit number (01-32)
- `[LANDMARK]` → Primary iconic landmark
- `[LANDMARK_KEYWORD]` → Short keyword
- `[LANDSCAPE_TYPE]` → General landscape category
- `[SURFACE_TYPE]` → Natural surface type
- `[FLAVOR_COLOR]` → Choose: pale citrus/pink/deep orange/translucent
- `[TIME_OF_DAY]` → Morning/golden hour/midday
- `[COLOR_TEMP]` → 4600K-5900K range
- `[LIGHTING_QUALITY]` → Descriptive quality
- `[MOOD]` → refreshing/energetic/serene/adventurous
- `[SHOT_TYPE]` → Medium shot/Close-up
- `[MOVEMENT]` → Static OR subtle slow push-in
- `[ANIMATION_DESCRIPTION]` → Full narrative of motion
- `[SPECIFIC_MOTION]` → Precise animation description
- `[MOTION_KEYWORD]` → Short motion keyword
- `[FRAME_RATE]` → 120fps OR 24fps
- `[NEIGHBORING_STATE_1]` → First neighboring state
- `[NEIGHBORING_STATE_2]` → Second neighboring state
- `[CULTURAL_RESONANCE]` → Why landmark matters

**Step 4: Write Full Description (150-300 words)**

**Template Structure:**
1. Opening: Establish scene with BILAN product on natural surface
2. Middle: Describe state landmark in background with animation
3. Details: Lighting, environment, subtle motion
4. Closing: Final frame state and mood

**Example (Quintana Roo):**
> "A serene medium shot of a BILAN kraft paper bag (beige with blue accent band, logo clearly visible) and a crystal-clear glass filled with pale citrus-colored electrolyte drink resting on white limestone rock at the edge of a turquoise cenote in Quintana Roo. The product occupies the lower 25% of the vertical 9:16 frame, sharp and prominently featured. Behind it, the iconic cenote's crystal-clear turquoise water stretches across the background in soft focus, surrounded by limestone walls and lush jungle foliage. Throughout the 8-second shot, gentle concentric ripples expand slowly across the cenote's glassy surface, originating from the center and radiating outward. Palm fronds at the edges of the frame sway rhythmically in the Caribbean breeze. Shafts of midday sunlight (5700K) penetrate the cenote opening, creating dramatic light patterns that dance subtly on the water surface and illuminate suspended water particles. The BILAN product remains perfectly static and sharp while the background cenote comes alive with subtle, meditative motion. The scene feels serene, refreshing, and deeply connected to Quintana Roo's cenote culture. The final frame holds this balance: product crisp and inviting, cenote water continuing its gentle rippling, sunlight still filtering through jungle canopy."

**Step 5: Complete Elements Array (7-9 items)**

List all specific visual components:
1. BILAN kraft paper bag (full description)
2. Glass with drink (specify color)
3. BILAN powder (visible)
4. Natural surface (state-appropriate)
5. Condensation on glass
6-9. State landmark elements (3-4 specific details)

**Step 6: Write Motion Description (5-8 seconds)**

**Structure:**
- Opening statement: BILAN product remains static/sharp
- Background motion: Detailed description of landmark animation
- Additional motion: Secondary elements (if applicable)
- Frame rate specification
- Emphasis on subtlety

**Step 7: Verify Keywords (12-18 keywords)**

Ensure includes:
- Core keywords (9:16, Mexico, electrolytes, BILAN, etc.)
- State name
- Landmark keyword
- Landscape type
- Motion keyword

**Step 8: Complete Regional Targeting Section**

- Primary market: State name
- Secondary markets: 2 neighboring states
- Cultural notes: 2-3 sentences on landmark significance

**Step 9: Final Review**

- [ ] All placeholders replaced
- [ ] Description is 150-300 words
- [ ] Elements list has 7-9 items
- [ ] Motion description is detailed and specific
- [ ] Keywords include state and landmark
- [ ] File saved with correct naming: `[number]_[state_name].json`

---

## Phase 3: VEO Generation & Iteration (1-2 hours per state)

### VEO 3 Generation Process

**Step 1: Access VEO Platform**
- Navigate to Google Veo 3 interface or API
- Authenticate credentials
- Verify API credits/budget available

**Step 2: Input Prompt**

**Use the "description" field as primary prompt:**
- Copy full 150-300 word description from JSON file
- VEO 3 excels with narrative, detailed prompts
- Do NOT include JSON structure, only description text

**Optional: Include style guidance:**
- Add style keywords: "photorealistic, clean aesthetic, natural, 9:16 vertical"
- Specify duration: "5-8 seconds"
- Mention frame rate if slow motion: "120fps slow motion"

**Step 3: Set Technical Parameters**

**VEO 3 Settings:**
- **Resolution:** 1080x1920 (9:16 vertical)
- **Duration:** 8 seconds (allows flexibility for editing to 5-7s)
- **Frame Rate:** 24fps or 30fps (VEO handles slow motion internally if specified in prompt)
- **Quality:** Highest available setting
- **Aspect Ratio:** 9:16 (critical - do NOT use 16:9)
- **Style:** Photorealistic

**Step 4: Generate Video**

- Click "Generate" or submit API request
- Typical generation time: 3-10 minutes depending on complexity
- Monitor progress if platform provides real-time updates

**Step 5: Review First Generation**

**Immediate Quality Check:**
- [ ] Video is vertical 9:16 format (not cropped)
- [ ] BILAN logo clearly visible and legible
- [ ] Product in lower 20-30% of frame
- [ ] Negative space at top (30-35%)
- [ ] State landmark recognizable in background
- [ ] Animation present and subtle (not aggressive)
- [ ] Photorealistic aesthetic maintained
- [ ] Duration approximately 5-8 seconds

**Common Issues & Solutions:**

| Issue | Solution |
|-------|----------|
| Logo not visible/blurry | Regenerate with "BILAN logo clearly visible and legible" emphasized in prompt |
| Product positioning wrong | Adjust prompt: "Product in lower 20-30% of vertical frame" |
| Animation too aggressive | Reduce motion intensity keywords: "very subtle" instead of "dynamic" |
| Animation not visible | Increase motion keywords: "clearly visible gentle rippling" |
| Landmark not recognizable | Make landmark description more specific and prominent |
| Wrong aspect ratio | Verify VEO settings are 9:16, regenerate |
| Lighting too harsh/soft | Adjust lighting keywords in prompt (more specific color temperature) |

**Step 6: Decide on Iteration**

**When to Accept First Generation:**
- All quality checklist items pass
- Product and landmark both look excellent
- Animation subtle but visible
- Overall aesthetic on-brand

**When to Iterate (Generate Again):**
- Logo not legible
- Product positioning significantly off
- Animation missing or too aggressive
- Landmark not recognizable
- Lighting drastically wrong
- Technical issues (wrong aspect ratio, artifacts)

**Iteration Strategy:**
- **Attempt 2:** Adjust prompt based on first generation issues
- **Attempt 3:** If still not satisfactory, consider alternative wording or reference images
- **Maximum:** 3 attempts per state (budget constraint)
- **If all 3 fail:** Flag for review, potentially select best of 3 and proceed

---

## Phase 4: Quality Control Review (15 min per video)

### Comprehensive Quality Checklist

Print or reference this checklist for EVERY video before approval:

#### Visual Quality (Product)

- [ ] **BILAN logo clearly visible and legible** (can read "BILAN" without squinting)
- [ ] **Product positioned in 20-30% of lower-middle frame** (use grid overlay to verify)
- [ ] **Kraft paper bag color accurate** (beige/tan with blue accent)
- [ ] **Glass filled with electrolyte drink** (appropriate flavor color)
- [ ] **Condensation visible on glass** (shows cold/refreshing)
- [ ] **Product remains sharp and static** throughout video (no unwanted movement)
- [ ] **Natural surface appropriate to state** (driftwood for coast, rock for mountains, etc.)

#### Visual Quality (Background)

- [ ] **State landmark recognizable** (even in soft focus)
- [ ] **Landmark in soft focus but not blurred beyond recognition**
- [ ] **Background doesn't overpower product** (viewer's eye goes to product first)
- [ ] **Natural environment authentic to state** (desert for Sonora, jungle for Chiapas, etc.)

#### Animation Quality

- [ ] **Subtle animation present** (motion is visible but gentle)
- [ ] **Animation appropriate to environment** (water ripples for cenote, heat shimmer for desert, etc.)
- [ ] **Motion doesn't distract from product** (enhances scene without competing)
- [ ] **Animation feels natural** (not artificial or overly CGI)
- [ ] **Loop-ability** (video can seamlessly loop for social media)

#### Technical Quality

- [ ] **Vertical 9:16 format** (NOT cropped from 16:9)
- [ ] **Resolution 1080x1920 or higher**
- [ ] **Duration 5-8 seconds** (ideal for social media)
- [ ] **No visual artifacts** (glitches, pixelation, weird distortions)
- [ ] **Smooth playback** (no stuttering or frame drops)
- [ ] **File format compatible** (MP4 or MOV for editing)

#### Compositional Quality

- [ ] **30-35% negative space at top** (room for text overlays)
- [ ] **Balanced composition** (product doesn't feel cramped or lost)
- [ ] **Rule of thirds considered** (product positioned effectively)
- [ ] **Depth perception clear** (foreground product distinct from background)

#### Lighting Quality

- [ ] **Natural lighting** (not artificial/studio look)
- [ ] **Color temperature appropriate** (5000K-5500K range for most, warmer for golden hour)
- [ ] **Lighting matches state climate** (bright for desert, dappled for jungle, etc.)
- [ ] **Soft shadows** (not harsh or artificial)
- [ ] **Product well-lit** (inviting and visible)

#### Brand Consistency

- [ ] **Photorealistic aesthetic** (not cartoon, illustration, or overly stylized)
- [ ] **Clean and minimalist** (not cluttered or busy)
- [ ] **On-brand mood** (refreshing, natural, aspirational)
- [ ] **Consistent with other state videos** (visual cohesion across campaign)

### Quality Score System

**Scoring (10 points total):**
- Product Quality: 3 points (logo visible, positioned correctly, sharp/static)
- Background Quality: 2 points (landmark recognizable, appropriate to state)
- Animation Quality: 2 points (subtle, visible, natural)
- Technical Quality: 2 points (9:16 format, no artifacts, proper duration)
- Compositional Quality: 1 point (negative space, balance, depth)

**Accept Criteria:**
- **9-10 points:** EXCELLENT - Approve immediately
- **7-8 points:** GOOD - Approve with minor notes
- **5-6 points:** ACCEPTABLE - Consider iteration if budget allows
- **Below 5:** REJECT - Must iterate or regenerate

### Visual Style Guide Reference

**Create visual style guide after first 3 approved videos:**
1. Screenshot best frame from each video
2. Annotate with key success factors
3. Use as reference for remaining 29 states
4. Ensures visual consistency across campaign

---

## Phase 5: Post-Production (30-45 min per video)

### Required Post-Production Steps

#### 1. Text Overlay Design (Spanish)

**Tools:** Adobe Premiere Pro, After Effects, CapCut, DaVinci Resolve, or Canva

**Text Elements to Add:**

**Top Section (First 2 seconds):**
- **State Name:** Large, elegant sans-serif font (Montserrat, Raleway, or similar)
  - Position: Top 15% of frame
  - Size: 48-60pt
  - Color: White or cream (#FFFFFF or #F8F8F8)
  - Effect: Subtle drop shadow for readability
  - Animation: Fade in over 0.5s, hold, fade out at 6s

**Middle Section (Throughout):**
- **"BILAN Electrolitos Naturales":** Below state name
  - Position: 20-25% from top
  - Size: 28-36pt
  - Color: White or light blue (#E8F4F8)
  - Animation: Fade in after state name (1s), stays visible

**Bottom Section (Last 2 seconds):**
- **CTA:** "Descubre BILAN en [State]" or "Disponible en [State]"
  - Position: Bottom 15% of frame (above product)
  - Size: 32-40pt
  - Color: White with blue accent
  - Animation: Slide up at 6s, fade out at 8s

- **Website/Social:** "www.bilanco.com | @bilanco"
  - Position: Bottom 5% (corner)
  - Size: 18-24pt
  - Color: White semi-transparent
  - Always visible

**Design Specifications:**
- Font: Sans-serif, legible, modern (avoid decorative fonts)
- Color Palette: White, cream, light blue (matches BILAN brand)
- Shadows: Subtle drop shadow for readability over video
- Kerning: Proper spacing for Spanish characters (accents)
- Alignment: Centered or left-aligned based on composition

**Template Approach:**
- Create reusable After Effects or CapCut template
- Variables: State name, CTA text
- Apply to all 32 videos for consistency

#### 2. Color Grading (15-20 min per video)

**Objectives:**
- Ensure visual consistency across all 32 state videos
- Match BILAN brand color palette (natural, clean, slightly warm)
- Enhance product visibility without over-saturation

**Color Grading Steps:**

1. **White Balance Correction:**
   - Ensure whites look natural (not blue or yellow)
   - Product bag should be beige/tan, not gray or orange

2. **Contrast Adjustment:**
   - Increase contrast slightly to make product "pop"
   - Avoid crushing shadows or blowing out highlights

3. **Saturation:**
   - Slight saturation boost for electrolyte drink color
   - Keep natural environment colors authentic (don't over-saturate greens/blues)

4. **Color Temperature:**
   - Add slight warmth (+50-100K) for inviting feel
   - Desert states can be warmer, mountain states cooler

5. **Vignette (Optional):**
   - Very subtle vignette to draw eye to center (product)
   - Strength: 5-10% maximum

**Tools:**
- DaVinci Resolve (professional, free version available)
- Adobe Premiere Pro (Lumetri Color panel)
- CapCut (basic color grading tools)

**Consistency Approach:**
- Export LUT (Look-Up Table) from first approved video
- Apply same LUT to all subsequent videos
- Make minor adjustments per state as needed

#### 3. Sound Design (Optional but Recommended)

**Objective:** Add subtle environmental audio to enhance scene authenticity

**Sound Elements to Consider:**

**Coastal States:**
- Gentle ocean waves lapping
- Light seagull calls (distant)
- Soft beach wind

**Desert States:**
- Light wind whistling
- Occasional desert bird
- Silence with ambient tone

**Jungle States:**
- Tropical birds chirping
- Light rain (if applicable)
- Jungle ambience

**Mountain States:**
- Wind through pine trees
- Distant bird calls
- Mountain stream (if water feature)

**Cenote/Water States:**
- Water droplets
- Light echo effect
- Underwater ambience

**Volume Levels:**
- Background ambience: -18 to -24 dB (very subtle)
- Do NOT overpower with sound (video is primarily visual)
- Ensure music beds can be added later without conflict

**Sources:**
- Free: Freesound.org, YouTube Audio Library, Pixabay Audio
- Paid: Epidemic Sound, Artlist, AudioJungle

#### 4. Export Settings

**Primary Export (Instagram, TikTok, YouTube Shorts):**
- **Resolution:** 1080x1920 (9:16 vertical)
- **Frame Rate:** 30fps
- **Codec:** H.264
- **Bitrate:** 15-20 Mbps (High quality)
- **Audio:** AAC, 192 kbps, 48kHz (if sound added)
- **Format:** MP4
- **File Size Target:** 10-25 MB (5-8 second video)

**Secondary Export (High-Res Archive):**
- **Resolution:** 2160x3840 (4K vertical) if VEO generated at this resolution
- **Frame Rate:** 30fps
- **Codec:** H.265 (HEVC) for better compression
- **Bitrate:** 40-50 Mbps
- **Format:** MP4 or MOV
- **Purpose:** Archive for future use, paid ads requiring high quality

**Platform-Specific Optimizations:**

**Instagram Reels:**
- Resolution: 1080x1920
- Aspect Ratio: 9:16
- Max Duration: 90s (our videos are 5-8s, well within limit)
- File Size: Under 250 MB (we'll be under 25 MB)
- Frame Rate: 23-30fps

**TikTok:**
- Resolution: 1080x1920 (recommended), minimum 720x1280
- Aspect Ratio: 9:16
- Max Duration: 10 minutes (our videos 5-8s)
- File Size: Under 287.6 MB (Android), 72 MB (iOS)
- Frame Rate: 23-60fps

**YouTube Shorts:**
- Resolution: 1080x1920 (recommended)
- Aspect Ratio: 9:16
- Max Duration: 60 seconds
- File Size: Under 256 GB (not a concern for us)
- Frame Rate: 24, 25, 30, 48, 50, 60fps

**File Naming Convention:**
- Format: `BILAN_MX_[STATE_NUMBER]_[STATE_NAME]_9x16_final.mp4`
- Example: `BILAN_MX_09_quintana_roo_9x16_final.mp4`

---

## Phase 6: Platform Optimization & Scheduling (15 min per video)

### Upload & Metadata Preparation

#### Instagram Reels

**Upload Process:**
1. Transfer video to mobile device or use Creator Studio
2. Upload to Instagram as Reel
3. Add caption (see below)
4. Add hashtags (see campaign strategy)
5. Tag location (state-specific)
6. Schedule or post immediately

**Caption Template:**
```
✨ [STATE_NAME_SPANISH] Natural Hydration ✨

Hidratación natural con los paisajes más bellos de México.

[LANDMARK] + BILAN = La combinación perfecta para tu día activo.

💧 Electrolitos naturales
🌿 Sin azúcar añadido
🏔️ Inspirado en la naturaleza de [STATE]

Disponible en www.bilanco.com

#BILAN[StateName] #HidrataciónNatural #ElectrolitosNaturales
[Additional state-specific hashtags]
```

**Geotag:** Use most prominent city in state or landmark location

#### TikTok

**Upload Process:**
1. Transfer video to mobile device or use desktop uploader
2. Upload to TikTok
3. Add caption (shorter than Instagram)
4. Add hashtags
5. Select cover frame (product clearly visible)
6. Enable comments, duets, stitches
7. Schedule or post

**Caption Template:**
```
[STATE_NAME_SPANISH] 💧✨

¿Reconoces este lugar?

BILAN - Hidratación Natural de México

#BILAN[StateName] #HidrataciónNatural #[StateName]
```

**Hashtag Strategy:**
- Mix of branded, regional, and trending hashtags
- Max 5-8 hashtags for TikTok (less is more)

#### YouTube Shorts

**Upload Process:**
1. Upload via YouTube Studio (desktop or mobile)
2. Title video appropriately
3. Write description with keywords
4. Add hashtags
5. Select thumbnail (first frame with product visible)
6. Schedule or publish

**Title Template:**
```
BILAN Hidratación Natural - [STATE_NAME_SPANISH] [LANDMARK] #Shorts
```

**Description Template:**
```
Descubre BILAN en [STATE_NAME_SPANISH] con los paisajes más impresionantes de México.

[LANDMARK] es uno de los tesoros naturales de [STATE]. Combinamos la belleza natural de México con hidratación científica para crear la experiencia BILAN.

🌿 Electrolitos Naturales
💧 Sin Azúcar Añadido
🏔️ Inspirado en la Naturaleza Mexicana

Disponible en: www.bilanco.com

#BILAN #HidrataciónNatural #ElectrolitosNaturales #[StateName] #Mexico #Hidratacion #SaludNatural
```

**SEO Keywords:** "[State] natural hydration," "[State] electrolytes," "BILAN [State]"

### Content Scheduling Strategy

**Posting Cadence:**
- **Week 1 (Tier 1 Launch):** 2-3 posts per day
- **Week 2-3 (Tier 1 Amplification):** 1-2 posts per day
- **Week 4-5 (Tier 2 Launch):** 2-3 posts per day
- **Week 6-7 (Tier 3 Launch):** 1-2 posts per day

**Best Posting Times (Mexico):**
- Instagram: 11am-1pm, 7pm-9pm
- TikTok: 6am-9am, 12pm-3pm, 7pm-11pm
- YouTube: 2pm-4pm, 8pm-11pm

**Scheduling Tools:**
- Buffer (all platforms)
- Later (Instagram, TikTok)
- Hootsuite (all platforms)
- Meta Business Suite (Instagram/Facebook)
- TikTok Creator Tools (native scheduling)

---

## Iteration Guidelines

### When to Iterate vs. Accept

**Accept Video If:**
- Quality score: 7+/10
- No critical issues (logo visible, 9:16 format correct)
- Timeline pressure (Tier 1 launch approaching)
- Budget constraints (already 2 attempts)

**Iterate Video If:**
- Quality score: Below 7/10
- Critical issues present (wrong aspect ratio, logo not visible)
- Landmark not recognizable
- Budget allows (under 3 attempts)

### Prompt Adjustment Strategies

**Issue:** Logo not visible or blurry
**Solution:** Add to prompt: "The BILAN logo on the kraft paper bag is large, clear, and facing the camera directly. Logo is sharp and easily readable."

**Issue:** Animation too aggressive/distracting
**Solution:** Add: "very subtle," "barely perceptible," "gentle," "meditative." Remove: "dramatic," "dynamic," "powerful."

**Issue:** Animation not visible at all
**Solution:** Add: "clearly visible," "noticeable," emphasize motion keywords (e.g., "water ripples are visible and expand across surface").

**Issue:** Product positioning off
**Solution:** Add: "The BILAN bag and glass are positioned in the lower 25% of the vertical frame, with the top 35% of the frame completely empty for text overlays."

**Issue:** Landmark not recognizable
**Solution:** Make landmark description more specific and prominent. Example: "Behind the product, the distinctive turquoise water of a Quintana Roo cenote is clearly visible with limestone walls and jungle foliage surrounding it."

**Issue:** Lighting too harsh or too soft
**Solution:** Specify color temperature more precisely ("5400K natural daylight") and add quality descriptors ("soft but clear," "bright without harshness").

### Learning from Each Generation

**Document What Works:**
- Keep spreadsheet tracking each state's generation attempts
- Note which prompt wordings produce best results
- Identify patterns (e.g., "certain lighting descriptions work better")
- Build prompt refinement guide for remaining states

**Example Tracking Spreadsheet:**

| State | Attempt | Issues | Adjustments Made | Result | Score |
|-------|---------|--------|------------------|--------|-------|
| Quintana Roo | 1 | Logo slightly blurry | Emphasized "BILAN logo sharp and legible" | Accept | 8/10 |
| Jalisco | 1 | Animation too subtle | Added "clearly visible mist drifting" | Iterate | 6/10 |
| Jalisco | 2 | Perfect | N/A | Accept | 9/10 |

---

## Time Management

### Realistic Daily Production Goals

**Day 1 (Tier Start):**
- Morning: Customize 3 state prompts (1.5 hours)
- Afternoon: Generate 3 state videos (2 hours including wait time)
- Evening: QC review 3 videos (45 min)
- **Output:** 3 states prompts created, 3 videos generated

**Day 2:**
- Morning: Post-production on 3 videos from Day 1 (2 hours)
- Afternoon: Customize + generate 3 more states (3.5 hours)
- **Output:** 3 videos completed, 3 more in QC

**Day 3:**
- Morning: Post-production on Day 2 videos (2 hours)
- Afternoon: Iterate any failed videos, customize + generate 2 more states (3 hours)
- **Output:** 3 videos completed, 2 in QC, iterations resolved

**Weekly Pace (5 work days):**
- 10-15 states completed from prompt to final video
- Allows for iterations and quality issues
- Tier 1 (10 states): Completed in Week 1 comfortably

### Buffer Time

**Build in buffer for:**
- VEO platform downtime or slow generation
- More iterations than expected
- Client approval delays
- Unexpected quality issues

**Recommended:**
- Add 20% time buffer to each tier
- Don't schedule launches until content is 100% done
- Have backup plan if VEO platform has issues

---

## Troubleshooting Common Issues

### Technical Issues

**Issue:** VEO generates wrong aspect ratio (16:9 instead of 9:16)
**Solution:** Double-check VEO settings before generation. Explicitly state "vertical 9:16 format" in prompt. If persists, contact VEO support.

**Issue:** Video has visual artifacts (glitches, pixelation)
**Solution:** Regenerate with higher quality settings. Simplify prompt if too complex. Check if issue is VEO-side or export-side.

**Issue:** File size too large for platform upload
**Solution:** Re-export with slightly lower bitrate (12-15 Mbps). Use H.265 codec for better compression. Trim unnecessary frames.

**Issue:** Video won't upload to platform
**Solution:** Check file format (MP4 most compatible). Verify resolution and aspect ratio. Try converting with Handbrake or similar tool.

### Creative Issues

**Issue:** Video looks generic, not specific to state
**Solution:** Make landmark more prominent in prompt. Add more specific environmental details. Reference state research document more closely.

**Issue:** Video doesn't match BILAN brand aesthetic
**Solution:** Emphasize "photorealistic, clean aesthetic, natural lighting" in prompt. Adjust color grading in post-production. Reference first approved videos for consistency.

**Issue:** Product doesn't look appealing
**Solution:** Adjust lighting description to be more flattering. Ensure condensation is visible on glass. Add "inviting" and "refreshing" descriptors.

**Issue:** Background overpowers product
**Solution:** Emphasize "shallow depth of field, background in soft focus" in prompt. Darken background slightly in color grading.

### Workflow Issues

**Issue:** Falling behind schedule
**Solution:** Focus on Tier 1 priority. Reduce iterations to 2 attempts max. Simplify post-production (skip sound design if needed).

**Issue:** Inconsistency across videos
**Solution:** Create visual style guide from first 3 approved videos. Apply same color grading LUT to all. Review side-by-side regularly.

**Issue:** Client/stakeholder wants changes after approval
**Solution:** Set clear approval process upfront. Limit revision rounds. Track changes carefully.

---

## Quality Assurance Final Checklist

Before marking any state as "complete," verify:

### Pre-Distribution Checklist

- [ ] Video passes all quality control checks (score 7+/10)
- [ ] Spanish text overlays added correctly (state name, BILAN branding, CTA)
- [ ] Color grading applied for consistency
- [ ] Exported in correct format (1080x1920, 9:16, MP4)
- [ ] File named correctly: `BILAN_MX_[##]_[state]_9x16_final.mp4`
- [ ] Backed up to cloud storage and external drive
- [ ] High-res archive version saved (if applicable)
- [ ] Captions written for all platforms
- [ ] Hashtags prepared
- [ ] Location tags identified
- [ ] Scheduling time selected (optimal posting time)
- [ ] UTM tracking links prepared (for Instagram bio, TikTok bio)
- [ ] Influencer seeding list prepared (if applicable for this state)
- [ ] Marked as complete in production tracker spreadsheet

### Cross-State Consistency Check

Every 5 videos, review all completed videos side-by-side:

- [ ] Visual style consistent (lighting, color grading, composition)
- [ ] Product positioning identical across all videos
- [ ] Text overlay style and timing consistent
- [ ] Animation subtlety level similar
- [ ] Brand aesthetic maintained

---

## Post-Production Assets Organization

### File Structure

```
generated_videos/
├── tier_1_priority/
│   ├── raw_veo_exports/
│   │   ├── BILAN_MX_01_aguascalientes_raw.mp4
│   │   ├── BILAN_MX_09_quintana_roo_raw.mp4
│   │   └── ...
│   ├── final_exports/
│   │   ├── BILAN_MX_01_aguascalientes_9x16_final.mp4
│   │   ├── BILAN_MX_09_quintana_roo_9x16_final.mp4
│   │   └── ...
│   └── high_res_archive/
│       ├── BILAN_MX_01_aguascalientes_4K.mp4
│       └── ...
├── tier_2_standard/
│   └── [same structure]
└── tier_3_niche/
    └── [same structure]
```

### Backup Strategy

**Local Backups:**
- External SSD or HDD
- Update after each day's work

**Cloud Backups:**
- Google Drive, Dropbox, or OneDrive
- Upload final videos immediately
- Redundancy for raw VEO exports

**Archive:**
- Keep all raw VEO exports for potential future use
- Maintain project files (After Effects, Premiere, etc.) for easy updates

---

## Tools & Resources

### Required Tools

**Video Generation:**
- Google VEO 3 platform access
- API credits or subscription

**Video Editing:**
- Adobe Premiere Pro (professional) OR
- DaVinci Resolve (free, professional-grade) OR
- CapCut (beginner-friendly, free)

**Motion Graphics/Text:**
- Adobe After Effects (professional) OR
- CapCut (built-in text tools)

**Color Grading:**
- DaVinci Resolve (industry standard, free)
- Adobe Premiere Pro (Lumetri Color)

**File Management:**
- Google Drive / Dropbox (cloud storage)
- External hard drive (local backup)

**Scheduling:**
- Buffer / Later / Hootsuite

### Optional Tools

**Sound Design:**
- Adobe Audition
- Audacity (free)

**Thumbnail Creation:**
- Adobe Photoshop
- Canva (free)

**Project Management:**
- Notion, Trello, or Asana (tracking production progress)
- Google Sheets (production tracker spreadsheet)

### Resource Library

**Reference Materials:**
- `assets/master_template.json` - Reusable prompt template
- `assets/state_research.md` - All state information
- `campaign_strategy.md` - Distribution and targeting strategy
- Visual style guide - Created from first 3 approved videos

**Stock Assets (if needed):**
- Freesound.org - Environmental sounds
- Pixabay Audio - Background music/ambience
- Free texture libraries (for text overlay backgrounds if needed)

---

## Production Timeline Summary

### Week-by-Week Breakdown

**Week 1: Foundation + Tier 1 Prompts**
- Days 1-2: Customize all 10 Tier 1 state prompts
- Days 3-5: Generate all 10 Tier 1 videos (with iterations)

**Week 2: Tier 1 Post-Production**
- Days 1-3: Post-production on all 10 Tier 1 videos
- Days 4-5: Final QC, export, prepare for launch

**Week 3: Tier 1 Launch + Tier 2 Start**
- Day 1: Launch Tier 1 campaign
- Days 2-5: Begin Tier 2 prompt customization and generation

**Week 4-5: Tier 2 Production**
- Complete generation and post-production for 14 Tier 2 states

**Week 6-7: Tier 3 Production**
- Complete generation and post-production for 8 Tier 3 states
- Campaign wrap-up and final QC

---

## Success Criteria for Production Phase

**Production phase considered successful if:**

1. **Timeline:** All 32 videos completed within 7 weeks
2. **Quality:** Average quality score of 8+/10 across all videos
3. **Consistency:** Visual cohesion maintained (verified by side-by-side review)
4. **Budget:** VEO generation costs within allocated budget
5. **Completeness:** All 32 states have final videos with text overlays, proper export, and platform-ready files

---

**Document Version:** 1.0
**Last Updated:** 2025-12-29
**Status:** Ready for Production Use
**Next Review:** After first 3 videos completed (create visual style guide)
