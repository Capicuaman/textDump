# Project Planning Agent - Quick Start Guide

## 🚀 How to Use This Agent

### Option 1: Copy-Paste Activation (Simplest)

1. Open Claude Code or Claude.ai
2. Copy the entire contents of `activate_planning_agent.txt`
3. Paste it into the conversation
4. At the end, add your specific request:
   - "Help me plan my day"
   - "Help me plan my week"
   - "Should I work on X or Y?"
   - "I'm feeling overwhelmed, help me focus"
   - "Review my progress this week"

### Option 2: Create a Slash Command (Recommended)

Create a file: `.claude/commands/plan.md`

```markdown
You are the BILAN Project Planning Agent.

Read and follow: /Users/ideaopedia/Documents/textDump/01_PROJECTS/BILAN/METAPROMPTS/activate_planning_agent.txt

Help me plan my [day/week/decision].
```

Then use: `/plan` in any Claude Code conversation

---

## 📋 Common Use Cases

### 1. Monday Morning - Weekly Planning

**What to say:**
```
Help me plan my week. It's Monday, [current date].
```

**What you'll get:**
- Review of last week's progress
- Top 3 priorities for this week
- Daily task breakdown
- Time blocks for each priority
- List of distractions to avoid

---

### 2. Every Morning - Daily Focus

**What to say:**
```
Help me plan my day. What's the ONE thing I should focus on today?
```

**What you'll get:**
- Your single most important task
- 2-3 supporting tasks
- Time blocks
- Distractions to avoid
- Clear stopping point

---

### 3. Decision Points - Priority Conflicts

**What to say:**
```
Should I work on [Task A] or [Task B]? Here's what each involves: [brief description]
```

**What you'll get:**
- Clear recommendation with reasoning
- Impact analysis
- Phase alignment check
- Action plan for chosen task
- When to revisit the other option

---

### 4. Feeling Overwhelmed - Reality Check

**What to say:**
```
I'm feeling overwhelmed. I have [X, Y, Z] to do and don't know where to start.
```

**What you'll get:**
- Grounding in current phase and goal
- ONE task to do right now
- Permission to ignore the rest
- 90-minute focus block recommendation
- Accountability check-in time

---

### 5. Friday Afternoon - Weekly Review

**What to say:**
```
Let's review my week. Here's what I completed: [list]. Here's what I didn't: [list].
```

**What you'll get:**
- Analysis of wins and misses
- Identification of patterns
- What to continue/change
- Celebration of progress
- Setup for next week's planning

---

### 6. End of Month - Progress Check

**What to say:**
```
It's the end of the month. Let's review my progress toward Phase 1 goals.
```

**What you'll get:**
- Phase completion checklist
- Progress assessment
- Blockers identified
- Next month's priorities
- Phase transition evaluation

---

## 🎯 Example Interactions

### Example 1: Morning Planning

**You:**
```
Help me plan my day. It's Tuesday morning and I have 4 hours of focused work time available.
```

**Agent Response:**
```
Good morning! Let's maximize those 4 hours.

Your Phase 1 priority is Sales Channel Activation. Here's your focus:

🎯 PRIMARY TASK (2.5 hours):
Finish and publish your Amazon product listing
- Write title and bullet points (45 min)
- Upload product images (30 min)
- Write description (45 min)
- Submit for review (15 min)
- Test mobile view (15 min)

⚡ SUPPORTING TASK (1 hour):
Create 3 Instagram posts for the week
- Use templates from social media strategy
- Batch write captions
- Schedule for Wed/Thu/Fri

✅ QUICK WIN (30 min):
Respond to any customer inquiries
- Check email and DMs
- Answer using FAQ database

IGNORE TODAY:
- Website redesign ideas
- New product flavors
- Complex analytics deep-dive

Block your time:
- 9:00-11:30am: Amazon listing (no interruptions)
- 11:30-12:30pm: Instagram content
- 12:30-1:00pm: Customer service

Sound good? If yes, close this chat and execute. Update me at 1pm.
```

---

### Example 2: Decision Making

**You:**
```
Should I spend today optimizing my Amazon listing for better conversion, or should I launch a TikTok account and start posting there?
```

**Agent Response:**
```
Optimize Amazon listing. Here's why:

AMAZON OPTIMIZATION:
✅ You already have traffic there
✅ Direct path to revenue (immediate)
✅ Compounds over time (optimization keeps working)
✅ Aligns with Phase 1 priority (Sales Channel Activation)
⏱️ Takes 3-4 hours
💰 Impact: Could increase conversion 2-5%

TIKTOK LAUNCH:
❌ Starting from zero followers
❌ Takes months to build audience (delayed)
❌ Requires daily content commitment
❌ You already have Instagram/TikTok in your strategy
⏱️ Takes 2+ hours/day ongoing
💰 Impact: Unknown, long-term

VERDICT:
Do Amazon today. TikTok is already in your social media strategy for later this week when you do your content batching session. Don't start a new platform before optimizing what's already driving sales.

Timeline:
- Today: Amazon optimization (3-4 hours)
- Thursday: Create TikTok account + batch 5 videos (during content session)
- Friday-next week: Post TikToks from batch

Deal?
```

---

### Example 3: Overwhelm Management

**You:**
```
I'm overwhelmed. I need to: finish Amazon listing, create social content, respond to customer emails, update my website, research new suppliers, plan next month's campaigns, and my bookkeeping is behind. I don't even know where to start.
```

**Agent Response:**
```
STOP. Breathe. Let's ground you.

Current phase: Phase 1 (Foundation)
Current goal: First 100 customers
That means: Only things that directly lead to sales matter right now.

HERE'S WHAT YOU DO TODAY:
1. Finish Amazon listing (2 hours) - This is a 24/7 salesperson
2. Respond to customer emails (30 min) - These people want to buy

EVERYTHING ELSE WAITS:
- ⏸️ Social content → Thursday's batching session
- ⏸️ Website update → Phase 2 (it's good enough now)
- ⏸️ New suppliers → Phase 3 (nail one product first)
- ⏸️ Next month planning → Friday afternoon
- ⏸️ Bookkeeping → Weekend or outsource for $50

You don't have 8 priorities. You have 2.

Right now:
1. Close this conversation
2. Set a 90-minute timer
3. Work ONLY on Amazon listing
4. Nothing else exists until that timer rings

After 90 minutes, message me. We'll tackle customer emails next.

You got this. One thing at a time. Go.
```

---

## 🛠️ Tips for Best Results

### 1. Be Specific About Your Constraints
❌ "Help me plan my day"
✅ "Help me plan my day. I have 3 hours of focused time and need to handle customer support."

### 2. Share Context About Blockers
❌ "I'm stuck"
✅ "I'm stuck on my Amazon listing. I've written the title but can't figure out the bullet points. I've been staring at it for 2 hours."

### 3. Be Honest About Resistance
❌ "I just need to know what to prioritize"
✅ "I keep avoiding my Amazon listing because I'm worried it won't be perfect. What should I do?"

### 4. Update the Agent on Progress
After completing tasks, let the agent know:
✅ "I finished the Amazon listing! What's next?"
✅ "I only got through half of Task 1. Should I continue or move to Task 2?"

### 5. Ask for Accountability
✅ "Check in with me in 2 hours and ask if I completed X"
✅ "Don't let me work on anything except Y today"

---

## 📊 When to Use This Agent

### ✅ Use It For:
- Daily/weekly planning
- Priority decisions
- Overwhelm management
- Progress reviews
- Phase transition evaluation
- Reality checks on "shiny objects"
- Breaking down large goals
- Time blocking

### ❌ Don't Use It For:
- Technical how-to questions (use documentation)
- Creative content generation (use content writer agent)
- Customer support (use customer support agent)
- Detailed execution (once plan is clear, execute)

---

## 🎯 Success Metrics

Track your effectiveness with the agent:

**Weekly:**
- [ ] Did I complete my top 3 priorities? (Target: 80%+)
- [ ] Did I feel focused or scattered? (Subjective)
- [ ] How many distractions did I avoid? (Count them)

**Monthly:**
- [ ] Am I progressing toward Phase 1 goals? (Yes/No)
- [ ] Has my decision speed improved? (Faster/Slower)
- [ ] Do I feel confident in my priorities? (1-10 scale)

**Quarterly:**
- [ ] Did I complete Phase 1 objectives? (Yes/No)
- [ ] Has revenue grown? ($X to $Y)
- [ ] Strategic vs tactical ratio improving? (Track weekly)

---

## 🔄 Weekly Routine with Agent

### Monday (30 min)
- Morning: Weekly planning session
- Output: Top 3 priorities + daily breakdown

### Tuesday-Thursday (5 min each morning)
- Morning: Daily focus check
- Output: Today's ONE thing + supporting tasks

### Friday (15 min)
- Afternoon: Weekly review
- Output: What worked, what didn't, next week preview

### Monthly (30 min)
- Last Friday: Phase progress review
- Output: Phase completion assessment + next month priorities

---

## 💡 Pro Tips

1. **Time Block Immediately**: When agent gives you a task, block the time in your calendar RIGHT THEN
2. **Close the Chat**: Once you have your plan, close Claude and execute. Don't keep it open (distraction)
3. **Set Timers**: Use the time estimates. Start a timer and race it.
4. **Celebrate Wins**: Tell the agent when you complete something. Momentum matters.
5. **Be Brutally Honest**: The agent can only help if you're honest about struggles
6. **Print Your Weekly Plan**: Physical reminder > digital reminder
7. **Use Friday Reviews**: Pattern recognition happens here - don't skip this

---

## 🚨 Red Flags (Agent Will Call These Out)

- Working on Phase 2/3 tasks while in Phase 1
- More than 3 priorities in one week
- No revenue-driving tasks in your top 3
- Avoiding the hardest/most important task
- Perfecting instead of shipping
- Starting new things before finishing current ones
- No quick wins (all long-term projects)
- Ignoring customer feedback/data

---

## 📝 Quick Reference

**Morning Prompt:**
```
Help me plan my day. I have [X] hours available.
```

**Decision Prompt:**
```
Should I do [A] or [B]?
```

**Overwhelm Prompt:**
```
I'm overwhelmed. Here's everything on my mind: [list]
```

**Review Prompt:**
```
Weekly review. Completed: [list]. Didn't complete: [list].
```

**Reality Check Prompt:**
```
Is [this new thing] worth my time right now?
```

---

## 🎓 Learn the Framework

The more you understand the agent's framework, the better decisions you'll make independently:

- Read: `project_planning_agent.md` (full specification)
- Understand: Your current phase priorities
- Know: The 5 operating principles
- Practice: Decision-making framework
- Review: Phase transition criteria

Goal: Eventually you internalize the agent's thinking and need it less for daily decisions (but still use for weekly planning).

---

**Start today:** Choose ONE use case above and try it right now. The agent is waiting to help you focus.
