# MCP Decision Guide: When and What to Use

**Purpose:** Help you decide if, when, and which MCP server to use
**Created:** February 11, 2026

---

## Decision Tree

```
Is the task repetitive (>3 uses)?
│
├─ NO → Use Bash directly
│         (One-time migrations, rare tasks)
│
└─ YES → Continue...
    │
    Does the task involve remote servers?
    │
    ├─ YES → Continue...
    │   │
    │   Is it just basic SSH commands?
    │   │
    │   ├─ YES → Use existing SSH MCP
    │   │         (ssh-mcp, SSH-MCP)
    │   │
    │   └─ NO → Is it complex/multi-device?
    │       │
    │       ├─ YES → Build custom Homelab MCP
    │       │         (Token savings justify development)
    │       │
    │       └─ NO → Use existing SSH MCP
    │
    └─ NO → Check MCP directory
              (Database, API, file operations, etc.)
```

---

## Quick Reference Matrix

| Task | Tool | Token Savings | Setup Time | Recommendation |
|------|------|---------------|------------|----------------|
| One-time migration | Bash | 0% | 0 min | ✅ Use Bash |
| Check Pi status once | Bash | 0% | 0 min | ✅ Use Bash |
| Check Pi status daily | SSH MCP | 40-70% | 15 min | ✅ Use SSH MCP |
| Manage 1 Pi regularly | SSH MCP | 40-70% | 15 min | ✅ Use SSH MCP |
| Manage 3+ Pis | Custom MCP | 70-80% | 16-20 hrs | ⚠️ Consider custom |
| Complex orchestration | Custom MCP | 75-85% | 20-40 hrs | ⚠️ Build if frequent |
| Database queries | Database MCP | 50-70% | 10 min | ✅ Use existing |
| GitHub operations | GitHub MCP | 60-80% | 5 min | ✅ Use existing |
| File operations | Local only | 0% | 0 min | ❌ Bash is fine |

---

## Use Case Analysis

### Scenario 1: Clawdbot Migration (Your Case)

**Task:** One-time migration from local to Pi

**Analysis:**
- Frequency: Once
- Complexity: High (multiple steps)
- Documentation value: High (for reference)

**Decision:** ✅ **Use Bash + Create Skill**

**Reasoning:**
- One-time task doesn't justify MCP setup time
- Skill provides documentation and reusability
- Token usage (75K) acceptable for migration
- MCP wouldn't help with documentation creation

**Future optimization:**
- Use SSH MCP for post-migration monitoring
- Build custom MCP if managing multiple devices

---

### Scenario 2: Daily Pi Monitoring

**Task:** Check status, logs, resources daily

**Analysis:**
- Frequency: Daily (365x/year)
- Complexity: Low (status checks)
- Token cost: ~2,000/check with Bash

**Decision:** ✅ **Use SSH MCP**

**Reasoning:**
- Setup time: 15 minutes
- Token savings: ~1,200/check
- Annual savings: ~440,000 tokens
- ROI: Positive after 2 uses

**Calculation:**
```
Setup cost: 15 min
Per-use savings: 1,200 tokens
Break-even: 2 uses
Annual benefit: 440K tokens saved
```

---

### Scenario 3: Multi-Pi Infrastructure

**Task:** Manage 5 Raspberry Pis + NAS + servers

**Analysis:**
- Frequency: Multiple times daily
- Complexity: High (orchestration needed)
- Custom needs: Device-specific configurations

**Decision:** ⚠️ **Build Custom Homelab MCP**

**Reasoning:**
- Setup time: 20 hours
- Token savings: ~8,000 per day
- Pays for itself in ~10 days
- Enables advanced features:
  - Multi-device orchestration
  - Automated health checks
  - Custom workflows

**Calculation:**
```
Development: 20 hours
Daily operations: 10 checks × 8 devices = 80 checks
Token savings: 80 × 1,200 = 96,000/day
Break-even: 10 days
Monthly benefit: ~2.8M tokens
```

---

### Scenario 4: Database Operations

**Task:** Query Postgres database frequently

**Analysis:**
- Frequency: Multiple times daily
- Complexity: Low (SQL queries)
- Existing MCP: Yes (Postgres MCP)

**Decision:** ✅ **Use Postgres MCP**

**Reasoning:**
- Pre-built, maintained MCP available
- 5-minute setup
- Immediate token savings
- No development needed

---

## ROI Calculator

### Formula

```
ROI = (Token Savings × Usage Frequency × Time Period) - Setup Cost
```

### Examples

**SSH MCP for daily Pi monitoring:**
```
Setup: 15 minutes
Usage: 1 check/day
Token savings: 1,200/check
30 days: 36,000 tokens saved
ROI: Positive after day 1
```

**Custom Homelab MCP:**
```
Development: 20 hours
Usage: 10 checks/day × 3 devices = 30 checks
Token savings: 2,400/check (75% reduction)
30 days: 30 × 30 × 2,400 = 2,160,000 tokens saved
ROI: Positive after ~10 days
```

**GitHub MCP for occasional use:**
```
Setup: 5 minutes
Usage: 1x/week
Token savings: 500/use
30 days: 2,000 tokens saved
ROI: Positive immediately
```

---

## MCP Selection Guide

### For SSH/Remote Operations

| MCP | Best For | Setup | Features | Recommend When |
|-----|----------|-------|----------|----------------|
| **ssh-mcp** (tufantunc) | Simple SSH | Easy | Basic commands | 1-2 devices, basic needs |
| **SSH-MCP** (mixelpixx) | VPS + network devices | Medium | Serial console | Network equipment |
| **mcp-server-ssh** (shaike1) | General purpose | Easy | Multi-session | Simple, clean interface |
| **Custom Homelab MCP** | Your infrastructure | Hard | Tailored tools | 3+ devices, specific needs |

### For Other Operations

| Operation | Recommended MCP | Setup | Notes |
|-----------|-----------------|-------|-------|
| GitHub | Official GitHub MCP | 5 min | Pre-built by Anthropic |
| Postgres | Official Postgres MCP | 5 min | SQL queries |
| Slack | Official Slack MCP | 5 min | Message history |
| Google Drive | Official Drive MCP | 10 min | OAuth required |
| File operations | ❌ Use Bash | N/A | Not worth MCP |
| Git operations | Official Git MCP | 5 min | Better than Bash |
| Docker | Docker MCP | 10 min | Container management |

---

## When NOT to Use MCP

### ❌ Don't Use MCP For:

1. **One-time tasks**
   - Initial setup
   - Rare migrations
   - Exploratory work

2. **Local file operations**
   - Reading files
   - Writing files
   - Editing files
   - (Built-in tools are better)

3. **Simple calculations**
   - Math operations
   - String manipulation
   - Data formatting

4. **Tasks with high setup costs**
   - If setup > 10× usage savings
   - Rarely used operations
   - Constantly changing requirements

### ✅ DO Use MCP For:

1. **Repetitive operations**
   - Daily checks
   - Regular updates
   - Monitoring tasks

2. **Remote system access**
   - SSH operations
   - Database queries
   - API calls

3. **Integration needs**
   - GitHub/GitLab
   - Slack/Discord
   - Cloud platforms

4. **Token-heavy operations**
   - Parsing large outputs
   - Multiple command chains
   - Complex data retrieval

---

## Token Savings by Operation Type

### High Savings (70-80%)

**Operations with high setup + parsing overhead:**
- System status checks
- Log retrieval and parsing
- Multi-step workflows
- Resource monitoring

**Example:**
```
Bash: ssh + env setup + command + parse output = 2,500 tokens
MCP: status_check(host) = 500 tokens
Savings: 80%
```

### Medium Savings (40-60%)

**Operations with structured output:**
- File transfers
- Service management
- Simple commands

**Example:**
```
Bash: rsync + progress parsing = 1,800 tokens
MCP: sync_files(src, dst) = 800 tokens
Savings: 55%
```

### Low Savings (20-30%)

**Operations already efficient:**
- Simple command execution
- Small output parsing
- Quick checks

**Example:**
```
Bash: ssh + simple command = 800 tokens
MCP: run_command(cmd) = 600 tokens
Savings: 25%
```

---

## Implementation Roadmap

### Phase 1: Quick Wins (Week 1)

**Goal:** Get immediate value with minimal effort

1. **Install SSH MCP** (15 min)
   - Choose: ssh-mcp (tufantunc)
   - Configure for raspberrypi3
   - Test basic operations

2. **Install GitHub MCP** (5 min)
   - If using GitHub frequently
   - Pre-built by Anthropic

3. **Measure baseline** (5 min)
   - Track current token usage
   - Document common operations

**Expected savings:** 40-60% on remote ops

---

### Phase 2: Optimization (Week 2-3)

**Goal:** Maximize value from existing MCPs

1. **Update skills** (2 hours)
   - Migrate monitoring tasks to MCP
   - Update backup procedures
   - Create new MCP-aware skills

2. **Document patterns** (1 hour)
   - Record token savings
   - Identify bottlenecks
   - Plan custom tools

3. **Install specialized MCPs** (1 hour)
   - Database MCP if needed
   - Docker MCP if managing containers
   - Cloud MCPs if using AWS/GCP

**Expected savings:** 50-70% on all ops

---

### Phase 3: Custom Development (Week 4+)

**Goal:** Build custom MCP if justified

1. **Evaluate ROI** (1 hour)
   - Calculate actual token usage
   - Estimate development time
   - Check if savings justify build

2. **Develop Homelab MCP** (20 hours)
   - Follow [homelab-mcp-spec.md](./homelab-mcp-spec.md)
   - Implement core tools first
   - Test incrementally

3. **Deploy and iterate** (4 hours)
   - Install in Claude Desktop
   - Update skills to use new tools
   - Monitor and optimize

**Expected savings:** 75-85% on all ops

---

## Decision Checklist

### Before Installing Any MCP

- [ ] Task is repeated >3 times
- [ ] Setup time < (savings × uses)
- [ ] No suitable built-in tool exists
- [ ] Token savings >30%

### Before Building Custom MCP

- [ ] Existing MCPs don't meet needs
- [ ] Development time is available (16-40 hours)
- [ ] Break-even < 30 days
- [ ] Long-term use expected (6+ months)
- [ ] Token savings >60%

### After Installing MCP

- [ ] Measure actual token usage
- [ ] Compare to Bash baseline
- [ ] Document savings
- [ ] Update skills to use MCP
- [ ] Share learnings (document)

---

## Your Specific Use Cases

### Current: Clawdbot on Raspberry Pi

**Daily monitoring:**
- ✅ Install SSH MCP
- ✅ Create `/pi-status` skill
- ✅ Use for daily checks

**Weekly maintenance:**
- ✅ Use SSH MCP for updates
- ✅ Automate backup with skill
- ✅ Monitor logs via MCP

**Future scaling (3+ Pis):**
- ⚠️ Consider custom Homelab MCP
- ⚠️ Build multi-device tools
- ⚠️ Orchestration capabilities

### Future: Infrastructure Growth

**When you add more devices:**

**1-2 devices:** SSH MCP sufficient
**3-5 devices:** Consider custom MCP
**6+ devices:** Definitely build custom MCP

**Custom MCP features to prioritize:**
1. Multi-device status checks
2. Rolling updates
3. Automated backups
4. Health monitoring dashboard

---

## Comparison: Your Use Cases

| Use Case | Current (Bash) | With SSH MCP | With Custom MCP |
|----------|----------------|--------------|-----------------|
| Daily Pi check | 2,500 tokens | 800 tokens | 400 tokens |
| Weekly logs | 2,000 tokens | 700 tokens | 300 tokens |
| Backup | 1,800 tokens | 600 tokens | 400 tokens |
| Service restart | 1,200 tokens | 400 tokens | 200 tokens |
| **Total/week** | **18,200** | **6,000** | **2,800** |
| **Savings** | 0% | 67% | 85% |
| **Monthly** | 72,800 | 24,000 | 11,200 |

---

## Action Items

### Immediate (This Week)

1. ✅ **Read this guide** - Understand tradeoffs
2. ✅ **Install SSH MCP** - Get immediate benefits
   - Follow: [ssh-mcp-quickstart.md](./ssh-mcp-quickstart.md)
3. ✅ **Test with Pi** - Verify savings
4. ✅ **Update one skill** - Migrate to MCP

### Short-term (This Month)

1. ⏱ **Measure actual savings** - Track tokens
2. ⏱ **Optimize workflows** - Use MCP more
3. ⏱ **Document patterns** - Share learnings
4. ⏱ **Evaluate custom MCP** - Check ROI

### Long-term (This Quarter)

1. 🔮 **Build custom MCP?** - If scaling up
2. 🔮 **Create orchestration** - Multi-device
3. 🔮 **Automate monitoring** - 24/7 checks
4. 🔮 **Share with community** - Help others

---

## Resources

### Decision Tools
- This guide - Use case analysis
- [README.md](./README.md) - Comprehensive overview
- [ssh-mcp-quickstart.md](./ssh-mcp-quickstart.md) - Quick setup

### Implementation
- [homelab-mcp-spec.md](./homelab-mcp-spec.md) - Custom MCP design
- [Official MCP Docs](https://modelcontextprotocol.io/) - Protocol spec
- [Claude MCP Guide](https://docs.anthropic.com/en/docs/claude-code/mcp) - Integration

### Discovery
- [Awesome MCP Servers](https://mcp-awesome.com/) - 1200+ servers
- [MCP Directory](https://mcpservers.org/) - Searchable index
- [PulseMCP](https://www.pulsemcp.com/) - Curated collection

---

## Summary

### The Rule of Thumb

**If you'll do it >3 times AND an MCP exists:** Use it
**If you'll do it >100 times AND no MCP exists:** Build it
**Otherwise:** Use Bash

### Token Savings Guide

| Frequency | Tool | Expected Savings |
|-----------|------|------------------|
| 1-2 times | Bash | N/A |
| 3-10 times | Existing MCP | 40-70% |
| 10-100 times | Existing MCP | 40-70% |
| 100+ times | Custom MCP | 70-85% |

### Your Next Steps

1. ✅ **Today:** Install SSH MCP (15 min)
2. ✅ **This week:** Test and measure (2 hours)
3. ⏱ **This month:** Optimize usage (5 hours)
4. 🔮 **Later:** Consider custom MCP (if needed)

---

*Decision made easy!*

---

**Sources:**
- [tufantunc/ssh-mcp](https://github.com/tufantunc/ssh-mcp) - SSH MCP Server
- [mixelpixx/SSH-MCP](https://github.com/mixelpixx/SSH-MCP) - Advanced SSH/Serial Console
- [MCP Official Docs](https://modelcontextprotocol.io/) - Protocol Documentation
- [Awesome MCP Servers](https://mcp-awesome.com/) - Server Directory
- [Top 10 MCP Servers 2026](https://dasroot.net/posts/2026/01/top-10-mcp-servers-2026/) - Curated Guide
- [Best MCP Servers](https://cyberpress.org/best-mcp-servers/) - Comparison Guide

*Last updated: February 11, 2026*
