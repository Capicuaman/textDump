# Claude Code Task Workflows for BILAN

**Purpose:** Specific workflow implementations for common BILAN operations
**Usage:** Step-by-step instructions for executing complex multi-task workflows
**Last Updated:** January 23, 2026

## Table of Contents

1. [TikTok Engagement Testing Workflow](#tiktok-engagement-testing-workflow)
2. [Weekly Content Production Workflow](#weekly-content-production-workflow)
3. [Product Launch Workflow](#product-launch-workflow)
4. [Content Refresh Workflow](#content-refresh-workflow)
5. [Competitive Intelligence Workflow](#competitive-intelligence-workflow)
6. [Multi-Language Campaign Workflow](#multi-language-campaign-workflow)
7. [Blog-to-Social Repurposing Workflow](#blog-to-social-repurposing-workflow)
8. [Customer Research Workflow](#customer-research-workflow)

---

## TikTok Engagement Testing Workflow

### Goal
Post 10 TikTok videos daily to identify best-performing content styles, then repurpose winners across other platforms.

### Why This Works
- **Volume = Data:** 10 posts/day gives significant engagement data
- **Variety testing:** Test different hooks, formats, lengths, topics
- **Fast feedback:** TikTok engagement happens within 24-48 hours
- **Scalable winners:** Proven content can be adapted for Instagram, YouTube Shorts, etc.

### Workflow Steps

#### Phase 1: Generate Daily Content (Background Task)

**Prompt to use:**
```
TASK: Generate 10 TikTok video scripts for testing engagement

DATE: [today's date]
GOAL: Test different content styles to identify what resonates best

CONTENT VARIETY (create 2 of each):
1. Educational - Teach something about electrolytes/hydration
2. Myth-busting - Debunk common hydration myths
3. Before/After - Transformation or improvement stories
4. Quick Tips - 15-second actionable advice
5. Trending Format - Use current TikTok trends/sounds

FOR EACH VIDEO:

SCRIPT ELEMENTS:
- Hook (first 3 seconds): Write 3 variations to test
- Main content (next 10-20 seconds)
- CTA (last 3 seconds)
- Visual directions
- Text overlay suggestions
- Hashtag strategy (15-20 tags, mix of sizes)

TESTING VARIABLES TO VARY:
- Hook style (question / statement / shock value / story)
- Video length (15s / 30s / 45s / 60s)
- Tone (serious / humorous / inspirational / educational)
- Format (talking head / B-roll / animation / demonstration)
- CTA type (comment / follow / visit link / save)

METADATA FOR EACH:
- Primary variable being tested (e.g., "Question hook vs. statement hook")
- Expected audience segment
- Content theme category
- Difficulty level (beginner / intermediate / advanced)

RESEARCH SOURCES:
- General: 01_PROJECTS/BILAN/MARKETING/ 
- Product science: 01_PROJECTS/BILAN/PRODUCT/
- Customer questions: 01_PROJECTS/BILAN/MARKETING/RAG/faq.json
- Trending topics: Current TikTok trends in health/fitness/wellness

OUTPUT STRUCTURE:
Save to: 01_PROJECTS/BILAN/MARKETING/SOCIAL-MEDIA/tiktok/testing/YYYY-MM-DD-batch.md

For each video, include:
1. Video number and title
2. Testing hypothesis (what we're testing)
3. Full script with timestamps
4. Hook variations (3 options)
5. Visual directions
6. Text overlays
7. Hashtags
8. Music/sound suggestions
9. Expected performance indicators

TRACKING SETUP:
Create spreadsheet template at: 01_PROJECTS/BILAN/MARKETING/SOCIAL-MEDIA/tiktok/testing/engagement-tracking-YYYY-MM.md

Columns:
- Date posted
- Video title
- Testing variable
- Hook used
- Length
- Tone
- Format
- Views (24h / 48h / 7d)
- Likes
- Comments
- Shares
- Engagement rate (%)
- Click-through (if applicable)
- Best performing element
- Notes/insights

Run this in background and notify when complete.
```

#### Phase 2: Review and Schedule (Manual)

Once background task completes:
1. Review all 10 scripts
2. Select best hook variation for each
3. Make minor edits if needed
4. Schedule posting times (spread throughout day)

#### Phase 3: Track Performance (Daily Manual Check)

After 24-48 hours:
1. Record engagement metrics in tracking sheet
2. Identify top 3 performers
3. Note what made them successful

#### Phase 4: Analyze and Document (Weekly Background Task)

**Every Sunday, run this prompt:**
```
TASK: Analyze TikTok testing data and document insights

DATA SOURCE: 01_PROJECTS/BILAN/MARKETING/SOCIAL-MEDIA/tiktok/testing/engagement-tracking-YYYY-MM.md

ANALYSIS:
1. **Performance Rankings:**
   - Top 10 videos by engagement rate
   - Bottom 10 videos by engagement rate
   - Average performance by content type
   - Average performance by hook style
   - Average performance by length
   - Average performance by tone
   - Average performance by time posted

2. **Pattern Identification:**
   - Which hooks work best? (question / statement / shock / story)
   - Which topics resonate most?
   - Which video lengths perform better?
   - Which tone gets more engagement?
   - Which CTAs drive action?
   - Which hashtag strategies work?
   - Best posting times?

3. **Audience Insights:**
   - What questions do comments ask?
   - What objections appear?
   - What content do they request?
   - Who's engaging? (demographic patterns if visible)

4. **Content Formula:**
   Based on data, create formula for high-performing content:
   - Optimal hook structure
   - Best content themes
   - Ideal video length
   - Winning tone/style
   - Effective CTAs
   - Hashtag strategy

5. **Recommendations:**
   - What to create more of
   - What to create less of
   - New content ideas based on comments/requests
   - Adjustments to strategy

OUTPUT:
Save to: 01_PROJECTS/BILAN/MARKETING/SOCIAL-MEDIA/tiktok/testing/weekly-analysis-YYYY-MM-DD.md

Include:
- Executive summary (key findings)
- Detailed analysis (all sections above)
- Top 3 videos showcase (what made them work)
- Bottom 3 videos lessons (what to avoid)
- Content formula template
- Next week's strategy adjustments
- Repurposing candidates (mark winners for cross-platform)

Run in background.
```

#### Phase 5: Repurpose Winners (Background Task)

**Run this for each winning video:**
```
TASK: Repurpose high-performing TikTok content for other platforms

SOURCE: [specific TikTok video from top performers]
PERFORMANCE STATS: [views, engagement rate, key metrics]
WHY IT WORKED: [identified success factors]

REPURPOSE FOR:

1. INSTAGRAM REELS
   - Adapt script (slightly longer allowed)
   - Adjust hashtags for Instagram
   - Modify CTA (visit bio vs. comment)
   - Suggest posting caption
   - Timing recommendations

2. YOUTUBE SHORTS
   - Adapt for YouTube audience (slightly different tone)
   - Longer description with keywords
   - Adjust CTAs (subscribe, watch more)
   - Thumbnail text suggestions
   - SEO tags

3. INSTAGRAM FEED POST
   - Convert video concept to static post or carousel
   - Write longer-form caption expanding on concept
   - Hashtag strategy for feed post
   - Comment engagement prompts

4. TWITTER/X
   - Tweet thread based on content (5-7 tweets)
   - Hook tweet to start thread
   - Bite-sized insights in thread
   - Final tweet with CTA

5. LINKEDIN
   - Professional angle on same content
   - Longer-form post (1-2 paragraphs)
   - B2B/professional framing
   - Industry insights tie-in

6. PINTEREST
   - Create pin description
   - Text overlay suggestions for pin graphic
   - Board recommendations
   - Link strategy

7. EMAIL/NEWSLETTER
   - Expand concept into email section
   - Add depth and research
   - Include links to related content
   - CTA appropriate for email

RESEARCH:
- Original TikTok script and performance
- Platform-specific best practices
- Existing brand voice for each platform

OUTPUT:
Save to: 01_PROJECTS/BILAN/MARKETING/SOCIAL-MEDIA/repurposed/[video-title]-multi-platform-YYYY-MM-DD.md

Include:
- Original TikTok details and stats
- Success factor analysis
- Platform-by-platform adaptations
- Content calendar suggestions (when to post each)
- Asset needs (what images/videos/graphics needed)
- Tracking plan (how to measure cross-platform success)

Run in background for each winning video (can run multiple in parallel).
```

### Workflow Timeline

**Daily:**
- Generate 10 TikTok scripts (background task - 15 min)
- Review and post (manual - 30 min)

**Every 48 hours:**
- Record engagement data (manual - 10 min)

**Weekly (Sunday):**
- Analyze week's data (background task - 20 min)
- Review insights (manual - 20 min)
- Identify repurposing candidates (manual - 10 min)

**Weekly (Monday):**
- Repurpose top 3 performers (3 background tasks in parallel - 30 min total)
- Schedule cross-platform content (manual - 20 min)

### Success Metrics

**Track weekly:**
- Average engagement rate (target: improve weekly)
- Best performing content type (document in playbook)
- Audience growth rate
- Click-through rate (if link in bio)

**Track monthly:**
- Engagement rate trend
- Content style evolution
- Cross-platform performance comparison
- ROI (time invested vs. results)

### Documentation Strategy

**Create these files:**
1. `tiktok-testing-playbook.md` - Evolving document of what works
2. `content-formulas.md` - Proven templates for high-performing content
3. `repurposing-guide.md` - How to adapt winning content for each platform
4. `engagement-insights.md` - Audience behavior patterns and preferences

**Update monthly** with new insights from testing.

---

## Weekly Content Production Workflow

### Goal
Produce one week of content across all channels in a single session.

### Workflow Steps

#### Step 1: Planning (Manual - 15 min)

Review:
- Content calendar themes
- Product updates or launches
- Seasonal/trending topics
- Past performance data

Document:
- This week's theme/focus
- Key messages to communicate
- Specific products/topics to highlight
- Any time-sensitive content

#### Step 2: Blog Content (Background Task)

```
TASK: Generate this week's blog posts

TOPICS:
1. [Topic 1 - e.g., "Magnesium Benefits for Sleep"]
2. [Topic 2 - e.g., "Pre-Workout Hydration Guide"]
3. [Topic 3 - e.g., "Electrolyte Myths Debunked"]

FOR EACH:
- 1200-1500 words
- SEO optimized
- Research from PRODUCT/
- Internal links to related posts
- Social media snippets (3 per post)

OUTPUT: BLOG/src/content/blog/

Run in background - spawn 3 parallel agents.
```

#### Step 3: Social Media Content (Background Tasks in Parallel)

**Instagram (Background Task 1):**
```
Generate 7 Instagram posts (one per day) based on this week's theme: [theme]
Save to: MARKETING/SOCIAL-MEDIA/instagram/
```

**TikTok (Background Task 2):**
```
Generate 10 TikTok scripts for testing based on [theme] and recent winners
Save to: MARKETING/SOCIAL-MEDIA/tiktok/
```

**LinkedIn (Background Task 3):**
```
Generate 3 LinkedIn posts (Mon/Wed/Fri) with professional angle on [theme]
Save to: MARKETING/SOCIAL-MEDIA/linkedin/
```

**Twitter (Background Task 4):**
```
Generate 14 tweets (2 per day) - mix of threads and standalone on [theme]
Save to: MARKETING/SOCIAL-MEDIA/twitter/
```

#### Step 4: Email Content (Background Task)

```
Generate this week's email newsletter featuring [theme]
Include: Tip of the week, product highlight, customer story, CTA
Save to: MARKETING/EMAIL/newsletters/
```

#### Step 5: Review and Schedule (Manual - 45 min)

Once all background tasks complete:
1. Review all content for quality and consistency
2. Make edits as needed
3. Schedule/post content
4. Set up tracking

### Timeline

- **Planning:** 15 min
- **Generation (all running in parallel):** 30-45 min
- **Review and schedule:** 45 min
- **Total:** ~90 min for entire week of content

---

## Product Launch Workflow

### Goal
Complete product launch campaign ready to execute.

### Pre-Launch (4 weeks before)

#### Week 1: Strategy and Planning

**Background Task:**
```
TASK: Develop product launch strategy

PRODUCT: [product name]
LAUNCH DATE: [date]

CREATE:
- Campaign overview and objectives
- Target audience definition
- Positioning and messaging
- Channel strategy
- Content calendar (4 weeks)
- Success metrics

RESEARCH: COMPETITIVEANALYSIS/, MARKETING/RAG/, SALES/

OUTPUT: MARKETING/campaigns/launch-[product]/strategy.md
```

#### Week 2: Asset Creation - Part 1

**Run 5 parallel background tasks:**
1. Product page copy (English + Spanish)
2. Blog announcement post
3. FAQ generation (20 questions)
4. Email sequence (4 emails)
5. Press release

#### Week 3: Asset Creation - Part 2

**Run 4 parallel background tasks:**
1. Social media content (Instagram - 14 posts)
2. Social media content (TikTok - 14 scripts)
3. VEO video scripts (5 videos)
4. Influencer outreach kit

#### Week 4: Final Assets

**Run 3 parallel background tasks:**
1. Sales enablement materials
2. Ad copy (various platforms)
3. Launch day toolkit (schedule, checklist, contingencies)

### Launch Week

Execute based on created materials, track performance, adjust in real-time.

### Post-Launch (Week 2-4)

**Background task:**
```
Analyze launch performance, generate report, create case study
Save to: MARKETING/campaigns/launch-[product]/post-mortem.md
```

---

## Content Refresh Workflow

### Goal
Update outdated content systematically.

### Monthly Content Audit (Background Task)

```
TASK: Audit all content from [3 months ago]

CHECK:
- Accuracy vs. current product info
- Broken links
- SEO optimization
- Outdated statistics
- Missing internal links

PRIORITIZE:
- High traffic content (update first)
- Inaccurate content (immediate update)
- SEO opportunities (quick wins)

OUTPUT: Content audit report with action items
```

### Refresh Execution (Multiple Background Tasks)

For each piece flagged:
```
Update [specific piece]
- Fix inaccuracies
- Update stats
- Improve SEO
- Add internal links
- Enhance CTAs
```

Run multiple in parallel based on priority.

---

## Competitive Intelligence Workflow

### Goal
Maintain current competitive intelligence.

### Monthly Competitor Monitoring

**Run 5 parallel background tasks (one per competitor):**

```
TASK: Comprehensive competitor analysis

COMPETITOR: [name]

ANALYZE:
- Product changes
- Pricing updates
- Marketing campaigns
- Social media activity
- Content strategy
- Customer sentiment

OUTPUT: COMPETITIVEANALYSIS/[competitor]-YYYY-MM.md
```

### Synthesis (Background Task)

After individual analyses complete:
```
Synthesize all competitor analyses into strategic insights
- Market trends
- Opportunities
- Threats
- Recommendations

OUTPUT: COMPETITIVEANALYSIS/monthly-synthesis-YYYY-MM.md
```

---

## Multi-Language Campaign Workflow

### Goal
Launch campaign in English and Spanish simultaneously.

### Content Creation (Parallel Background Tasks)

**Run pairs of tasks for each asset:**
- Blog post (EN + ES) - 2 tasks
- Product page (EN + ES) - 2 tasks
- Email sequence (EN + ES) - 2 tasks
- Social media (EN + ES) - 2 tasks

Each language gets its own agent for cultural adaptation, not just translation.

### Review Process

Review both versions together to ensure:
- Message consistency
- Cultural appropriateness
- Equal quality

---

## Blog-to-Social Repurposing Workflow

### Goal
Extract maximum value from blog content.

### Process (Background Task)

```
TASK: Repurpose blog post for all social channels

SOURCE: [blog post URL/path]

CREATE:
- 10 Instagram posts (various formats)
- 10 TikTok scripts
- 1 Instagram carousel (10 slides)
- 5 LinkedIn posts
- 20 Twitter/X tweets (4 threads)
- 1 Pinterest board description + 5 pin descriptions
- 1 YouTube video script (5 min)
- Email newsletter feature

FOR EACH:
- Extract key insights
- Adapt for platform and audience
- Optimize format
- Include CTAs
- Link back to full blog post

OUTPUT: MARKETING/SOCIAL-MEDIA/repurposed/[blog-post-slug]/
```

### Execution

This single background task generates weeks of social content from one blog post.

---

## Customer Research Workflow

### Goal
Understand customer needs, objections, and language.

### Data Collection

**Run 3 parallel background tasks:**

1. **Review Mining:**
```
Analyze all customer reviews
Extract: Pain points, benefits mentioned, common phrases, objections
OUTPUT: MARKETING/customer-research/review-insights-YYYY-MM.md
```

2. **Social Listening:**
```
Analyze social media comments and DMs
Extract: Questions, concerns, testimonials, content requests
OUTPUT: MARKETING/customer-research/social-insights-YYYY-MM.md
```

3. **Sales Conversation Analysis:**
```
Review sales objections and common questions from SALES/
Extract: Patterns, successful responses, new objections
OUTPUT: MARKETING/customer-research/sales-insights-YYYY-MM.md
```

### Synthesis (Background Task)

After data collection:
```
Synthesize all research into:
- Updated customer avatars
- Messaging guidelines
- Content recommendations
- FAQ updates
- Sales script updates

OUTPUT: MARKETING/customer-research/synthesis-YYYY-MM.md
```

### Application (Multiple Background Tasks)

Use insights to update:
- FAQs (background task)
- Sales scripts (background task)
- Marketing copy (background task)
- Content calendar (manual)

---

## Workflow Optimization Tips

### 1. Task Grouping
Group related tasks to run in parallel:
- All social platforms at once
- All research tasks together
- All translations simultaneously

### 2. Dependency Management
Some tasks must complete before others:
- Research → Application
- Strategy → Execution
- Analysis → Synthesis

Use background tasks for independent work, sequential for dependent.

### 3. Quality Control Checkpoints
After background tasks complete:
- Review for accuracy
- Check brand voice consistency
- Verify all source links work
- Test CTAs
- Proofread

### 4. Documentation
After each major workflow:
- Document what worked
- Note time saved
- Capture lessons learned
- Update templates

### 5. Iteration
- Start simple (single background task)
- Add complexity gradually
- Optimize based on results
- Build custom workflows for your specific needs

---

## Monitoring Multiple Tasks

### Using /tasks Command

When running multiple background tasks:
1. Type `/tasks` to see all active tasks
2. Check progress on each
3. Press `t` to teleport into any task if needed
4. Review all results when complete

### Task Naming

Give tasks clear names so you can identify them:
- "Generate 10 TikTok scripts for [date]"
- "Analyze competitor X - monthly update"
- "Repurpose blog post: [title]"

### Completion Notifications

You'll be notified when each task completes. Review in order of importance.

---

*For prompt templates to use with these workflows, see: `claude_code_task_templates.md`*
*For general tasks guide, see: `claude_code_tasks_guide.md`*