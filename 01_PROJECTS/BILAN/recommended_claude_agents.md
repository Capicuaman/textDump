# Recommended Claude Agents for BILAN

This document outlines recommended Claude agents to create for working with the BILAN project. These agents can be built using Claude Code or the Claude Agent SDK to automate and enhance various business operations.

## 🎯 High-Priority Agents

### 1. Customer Support Agent

**Purpose:** Answer customer questions using your RAG/FAQ database

**Capabilities:**
- Pulls information from `MARKETING/RAG/faq.json` and all electrolyte science content
- Handles inquiries about product ingredients, hydration science, proper dosing
- Answers questions about hypernatremia, hyponatremia, and sodium balance
- Can respond in both English and Spanish (using your `hechos_*.json` files)
- Maintains consistent brand voice from your marketing materials
- References scientific sources like "The Salt Fix" book content

**Data Sources:**
- `MARKETING/RAG/faq.json`
- `RAG/electrolytes.md`
- `RAG/hypernatremia.md`
- `RAG/hyponatremia.md`
- `RAG/tooMuchWater.md`
- `RAG/sugar.md`
- `RAG/corn_syrup_dangers.md`
- `RAG/glosario.md` (Spanish glossary)
- `RAG/hechos_*.json` (Spanish facts)
- `PRODUCT/whatareElectrolytes.md`
- `PRODUCT/naturalFlavors.md`

**Use Cases:**
- Automated customer service via WhatsApp, email, or chat
- Quick response to common product questions
- Educational content for social media DMs
- Pre-purchase consultation for potential customers
- Post-purchase support and usage guidance

**Integration Points:**
- WhatsApp Business API
- Email support system
- Website chat widget
- Social media DMs (Instagram, Facebook)

---

### 2. Content Writer Agent

**Purpose:** Create blog posts, product descriptions, email campaigns, and educational content

**Capabilities:**
- Understands your brand voice from existing materials in `MARKETING/OOP/`
- Writes educational content about electrolytes, hydration, and sodium science
- Creates e-commerce product descriptions for Amazon and Mercado Libre
- Drafts email sequences for customer nurturing and education
- Develops blog posts aligned with your content strategy
- References competitive analysis for strategic positioning
- Writes in both English and Spanish
- Creates content for different audience segments (athletes, health-conscious, general wellness)

**Data Sources:**
- `MARKETING/OOP/` (brand voice and structure)
- `MARKETING/consolidated_marketing_manual.md`
- `BLOG/electrolyteBlog.md` (content strategy)
- `SALES/consolidated_sales_manual.md`
- `BUSINESS/bilanMarketingDosier.json`
- `COMPETITIVEANALYSIS/` (for differentiation)
- All product and scientific content from `PRODUCT/` and `RAG/`

**Use Cases:**
- Weekly blog posts for SEO and education
- Amazon/Mercado Libre product listing optimization
- Email marketing campaigns (welcome series, educational drips, promotions)
- Product page copy for website
- Landing page content for campaigns
- Press releases and brand announcements
- Customer success stories and case studies

**Content Types:**
- Educational blog posts (800-1500 words)
- Product descriptions (50-300 words)
- Email sequences (3-7 email series)
- Landing pages (300-800 words)
- Social media long-form captions
- FAQ expansions
- How-to guides and tutorials

---

### 3. Video Script Agent

**Purpose:** Write scripts for VEO videos, TikTok, Instagram Reels, YouTube, and podcast

**Capabilities:**
- Uses your existing VEO prompts as style reference
- Creates educational scripts about electrolyte science and hydration
- Writes product usage tutorials (serve/mix/drink format)
- Develops story-driven content for emotional connection
- Adapts script length: 15s, 30s, 60s, 3-5 min, 10+ min formats
- Includes shot descriptions and visual cues for video production
- Creates hooks, body content, and calls-to-action
- Writes for different platforms (TikTok, Instagram, YouTube, podcast)
- Incorporates trending formats and viral patterns

**Data Sources:**
- `MARKETING/VEO/` (all VEO prompt files and examples)
- `MARKETING/SOCIAL-MEDIA/` (social media strategy and templates)
- `PODCAST/` (podcast content and strategy)
- `MARKETING/campaigns/` (campaign-specific messaging)
- Product and science content for educational scripts

**Use Cases:**
- Daily TikTok/Instagram Reels scripts
- YouTube educational series
- VEO AI video generation prompts
- Podcast episode scripts and outlines
- Product demonstration videos
- Customer testimonial video frameworks
- Behind-the-scenes content
- Tutorial and how-to videos
- Brand storytelling videos

**Script Formats:**
- 15-30s social media clips (hook-based)
- 60s educational videos (problem-solution)
- 3-5 min YouTube videos (deep dives)
- 10-30 min podcast episodes
- 20-60s product demos
- Story-driven brand videos

**Output Includes:**
- Full script with dialogue/narration
- Shot descriptions and camera angles
- Visual elements and graphics needed
- Music/sound effect suggestions
- Timing markers
- Call-to-action placement
- Hashtag and caption recommendations

---

### 4. Sales Copywriter Agent

**Purpose:** Write persuasive sales copy for various channels to drive conversions

**Capabilities:**
- References your comprehensive 12-part sales playbook
- Creates high-converting Amazon and Mercado Libre product listings
- Writes landing page copy optimized for conversion
- Develops WhatsApp sales messages and sequences
- Creates promotional campaign copy (guerrilla, QR code, medical education)
- Writes persuasive ad copy for future paid campaigns
- Crafts compelling CTAs and value propositions
- Uses psychological triggers from your sales psychology documentation
- A/B test copy variations

**Data Sources:**
- `SALES/1_Introduction_Sales_Playbook.md` through `SALES/12_Appendix.md`
- `SALES/consolidated_sales_manual.md`
- `SALES/ECOMMERCE/` (platform-specific strategies)
- `MARKETING/campaigns/` (campaign messaging)
- `BUSINESS/pricingBilan.md`
- `BUSINESS/bilanMarketingDosier.json`
- `COMPETITIVEANALYSIS/` (competitive positioning)
- `MARKETING/OOP/` (brand voice and audience personas)

**Use Cases:**
- Amazon product listings (title, bullets, description, A+ content)
- Mercado Libre listings optimized for Latin American market
- Landing pages for campaigns (guerrilla, QR code, medical education)
- WhatsApp sales sequences for direct selling
- Email sales sequences (cart abandonment, upsell, cross-sell)
- Website product pages
- Sales page copy for subscription model
- Promotional campaign copy
- Limited-time offer messaging
- Launch announcements
- Bundle and package descriptions

**Copy Types:**
- E-commerce listings (Amazon, Mercado Libre)
- Landing pages (short-form and long-form)
- Sales emails (cold, warm, hot)
- WhatsApp sales messages
- SMS marketing copy
- Ad copy (Facebook, Instagram, Google - for future use)
- Product benefit statements
- Comparison charts vs competitors
- Money-back guarantee copy
- Testimonial integration
- Urgency and scarcity messaging

**Optimization Focus:**
- Clear value propositions
- Benefit-driven language
- Social proof integration
- Objection handling
- Strong CTAs
- SEO optimization (for listings)
- Mobile-first readability
- Conversion rate optimization

---

## Implementation Priority

**Week 1:** Customer Support Agent
- Immediate ROI through time savings
- Leverages existing FAQ database
- Builds customer relationships

**Week 2:** Content Writer Agent
- Feeds multiple channels (blog, email, social)
- Creates assets for long-term use
- Supports SEO strategy

**Week 3:** Video Script Agent
- High-engagement content format
- Supports VEO and social video strategy
- Scalable video production

**Week 4:** Sales Copywriter Agent
- Direct impact on revenue
- Optimizes conversion funnels
- Supports e-commerce expansion

---

## Technical Considerations

### Agent Architecture Options

**Option 1: Claude Code Agent (Recommended for Start)**
- Built using Claude Code's agent framework
- Can read from your repository directly
- Easy to iterate and improve
- No hosting required for development

**Option 2: Claude Agent SDK (For Production Scale)**
- More control over agent behavior
- Can be deployed as standalone service
- Better for integration with external APIs
- Scalable for high-volume usage

**Option 3: Custom API Integration**
- Connect agents to WhatsApp Business API
- Email service integrations
- CRM system connections
- Analytics tracking

### Data Access Strategy

All agents should have read access to:
- `MARKETING/` - Brand voice, campaigns, messaging
- `SALES/` - Sales methodology and playbooks
- `PRODUCT/` - Product information and science
- `RAG/` - FAQ database and educational content
- `BUSINESS/` - Pricing, strategy, positioning
- `COMPETITIVEANALYSIS/` - Market context

### Version Control

- Store agent prompts in `METAPROMPTS/agents/`
- Track agent performance metrics
- Document agent updates and improvements
- Test agents before production deployment

---

## Success Metrics

### Customer Support Agent
- Response time (target: <5 minutes)
- Answer accuracy rate (target: >95%)
- Customer satisfaction score (target: >4.5/5)
- Ticket deflection rate (target: 70%)

### Content Writer Agent
- Content production volume (target: 10+ pieces/week)
- Time savings vs manual writing (target: 60%+)
- SEO performance (target: 50+ keywords ranked)
- Engagement metrics (target: >3% engagement rate)

### Video Script Agent
- Scripts produced per week (target: 10+)
- Video completion rate (target: >80%)
- View-through rate (target: >50%)
- Conversion from video viewers (target: >2%)

### Sales Copywriter Agent
- Conversion rate improvement (target: +20%)
- Average order value increase (target: +15%)
- Click-through rate on CTAs (target: >5%)
- Revenue attributed to optimized copy (track monthly)

---

## Next Steps

1. **Review existing content** in repository to understand brand voice and style
2. **Define specific agent prompts** based on this framework
3. **Create agent prototypes** using Claude Code
4. **Test agents** with sample queries and tasks
5. **Iterate based on results** and refine prompts
6. **Deploy to production** once validated
7. **Monitor performance** and continuously improve

---

## Resources

### Existing BILAN Assets to Leverage
- Sales Playbook (12 parts) - `/SALES/`
- Marketing Manuals - `/MARKETING/`
- FAQ Database - `/MARKETING/RAG/faq.json`
- VEO Video Prompts - `/MARKETING/VEO/`
- Social Media Strategy - `/MARKETING/SOCIAL-MEDIA/`
- Brand Voice Framework - `/MARKETING/OOP/`

### External Tools for Agent Integration
- WhatsApp Business API
- Twilio (SMS/WhatsApp)
- SendGrid/Mailchimp (Email)
- Shopify/WooCommerce APIs
- Amazon MWS API
- Mercado Libre API

---

## Maintenance Plan

**Weekly:**
- Review agent performance metrics
- Update FAQ database with new questions
- Add new content to knowledge base

**Monthly:**
- Audit agent responses for quality
- Update competitive intelligence
- Refine prompts based on performance
- Add new use cases and capabilities

**Quarterly:**
- Comprehensive agent review
- Strategic adjustments based on business goals
- Technology stack evaluation
- ROI analysis

---

*Last Updated: December 2024*
*For questions or suggestions, reference this document when working with Claude Code.*
