# Journal Automation Agent - Quick Start Guide

## ✅ Installation Complete!

The daily journal automation agent has been successfully installed and tested.

## 📁 Project Location

```
/home/capicuaman/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation/
```

## 🚀 Quick Commands

### Test the script (safe - won't modify your journals):
```bash
cd /home/capicuaman/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation

# Dry run - see what would be generated
python3 journal_agent.py --dry-run --verbose

# Test mode - write to /tmp directory
python3 journal_agent.py --test-mode --verbose
```

### Generate for today:
```bash
python3 journal_agent.py --live --verbose
```

### Force update (ignore activity threshold):
```bash
python3 journal_agent.py --force --live --verbose
```

### Generate for specific date:
```bash
python3 journal_agent.py --date 2025-11-05 --live --verbose
```

## 📋 What It Does

✅ **Tracks work** across 3 repositories (textDump, bilan-mx, bilan-video)
✅ **Analyzes git commits** and groups by time (morning/afternoon/evening)
✅ **Calculates metrics** (focus time, deep work sessions, productivity score)
✅ **Generates tags** automatically from projects and commit messages
✅ **Creates wiki-style links** to files you worked on
✅ **Preserves manual entries** while updating auto-generated sections

## 📊 Test Results

Successfully tested with November 5, 2025 data:
- ✅ Found 3 commits across repositories
- ✅ Activity score: 70.90 (above threshold)
- ✅ Generated daily log entries for afternoon & evening
- ✅ Calculated focus time: 1.0 hours, 2 deep work sessions
- ✅ Created 4 related note links
- ✅ Generated tags: #textdump #documentation
- ✅ Preserved existing manual sections (Goals, Insights, Reflection)
- ✅ No duplication in output

## 🤖 Setting Up Automation (Cron)

### Option 1: Every 2 hours during work hours (10am-8pm)

```bash
# Edit crontab
crontab -e

# Add this line:
0 10,12,14,16,18,20 * * * /usr/bin/python3 /home/capicuaman/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation/journal_agent.py --live >> /home/capicuaman/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation/cron.log 2>&1
```

### Option 2: Once at end of day (8pm)

```bash
0 20 * * * /usr/bin/python3 /home/capicuaman/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation/journal_agent.py --live >> /home/capicuaman/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation/cron.log 2>&1
```

### Test cron job:
```bash
# Test manually first
/usr/bin/python3 /home/capicuaman/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation/journal_agent.py --dry-run

# View cron logs (after cron runs)
tail -f /home/capicuaman/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation/cron.log

# List current cron jobs
crontab -l
```

## 🔧 Configuration

Edit `config.json` to adjust:
- Repository paths and weights
- Activity thresholds (when to update)
- Feature toggles
- Logging settings

## 📖 Full Documentation

See `README.md` for comprehensive documentation including:
- Detailed usage instructions
- Configuration options
- Advanced features
- Troubleshooting guide
- Edge cases handled

## 🎯 Next Steps

1. **Test with your workflow** - Run a few times manually to see how it works
2. **Adjust thresholds** - Edit `config.json` if activity scores seem too high/low
3. **Set up cron** - Choose a schedule that fits your work pattern
4. **Monitor logs** - Check `journal_agent.log` and `cron.log` for first week

## 💡 Tips

- Use `--dry-run` to preview changes before writing
- Use `--test-mode` to write to /tmp for safe testing
- Use `--force` to override activity thresholds
- Check logs if something seems wrong: `tail -f journal_agent.log`
- The script preserves your manual edits - safe to run multiple times

## 🔗 Key Files

- `journal_agent.py` - Main automation script
- `config.json` - Configuration settings
- `README.md` - Full documentation
- `journal_agent.log` - Execution logs
- `cron.log` - Cron job logs (after setup)

## 🎉 You're All Set!

The agent is ready to automate your daily journal entries while preserving your manual reflections and insights.

Happy journaling! 📝
