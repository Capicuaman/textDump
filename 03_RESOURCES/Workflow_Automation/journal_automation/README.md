# Daily Journal Automation Agent

Automated agent that tracks work across git repositories and generates/updates daily journal entries while preserving manual edits.

## Overview

This Python script analyzes git commits across multiple repositories and automatically populates your daily journal with:

- **Git activity tracking** - Commits grouped by time of day (morning/afternoon/evening)
- **Activity metrics** - Focus time, deep work sessions, productivity scores
- **Related notes** - Wiki-style links to files you worked on
- **Auto-generated tags** - Based on projects and work themes
- **Smart merging** - Preserves your manual entries while updating auto-generated sections

## Features

### Work Detection Algorithm

The script calculates an **activity score** to determine when updates are needed:

```
activity_score = (commits × 10) + (files_changed × 2) + (lines_changed × 0.1) + (file_types × 5)
```

**Update triggers:**
- Score ≥ 50: High activity
- Score ≥ 20: Normal activity
- Score < 20: Low activity (single end-of-day update)

### Auto-Populated Sections

- ✅ **Date & Context** - System date, day of week
- ✅ **Daily Log** - Commits grouped by time period (morning/afternoon/evening)
- ✅ **Metrics & Tracking** - Focus time, deep work sessions, productivity score
- ✅ **Related Notes** - Wiki-style links to files changed
- ✅ **Tags** - Auto-generated from projects touched

### Manual Sections (Preserved)

- 🔒 **Today's Goals** - Your manually entered goals
- 🔒 **Insights & Learnings** - Your reflections
- 🔒 **Reflection** - What went well, challenges, lessons, gratitude
- 🔒 **Tomorrow's Preview** - Your plans for tomorrow

### Smart Merge Strategy

The script intelligently merges new content with existing journals:

1. Detects manually-edited content (non-placeholder text)
2. Updates ONLY auto-generated sections
3. Appends to Daily Log without overwriting manual entries
4. Adds timestamp marker: `<!-- Last auto-update: YYYY-MM-DD HH:MM -->`

## Installation

### Prerequisites

- Python 3.7+ (standard library only, no pip installs needed)
- Git (already available)
- Access to git repositories defined in config

### Setup

1. **Clone or navigate to the project directory:**
   ```bash
   cd /home/capicuaman/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation
   ```

2. **Make the script executable:**
   ```bash
   chmod +x journal_agent.py
   ```

3. **Verify configuration:**
   - Edit `config.json` if needed
   - Ensure repository paths are correct
   - Adjust activity thresholds as desired

## Configuration

The `config.json` file contains all settings:

```json
{
  "repositories": [
    {
      "name": "textDump",
      "path": "/home/capicuaman/Documents/textDump",
      "weight": 1.0,
      "enabled": true
    },
    {
      "name": "bilan-mx",
      "path": "/home/capicuaman/Documents/bilan-mx",
      "weight": 0.8,
      "enabled": true
    },
    {
      "name": "bilan-video",
      "path": "/home/capicuaman/Documents/bilan-video",
      "weight": 1.0,
      "enabled": true
    }
  ],
  "journal": {
    "directory": "/home/capicuaman/Documents/textDump/05_JOURNAL/",
    "template_path": "/home/capicuaman/Documents/textDump/05_JOURNAL/daily-note-template.md"
  },
  "thresholds": {
    "high_activity": 50,
    "medium_activity": 20,
    "min_commits": 1
  },
  "features": {
    "preserve_manual_edits": true,
    "auto_generate_tags": true,
    "create_related_notes": true
  },
  "logging": {
    "enabled": true,
    "level": "INFO",
    "file": "journal_agent.log"
  }
}
```

### Configuration Options

**Repositories:**
- `name` - Display name for the repository
- `path` - Absolute path to git repository
- `weight` - Importance multiplier (0.0-1.0+)
- `enabled` - Whether to analyze this repo

**Thresholds:**
- `high_activity` - Score threshold for high activity
- `medium_activity` - Score threshold for medium activity
- `min_commits` - Minimum commits required to generate entry

**Features:**
- `preserve_manual_edits` - Keep user-entered content (recommended: true)
- `auto_generate_tags` - Generate tags from commit messages
- `create_related_notes` - Add wiki-style links to changed files

## Usage

### Basic Commands

**Dry run (print to console, don't write files):**
```bash
python3 journal_agent.py --dry-run --verbose
```

**Test mode (write to /tmp instead of live journal):**
```bash
python3 journal_agent.py --test-mode --verbose
```

**Generate for specific date:**
```bash
python3 journal_agent.py --date 2025-02-10 --dry-run
```

**Live mode (write to actual journal):**
```bash
python3 journal_agent.py --live --verbose
```

**Force update (ignore activity threshold):**
```bash
python3 journal_agent.py --force --live
```

### CLI Options

| Option | Description |
|--------|-------------|
| `--dry-run` | Print to console without writing files |
| `--test-mode` | Write to `/tmp/journal_test/` instead of live directory |
| `--date YYYY-MM-DD` | Generate for specific date |
| `--force` | Force update even if activity is low |
| `--verbose` | Enable verbose logging output |
| `--live` | Run in live mode (writes to journal directory) |

## Testing

### Safe Testing Workflow

**Always test before running live!**

```bash
# Step 1: Dry run to see what would be generated
python3 journal_agent.py --dry-run --verbose

# Step 2: Test mode to write to temporary directory
python3 journal_agent.py --test-mode --verbose

# Step 3: Check the output
cat /tmp/journal_test/daily-$(date +%Y-%m-%d).md

# Step 4: Test with a past date (compare against existing journal)
python3 journal_agent.py --date 2025-02-10 --dry-run

# Step 5: If everything looks good, run live
python3 journal_agent.py --live --verbose
```

### Verification Checklist

After testing, verify:

- [ ] All commits from test date are captured
- [ ] Commits correctly categorized by time period
- [ ] Activity score makes sense
- [ ] Manual edits preserved (if testing with existing file)
- [ ] Template structure maintained
- [ ] Wiki-style links are valid
- [ ] No duplicate entries
- [ ] Timestamp marker added

## Automated Scheduling (Cron)

### Setup Cron Job

To run the agent automatically every 2 hours during work hours:

```bash
# Edit crontab
crontab -e

# Add this line (runs every 2 hours from 10am to 8pm)
0 10,12,14,16,18,20 * * * /usr/bin/python3 /home/capicuaman/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation/journal_agent.py --live >> /home/capicuaman/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation/cron.log 2>&1
```

### Alternative Schedules

**Every 2 hours all day:**
```cron
0 */2 * * * /usr/bin/python3 /path/to/journal_agent.py --live >> /path/to/cron.log 2>&1
```

**Once at end of day only:**
```cron
0 20 * * * /usr/bin/python3 /path/to/journal_agent.py --live >> /path/to/cron.log 2>&1
```

**Every hour during work hours:**
```cron
0 9-18 * * * /usr/bin/python3 /path/to/journal_agent.py --live >> /path/to/cron.log 2>&1
```

### Cron Schedule Format

```
┌───────────── minute (0 - 59)
│ ┌───────────── hour (0 - 23)
│ │ ┌───────────── day of month (1 - 31)
│ │ │ ┌───────────── month (1 - 12)
│ │ │ │ ┌───────────── day of week (0 - 6) (Sunday=0)
│ │ │ │ │
│ │ │ │ │
* * * * * command to execute
```

### Testing Cron Setup

```bash
# Test that cron can execute the script
/usr/bin/python3 /home/capicuaman/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation/journal_agent.py --dry-run

# View cron logs
tail -f /home/capicuaman/Documents/textDump/03_RESOURCES/Workflow_Automation/journal_automation/cron.log

# List current cron jobs
crontab -l
```

## Logging

The script logs all activity to `journal_agent.log` in the project directory.

**View recent logs:**
```bash
tail -f journal_agent.log
```

**View errors only:**
```bash
grep ERROR journal_agent.log
```

**Clear logs:**
```bash
> journal_agent.log
```

## Troubleshooting

### Common Issues

**No commits found:**
- Check repository paths in `config.json`
- Verify git repositories have commits for target date
- Run with `--verbose` to see detailed output

**Activity score too low:**
- Adjust thresholds in `config.json`
- Use `--force` flag to override
- Check commit activity: `git log --since="2025-02-11 00:00" --until="2025-02-11 23:59"`

**Manual edits overwritten:**
- Verify `preserve_manual_edits` is `true` in config
- Check that manual content isn't just placeholders (`_____`)
- Review merge logic with `--test-mode` first

**Cron job not running:**
- Check cron logs: `tail -f cron.log`
- Verify Python path: `which python3`
- Test script manually with full path
- Check cron service is running: `systemctl status cron`

**Permission errors:**
- Ensure script is executable: `chmod +x journal_agent.py`
- Check journal directory permissions
- Verify git repository access

### Debug Mode

Run with maximum verbosity:
```bash
python3 journal_agent.py --dry-run --verbose 2>&1 | tee debug.log
```

## Project Structure

```
journal_automation/
├── journal_agent.py    # Main automation script
├── config.json         # Configuration file
├── README.md          # This file
├── journal_agent.log  # Execution logs (created on first run)
└── cron.log           # Cron job logs (created when using cron)
```

## How It Works

### 1. Git Analysis

For each enabled repository:
- Fetches commits for target date using `git log`
- Extracts commit metadata (hash, timestamp, subject, author)
- Gets files changed with `git diff-tree`
- Gets lines added/deleted with `git show --stat`
- Groups commits by time period (morning/afternoon/evening)
- Calculates activity score

### 2. Template Processing

- Loads journal template from `05_JOURNAL/daily-note-template.md`
- Populates date/context fields
- Generates daily log entries from commits
- Calculates metrics (focus time, deep work sessions)
- Creates wiki-style links to changed files
- Generates tags from projects and keywords

### 3. Smart Merging

If existing journal exists:
- Parses both old and new content into sections
- Identifies manual vs auto-generated content
- Preserves manual sections (Goals, Insights, Reflection)
- Updates auto sections (Daily Log, Metrics, Related Notes)
- Appends to Daily Log instead of replacing
- Adds timestamp marker

### 4. Output

Depending on mode:
- **Dry run:** Prints to console
- **Test mode:** Writes to `/tmp/journal_test/`
- **Live mode:** Writes to `05_JOURNAL/daily-YYYY-MM-DD.md`

## Advanced Usage

### Backfilling Past Dates

Generate journals for past dates:

```bash
# Generate for last week
for i in {1..7}; do
  date=$(date -d "-$i days" +%Y-%m-%d)
  python3 journal_agent.py --date $date --live --verbose
done
```

### Custom Activity Thresholds

Edit `config.json` to adjust when updates trigger:

```json
"thresholds": {
  "high_activity": 100,    // Very high threshold (fewer updates)
  "medium_activity": 50,   // Medium threshold
  "min_commits": 2         // Require at least 2 commits
}
```

### Disable Specific Repositories

Temporarily disable a repository:

```json
{
  "name": "bilan-video",
  "path": "/home/capicuaman/Documents/bilan-video",
  "weight": 1.0,
  "enabled": false  // Set to false
}
```

### Adjust Repository Weights

Make some repositories more important:

```json
{
  "name": "textDump",
  "path": "/home/capicuaman/Documents/textDump",
  "weight": 2.0,  // Double the importance
  "enabled": true
}
```

## Future Enhancements

See the implementation plan for potential future features:

- File system monitoring (non-git activity)
- Application time tracking integration
- Task extraction from code comments
- AI-powered commit summarization
- Weather API integration
- Calendar integration for meetings
- Weekly/monthly summary generation
- Data visualization and analytics

## Dependencies

**Required:**
- Python 3.7+ (standard library only)
- Git
- Access to configured repositories

**Optional:**
- Cron (for scheduling)

## Support & Documentation

**Project files:**
- Implementation plan: See project planning document
- Template: `05_JOURNAL/daily-note-template.md`
- Example journals: `05_JOURNAL/daily-2025-11-*.md`
- Python style reference: `textDump/summarize_science_points.py`

**Useful commands:**
```bash
# Check git status for today
git log --since="today" --oneline

# View template
cat /home/capicuaman/Documents/textDump/05_JOURNAL/daily-note-template.md

# View existing journal
cat /home/capicuaman/Documents/textDump/05_JOURNAL/daily-$(date +%Y-%m-%d).md
```

## License

Personal use project - part of textDump knowledge management system.

---

**Last updated:** 2025-02-11
**Version:** 1.0.0
