# Claude Code Task Templates for BILAN

**Purpose:** Ready-to-use prompts for common background tasks
**Usage:** Copy prompt, customize parameters in [brackets], run as background task
**Last Updated:** January 23, 2026

## Table of Contents

1. [Blog Content Generation](#blog-content-generation)
2. [Social Media Content](#social-media-content)
3. [Marketing Materials](#marketing-materials)
4. [Sales Content](#sales-content)
5. [Research & Analysis](#research--analysis)
6. [Translation Workflows](#translation-workflows)
7. [SEO Optimization](#seo-optimization)
8. [Product Documentation](#product-documentation)
9. [Email Marketing](#email-marketing)
10. [Video Scripts (VEO)](#video-scripts-veo)

---

## Blog Content Generation

### Single Blog Post

```
TASK: Write a comprehensive blog post

TOPIC: [specific topic, e.g., "Benefits of magnesium for athletic performance"]

REQUIREMENTS:
- Length: 1200-1500 words
- Tone: Educational but accessible
- Target audience: Health-conscious athletes and fitness enthusiasts
- Include: Scientific backing (reference PRODUCT/ directory)
- Structure: Introduction, 3-5 main sections, conclusion, CTA
- SEO: Target keyword "[keyword]"

RESEARCH SOURCES:
- Read all files in 01_PROJECTS/BILAN/PRODUCT/ingredients/
- Reference 01_PROJECTS/BILAN/MARKETING/RAG/faq.json for common questions
- Maintain brand voice from existing blog posts

OUTPUT:
- Save as: BLOG/src/content/blog/YYYY-MM-DD-[post-slug].md
- Include frontmatter: title, date, excerpt, author, tags
- Add internal links to related posts
- Suggest 3 social media snippets for promotion

Run this in the background and notify me when complete.
```

### Blog Post Series

```
TASK: Generate a 5-part blog series

SERIES THEME: [e.g., "Complete Guide to Electrolyte Balance"]

INDIVIDUAL POSTS:
1. [Post 1 topic]
2. [Post 2 topic]
3. [Post 3 topic]
4. [Post 4 topic]
5. [Post 5 topic]

FOR EACH POST:
- Length: 1000-1200 words
- Research from PRODUCT/ and MARKETING/RAG/
- Cross-reference between posts
- Progressive difficulty (beginner to advanced)
- Internal linking between series posts
- Consistent brand voice

OUTPUT:
- Save to: BLOG/src/content/blog/
- Naming: YYYY-MM-DD-series-name-part-X.md
- Create series index page with links to all posts
- Generate promotional calendar for social media

Run all 5 posts in parallel as background tasks.
```

### Blog Content Audit

```
TASK: Audit existing blog content

SCOPE: All posts in BLOG/src/content/blog/

ANALYSIS:
- Identify outdated statistics or research
- Check for broken links (internal and external)
- Verify product claims match current formulation (check PRODUCT/)
- Assess SEO optimization (meta descriptions, keywords, headings)
- Evaluate readability and engagement
- Find opportunities for internal linking

OUTPUT:
- Generate audit report: BLOG/audit-YYYY-MM-DD.md
- Priority recommendations (high, medium, low)
- List of posts needing updates
- SEO improvement opportunities
- Content gap analysis

Run in background and provide summary when complete.
```

---

## Social Media Content

### Instagram Weekly Content

```
TASK: Generate Instagram content for one week

CAMPAIGN THEME: [e.g., "Hydration Myths Debunked"]

REQUIREMENTS:
- 7 posts (one per day)
- Mix of formats: educational carousel, single image with caption, testimonial, product feature
- Captions: 150-200 words, engaging hook, value-packed content, clear CTA
- Hashtags: 15-20 relevant, mix of high/medium/low competition
- Emojis: Use strategically, brand-appropriate
- Research: Pull facts from MARKETING/RAG/faq.json and PRODUCT/

POST STRUCTURE:
- Monday: Educational (myth-busting)
- Tuesday: Product feature
- Wednesday: Customer testimonial/use case
- Thursday: Quick tip
- Friday: Behind-the-scenes/science
- Saturday: Lifestyle/aspiration
- Sunday: Community engagement question

OUTPUT:
- Save to: MARKETING/SOCIAL-MEDIA/instagram/YYYY-MM-campaign-name.md
- Include: Post text, hashtag sets, posting time recommendations
- Create Instagram Stories companion content (3-5 slides per day)
- Generate Reels script ideas for 2 posts

Run in background.
```

### Multi-Platform Campaign

```
TASK: Create coordinated social media campaign across platforms

CAMPAIGN: [campaign name and goal]
DURATION: [e.g., 2 weeks]
PLATFORMS: Instagram, TikTok, LinkedIn, Twitter/X

FOR EACH PLATFORM:
- Platform-specific content (native format and voice)
- Consistent messaging but adapted to audience
- Optimal posting schedule
- Platform-specific hashtags/keywords

INSTAGRAM:
- 14 feed posts
- 28 stories (2 per day)
- 4 Reels
- Captions, hashtags, CTAs

TIKTOK:
- 14 video scripts
- Trending sounds/formats
- Hashtag strategy
- Engagement hooks

LINKEDIN:
- 10 professional posts
- Mix of articles and quick tips
- B2B angle
- Thought leadership tone

TWITTER/X:
- 28 tweets (2 per day)
- Mix of threads and standalone
- Engagement-focused
- Timely/topical

OUTPUT:
- Save to: MARKETING/SOCIAL-MEDIA/[platform]/campaign-[name]-YYYY-MM.md
- Create content calendar: MARKETING/SOCIAL-MEDIA/calendar-[campaign]-YYYY-MM.md
- Cross-promotion strategy
- Analytics tracking plan

Run as 4 parallel background tasks (one per platform).
```

### Content Repurposing

```
TASK: Repurpose blog content for social media

SOURCE: [specific blog post or posts]

CREATE:
- 10 Instagram posts (various formats)
- 5 TikTok video scripts
- 15 Twitter/X tweets (including thread)
- 3 LinkedIn articles/posts
- Pinterest graphics text
- Email newsletter snippet

REQUIREMENTS:
- Extract key insights from source
- Rewrite for each platform's audience and format
- Maintain core message and brand voice
- Add platform-specific engagement elements
- Include relevant CTAs

OUTPUT:
- Save to respective platform directories in MARKETING/SOCIAL-MEDIA/
- Create repurposing map showing source → outputs
- Note: Content calendar with suggested posting dates

Run in background.
```

---

## Marketing Materials

### Product Page Copy

```
TASK: Write product page copy

PRODUCT: [product name/variant]

REQUIREMENTS:
- Hero headline: Compelling, benefit-focused
- Subheadline: Clarifying value proposition
- Product description: 200-300 words
- Key benefits: 5-7 bullet points with explanations
- Ingredients: Pull from PRODUCT/ingredients/ with benefits
- Social proof: Testimonial suggestions
- FAQ section: 8-10 questions (reference MARKETING/RAG/faq.json)
- SEO: Target keywords, meta description

RESEARCH:
- Product specifications: PRODUCT/
- Competitive positioning: COMPETITIVEANALYSIS/
- Customer language: MARKETING/RAG/

OUTPUT:
- Save to: WEB_DEVELOPMENT/product-pages/[product-name].md
- Include both English and Spanish versions
- Suggest A/B test variations for headline
- List complementary products for cross-sell

Run in background.
```

### Landing Page Copy

```
TASK: Create high-converting landing page copy

CAMPAIGN: [campaign/offer name]
GOAL: [e.g., email signup, product purchase, lead generation]

STRUCTURE:
- Above fold: Headline + subheadline + CTA
- Problem section: Identify customer pain points
- Solution section: How BILAN solves it
- Benefits: 3-5 key benefits with icons/visuals
- Social proof: Testimonials and trust indicators
- Features: Product details
- How it works: 3-4 step process
- FAQ: Objection handling
- Final CTA: Urgency and clarity

REQUIREMENTS:
- Length: 800-1200 words total
- Conversion-focused copywriting
- Clear, compelling CTAs throughout
- Mobile-optimized structure
- SEO considerations
- Research: SALES/objection-handling/, MARKETING/RAG/

OUTPUT:
- Save to: WEB_DEVELOPMENT/landing-pages/[campaign-name].md
- Suggest headline variations for A/B testing (5 options)
- Recommend images/graphics needed
- Create email follow-up sequence (3 emails)

Run in background.
```

### Campaign Brief

```
TASK: Develop comprehensive campaign brief

CAMPAIGN: [campaign name]
OBJECTIVE: [business goal]
TIMELINE: [duration]

CREATE:
- Campaign overview and objectives
- Target audience definition
- Key messaging pillars
- Channel strategy (where to execute)
- Content requirements by channel
- Creative direction
- Success metrics and KPIs
- Budget considerations
- Timeline and milestones

RESEARCH:
- Past campaign performance
- Competitive campaigns in COMPETITIVEANALYSIS/
- Customer insights from MARKETING/RAG/
- Sales playbook SALES/consolidated_sales_manual.md

OUTPUT:
- Save to: MARKETING/campaigns/[campaign-name]/brief-YYYY-MM-DD.md
- Include creative examples/references
- List all assets needed
- Create project checklist

Run in background.
```

---

## Sales Content

### Sales Email Sequence

```
TASK: Write sales email sequence

SEQUENCE TYPE: [e.g., welcome, abandoned cart, post-purchase, re-engagement]
LENGTH: [number of emails]
AUDIENCE: [specific segment]

FOR EACH EMAIL:
- Subject line: 3 variations for A/B testing
- Preview text: Compelling continuation of subject
- Body: 150-250 words
- Tone: [conversational/professional/urgent]
- CTA: Clear and action-oriented
- Personalization: Merge tags and dynamic content
- Timing: Recommended delay from previous email

SEQUENCE STRATEGY:
- Progressive value delivery
- Objection handling: Reference SALES/objection-handling/
- Social proof integration
- Urgency without pressure
- Clear path to purchase

OUTPUT:
- Save to: MARKETING/EMAIL/sequences/[sequence-name]/
- Each email as separate file: email-1-[subject-slug].md
- Create sequence flowchart
- Suggest segmentation criteria
- List tracking metrics

Run in background.
```

### Objection Handling Scripts

```
TASK: Create objection handling scripts

CONTEXT: Sales conversations (DM, phone, email)

COMMON OBJECTIONS:
1. [e.g., "Too expensive"]
2. [e.g., "Can I just use table salt?"]
3. [e.g., "I don't believe in supplements"]
4. [e.g., "How is this different from competitors?"]
5. [e.g., "I'll think about it"]

FOR EACH OBJECTION:
- Empathetic acknowledgment
- Reframe/educate: Use science from PRODUCT/
- Address concern: Evidence-based response
- Bridge to value: Connect to benefits
- Close: Move conversation forward
- Alternative approaches (2-3 per objection)

RESEARCH:
- Product science: PRODUCT/
- Competitive advantages: COMPETITIVEANALYSIS/
- Customer testimonials
- Sales manual: SALES/consolidated_sales_manual.md

OUTPUT:
- Save to: SALES/objection-handling/scripts-YYYY-MM-DD.md
- Quick reference one-pager
- Training scenarios for practice
- Update consolidated sales manual with new scripts

Run in background.
```

### Testimonial Outreach Templates

```
TASK: Create customer testimonial request templates

PURPOSE: Gather social proof from satisfied customers

CREATE:
- Email template for testimonial request
- DM scripts for social media
- Survey questions to guide testimonials
- Thank you message with incentive details
- Follow-up if no response
- Testimonial usage permission request

REQUIREMENTS:
- Friendly, appreciative tone
- Make it easy (specific questions, not open-ended)
- Offer incentive: [specify if applicable]
- Multiple touchpoints
- Different approaches for different customer types

QUESTIONS TO GUIDE TESTIMONIALS:
- What problem were you trying to solve?
- How has BILAN helped?
- What specific results have you seen?
- What would you tell someone considering BILAN?
- Favorite thing about the product?

OUTPUT:
- Save to: MARKETING/testimonials/outreach-templates.md
- Create tracking spreadsheet template
- Testimonial library template for organizing responses
- Usage guidelines (how to incorporate into marketing)

Run in background.
```

---

## Research & Analysis

### Competitive Analysis

```
TASK: Comprehensive competitive analysis

COMPETITOR: [competitor name]

ANALYZE:
- Company overview and positioning
- Product line and offerings
- Pricing strategy
- Marketing channels and messaging
- Social media presence and engagement
- Content strategy (blog, video, etc.)
- Customer reviews (what they love/hate)
- Unique selling propositions
- Strengths and weaknesses
- Website UX and conversion strategy

RESEARCH METHODS:
- Website analysis
- Social media audit (Instagram, TikTok, LinkedIn)
- Review mining (Amazon, website, social)
- Pricing comparison
- Content themes and frequency
- Paid advertising (if visible)

OUTPUT:
- Save to: COMPETITIVEANALYSIS/[competitor-name]-analysis-YYYY-MM-DD.md
- SWOT analysis
- Key takeaways: What we can learn
- Opportunities: Gaps we can exploit
- Threats: Where they're stronger
- Strategic recommendations

Run in background. If analyzing multiple competitors, spawn one agent per competitor.
```

### Ingredient Research

```
TASK: Deep dive research on ingredient

INGREDIENT: [e.g., magnesium glycinate, sodium citrate]

RESEARCH:
- Scientific literature overview
- Health benefits (proven and claimed)
- Optimal dosage ranges
- Bioavailability and absorption
- Synergies with other ingredients
- Safety profile and side effects
- Comparison to alternative forms
- Athletic performance applications
- Regulatory status (FDA, health claims)

REQUIREMENTS:
- Evidence-based (cite studies/sources)
- Translate science to consumer language
- Compare to competitors' formulations
- Identify marketing opportunities

OUTPUT:
- Save to: PRODUCT/ingredients/[ingredient-name]-research.md
- Create FAQ entries: Add to MARKETING/RAG/faq.json
- Write blog post draft: PRODUCT/ingredients/[ingredient]-blog-draft.md
- Marketing messaging: Key talking points
- Generate social media posts (3-5) highlighting benefits

Run in background.
```

### Market Trend Analysis

```
TASK: Analyze current market trends

FOCUS: [e.g., hydration/electrolytes, health supplements, fitness trends]

RESEARCH AREAS:
- Consumer behavior shifts
- Emerging ingredients and formulations
- Marketing tactics gaining traction
- Influencer landscape
- Regulatory changes
- Pricing trends
- Distribution channel evolution
- Demographic shifts

SOURCES:
- Industry reports and news
- Social media trends
- Competitor observation
- Customer feedback patterns
- Search trends (Google Trends, etc.)

OUTPUT:
- Save to: COMPETITIVEANALYSIS/market-trends-YYYY-MM-DD.md
- Executive summary: Key findings
- Opportunities for BILAN
- Risks and challenges
- Strategic recommendations
- Content ideas based on trends
- Product development suggestions

Run in background.
```

### Customer Avatar Research

```
TASK: Develop detailed customer avatar

AVATAR NAME: [e.g., "Athletic Annie", "Wellness-Focused Will"]

PROFILE:
- Demographics: Age, gender, location, income
- Psychographics: Values, beliefs, lifestyle
- Goals and aspirations
- Challenges and pain points
- Daily routines
- Media consumption habits
- Shopping behaviors
- Health and fitness practices
- Decision-making factors
- Objections and concerns

RESEARCH SOURCES:
- Existing customer data
- Social media conversations
- Review analysis
- Sales conversation patterns from SALES/
- Competitive customer profiles

OUTPUT:
- Save to: MARKETING/customer-avatars/[avatar-name].md
- Create visual one-pager (text for graphic design)
- Messaging guidelines for this avatar
- Channel preferences and strategy
- Content themes that resonate
- Product positioning for avatar
- Sales script customizations

Run in background. Can run multiple avatars in parallel.
```

---

## Translation Workflows

### Content Translation (English → Spanish)

```
TASK: Translate and culturally adapt content

SOURCE: [file path or content description]
TARGET: Spanish (Latin American / Spain - specify)

REQUIREMENTS:
- Not literal translation - cultural adaptation
- Maintain brand voice in Spanish
- Adapt idioms and expressions
- Localize examples and references
- SEO keywords in Spanish
- Respect regional differences if applicable

QUALITY CHECKS:
- Natural-sounding Spanish
- Technical accuracy (especially product/science terms)
- Consistent terminology with existing Spanish content
- Appropriate formality level

OUTPUT:
- Save to: [same directory as source]/[filename]-es.md
- Create glossary of key terms (English-Spanish) if not exists
- Note any culturally-specific adaptations made
- Flag anything requiring native speaker review

Run in background.
```

### Bilingual Content Creation

```
TASK: Create content in both English and Spanish simultaneously

TOPIC: [content topic]
FORMAT: [blog post / social media / product page / email]

REQUIREMENTS:
- Create English version first
- Create Spanish version (not translation, but adapted)
- Both should feel native to the language
- Maintain consistent messaging
- Culturally appropriate for each audience
- Platform/format-specific optimization for each

RESEARCH:
- Product information: PRODUCT/
- Brand voice: Existing bilingual content examples
- SEO keywords: Both languages

OUTPUT:
- English: [file path with -en suffix]
- Spanish: [file path with -es suffix]
- Comparison document noting key differences in approach
- Suggest which markets/audiences for each version

Run as 2 parallel background tasks if content is substantial.
```

---

## SEO Optimization

### On-Page SEO Audit

```
TASK: Conduct on-page SEO audit

SCOPE: [specific page/post or entire site section]

ANALYZE:
- Title tags: Length, keyword placement, compelling
- Meta descriptions: Length, keywords, CTA
- Header structure: H1, H2, H3 hierarchy
- Keyword optimization: Density, placement, variations
- Internal linking: Opportunities and broken links
- Image alt text: Descriptive, keyword-relevant
- URL structure: Clean, keyword-rich
- Content length: Adequate depth
- Readability: Flesch score, sentence length
- Mobile optimization: Structure and formatting
- Schema markup: Opportunities

FOR EACH ISSUE:
- Severity: High / Medium / Low
- Specific recommendation
- Example of improvement

OUTPUT:
- Save to: WEB_DEVELOPMENT/seo/audit-YYYY-MM-DD.md
- Priority action list
- Quick wins (easy, high-impact)
- Long-term improvements
- Keyword opportunity report

Run in background.
```

### Keyword Research

```
TASK: Keyword research for content planning

FOCUS: [topic area or product category]

RESEARCH:
- Primary keywords: High volume, relevant
- Long-tail keywords: Specific, lower competition
- Question-based keywords: FAQ opportunities
- Related topics: Content expansion ideas
- Competitor keywords: What they rank for
- Seasonal trends: Timing opportunities

ANALYZE:
- Search volume
- Competition level
- Ranking difficulty
- User intent (informational, commercial, transactional)
- Current BILAN rankings (if any)

OUTPUT:
- Save to: WEB_DEVELOPMENT/seo/keyword-research-[topic]-YYYY-MM-DD.md
- Keyword priority matrix (opportunity score)
- Content recommendations: What to create
- Optimization recommendations: Existing content to update
- 30-day content calendar based on keywords

Run in background.
```

---

## Product Documentation

### FAQ Generation

```
TASK: Generate comprehensive FAQ content

TOPIC: [e.g., product usage, ingredients, benefits, shipping]

CREATE:
- 15-20 question-answer pairs
- Questions based on actual customer inquiries
- Science-backed answers when applicable
- Clear, concise, helpful responses
- Conversational but professional tone

RESEARCH:
- Product documentation: PRODUCT/
- Existing FAQs: MARKETING/RAG/faq.json
- Sales objections: SALES/objection-handling/
- Customer service common questions

ANSWER STRUCTURE:
- Direct answer first
- Explanation/context
- Additional helpful information
- Related questions/cross-references

OUTPUT:
- Save to: MARKETING/RAG/faq-[topic]-YYYY-MM-DD.md
- Update main FAQ file: MARKETING/RAG/faq.json
- Create FAQ page content for website
- Identify topics needing blog post expansion

Run in background.
```

### Product Usage Guide

```
TASK: Create comprehensive product usage guide

PRODUCT: [product name]

INCLUDE:
- What it is: Product overview
- Who it's for: Target users
- Key benefits: Why use it
- How to use: Detailed instructions
- Dosage recommendations: Various scenarios (workout, daily, recovery)
- Timing: When to take for best results
- Mixing instructions: Taste and consistency tips
- What to expect: Results timeline
- FAQ: 10-15 common questions
- Safety: Warnings, contraindications
- Storage: How to keep fresh

TONE: Friendly, educational, empowering

RESEARCH:
- Product specs: PRODUCT/
- Scientific backing: PRODUCT/ingredients/
- Customer feedback and questions

OUTPUT:
- Save to: PRODUCT/usage-guides/[product-name]-guide.md
- Create quick-start one-pager version
- Generate social media "how-to" content series
- List additional resources (blog posts, videos)

Run in background.
```

---

## Email Marketing

### Newsletter Content

```
TASK: Write email newsletter

EDITION: [newsletter name/date]

STRUCTURE:
- Subject line: 3 variations for A/B test
- Preview text: Compelling hook
- Intro: Friendly greeting, set context
- Main content sections (2-4):
  - Educational tip or insight
  - Product feature or highlight
  - Customer story or testimonial
  - Announcement or update
- CTA: Clear action
- P.S.: Secondary CTA or engagement

REQUIREMENTS:
- Length: 300-500 words
- Conversational tone
- Value-first (not just selling)
- Scannable (short paragraphs, bullets)
- Mobile-optimized structure
- Internal links: Drive to website content

RESEARCH:
- Recent blog posts: BLOG/
- Product updates: PRODUCT/
- Campaign themes: MARKETING/campaigns/

OUTPUT:
- Save to: MARKETING/EMAIL/newsletters/newsletter-YYYY-MM-DD.md
- Suggest images/graphics needed
- Plain text version
- Segment recommendations (who should receive)

Run in background.
```

### Abandoned Cart Sequence

```
TASK: Create abandoned cart email sequence

SEQUENCE LENGTH: 3 emails
TIMING: Email 1 (1 hour), Email 2 (24 hours), Email 3 (72 hours)

EMAIL 1: Gentle Reminder
- Subject: "Forget something?"
- Tone: Helpful, no pressure
- Content: Cart contents reminder, easy return link
- CTA: "Complete your order"

EMAIL 2: Value Reinforcement
- Subject: [create compelling subject]
- Tone: Educational, benefit-focused
- Content: Why they'll love the product, testimonial, benefits
- CTA: "Get [X% off] if you order today"
- Urgency: Soft discount or bonus

EMAIL 3: Last Chance
- Subject: [create urgent but not pushy subject]
- Tone: Friendly urgency
- Content: Last reminder, final incentive, address common objections
- CTA: "Don't miss out - order now"
- Urgency: Expiring offer

FOR EACH EMAIL:
- 3 subject line variations
- Preview text
- Email body
- CTA button text
- Plain text version

RESEARCH:
- Objection handling: SALES/objection-handling/
- Product benefits: PRODUCT/
- Social proof: MARKETING/testimonials/

OUTPUT:
- Save to: MARKETING/EMAIL/sequences/abandoned-cart/
- Each email as separate file
- Sequence timing and logic flowchart
- A/B test plan
- Success metrics to track

Run in background.
```

---

## Video Scripts (VEO)

### Short-Form Video Script (15-60 seconds)

```
TASK: Write short-form video script for VEO generation

TOPIC: [video topic/hook]
PLATFORM: [TikTok / Instagram Reels / YouTube Shorts]
LENGTH: [15s / 30s / 60s]

STRUCTURE:
- Hook (first 3 seconds): Attention-grabbing
- Problem/Question: Relatable pain point
- Solution: How BILAN helps
- Proof: Quick fact or result
- CTA: What to do next

VISUAL DIRECTIONS:
- Scene descriptions for each segment
- On-screen text suggestions
- Product placement moments
- Transitions and pacing
- B-roll suggestions

AUDIO:
- Voiceover script (conversational, engaging)
- Suggest music mood/style
- Sound effect cues

RESEARCH:
- Trending formats for platform
- Product benefits: PRODUCT/
- Competitor video styles
- Successful past content

OUTPUT:
- Save to: MARKETING/VEO/short-form/[topic-slug]-YYYY-MM-DD.md
- Include: Full script, visual directions, audio cues
- Suggest 3 hook variations for A/B testing
- Related video ideas for series

Run in background.
```

### Educational Video Script (2-5 minutes)

```
TASK: Write educational video script

TOPIC: [detailed topic, e.g., "Complete Guide to Electrolyte Timing"]
LENGTH: [2-5 minutes]
STYLE: [talking head / animation / mixed / demonstration]

STRUCTURE:
- Intro (0:00-0:20):
  - Hook: Why this matters
  - Preview: What they'll learn
  - Credibility: Why trust us
- Main Content (0:20-4:00):
  - Section 1: [topic]
  - Section 2: [topic]
  - Section 3: [topic]
  - Section 4: [topic]
- Conclusion (4:00-4:40):
  - Recap: Key takeaways
  - Action steps: What to do
  - CTA: Next steps
- Outro (4:40-5:00):
  - Brand reminder
  - Subscribe/follow ask

FOR EACH SECTION:
- Voiceover script
- On-screen text/graphics needed
- Visual suggestions (B-roll, animations, product shots)
- Examples or demonstrations
- Transitions

RESEARCH:
- Science and facts: PRODUCT/
- FAQ insights: MARKETING/RAG/faq.json
- Blog content: BLOG/
- Competitor educational content

OUTPUT:
- Save to: MARKETING/VEO/educational/[topic-slug]-YYYY-MM-DD.md
- Full script with timestamps
- Shot list for production
- Graphics/animation needs
- YouTube description and tags
- Social media promotion plan

Run in background.
```

---

## Batch Operations

### Weekly Content Batch

```
TASK: Generate all content for upcoming week

WEEK OF: [date range]

CREATE:
- 3 blog posts (different topics)
- 7 Instagram posts (one per day)
- 3 TikTok scripts
- 5 email newsletters or sequence emails
- 10 Twitter/X posts
- 1 LinkedIn article
- Update 5 FAQ entries

REQUIREMENTS:
- Cohesive theme across all content
- Cross-promotion between channels
- Research-backed claims
- Brand voice consistent
- SEO optimized where applicable

RESEARCH:
- Content calendar themes
- Product information: PRODUCT/
- Recent trends and news
- Seasonal/timely hooks

OUTPUT:
- Save to respective directories
- Create week-at-a-glance calendar
- Asset needs list (images, videos)
- Publishing schedule with optimal times

Run as multiple parallel background tasks (group by content type).
```

### Content Refresh Campaign

```
TASK: Refresh and update existing content

SCOPE: [e.g., all Q4 2025 blog posts, all product pages, etc.]

FOR EACH PIECE:
- Review for accuracy (check against current PRODUCT/ info)
- Update statistics and studies (find latest research)
- Improve SEO (keywords, meta, structure)
- Add internal links to newer content
- Enhance CTAs
- Improve readability
- Add/update images
- Check for broken links

IDENTIFY:
- Content that needs minor updates
- Content that needs major rewrite
- Content to consolidate or remove
- New content opportunities from gaps

OUTPUT:
- Save updates to original files
- Create summary report: [scope]-refresh-report-YYYY-MM-DD.md
- Priority list: What to update first
- New content ideas identified
- Before/after metrics (word count, readability scores)

Run in background - can take time to process multiple pieces.
```

---

## Advanced Workflows

### Product Launch Campaign (Complete)

```
TASK: Generate complete product launch campaign

PRODUCT: [new product/flavor name]
LAUNCH DATE: [date]
CAMPAIGN DURATION: 4 weeks

CREATE ALL ASSETS:

WEEK 1: Teaser
- 3 teaser social posts (mystery/anticipation)
- Email: Coming soon announcement
- Blog: Behind-the-scenes development story
- 2 teaser video scripts

WEEK 2: Reveal
- Product announcement blog post
- Product page copy (full)
- 7 social posts (daily, various angles)
- Email: Official launch announcement
- Press release
- 3 launch video scripts
- Influencer outreach template

WEEK 3: Education
- 3 educational blog posts (benefits, usage, science)
- 7 social posts (educational content)
- Email: Product deep-dive
- FAQ generation (20 questions)
- How-to video script
- Comparison guide (vs. competitors)

WEEK 4: Conversion
- 5 promotional social posts
- Email: Special offer
- Testimonial collection templates
- 2 conversion-focused video scripts
- Retargeting ad copy (3 variations)
- Landing page for special offer

RESEARCH:
- Product specs: PRODUCT/
- Competitive positioning: COMPETITIVEANALYSIS/
- Brand voice: Existing campaigns
- Customer insights: MARKETING/RAG/

OUTPUT:
- Save to: MARKETING/campaigns/launch-[product-name]-YYYY-MM/
- Complete content calendar
- Asset tracker (what needs design/production)
- Team task list
- Budget considerations
- Success metrics and tracking plan

Run as multiple parallel background tasks - very large project.
```

---

## Notes on Usage

### Running Background Tasks

Most templates above include "Run in background" at the end. To actually run in background:

1. **Copy the template prompt**
2. **Customize parameters** in [brackets]
3. **Tell me:** "Run this as a background task" or "Execute this in the background"
4. **Monitor:** Use `/tasks` to check progress
5. **Review:** I'll notify you when complete

### Parallel Execution

For tasks marked "run in parallel":
- I can spawn multiple agents simultaneously
- Each works on their portion independently
- All complete around the same time
- Review all results together

### Customization Tips

- **Adjust tone:** Add tone descriptors (casual, professional, urgent, friendly)
- **Adjust length:** Specify word counts or time durations
- **Add constraints:** "Must include X" or "Avoid Y"
- **Reference specific files:** Point to exact files for research
- **Set priorities:** "Focus on X aspect more than Y"

---

*For more on Claude Code tasks: See `claude_code_tasks_guide.md` and `03_RESOURCES/AI/CLAUDE/claude_code_2.1_features.md`*
