#!/usr/bin/env python3
"""
Weekly Summary Generator
Aggregates daily journals into a weekly summary
"""

import os
import re
from datetime import datetime, timedelta
from pathlib import Path
from collections import defaultdict

JOURNAL_DIR = Path.home() / "Documents/textDump/05_JOURNAL"
OUTPUT_DIR = Path.home() / "Documents/textDump/05_JOURNAL"

def get_last_week_dates():
    """Get list of dates for last week (Mon-Sun)"""
    today = datetime.now()
    # Find last Sunday
    days_since_sunday = (today.weekday() + 1) % 7
    last_sunday = today - timedelta(days=days_since_sunday if days_since_sunday != 0 else 7)

    # Generate dates for the week
    week_dates = []
    for i in range(7):
        date = last_sunday - timedelta(days=6-i)
        week_dates.append(date)

    return week_dates

def parse_daily_journal(filepath):
    """Extract key information from a daily journal"""
    if not filepath.exists():
        return None

    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    data = {
        'date': None,
        'projects': set(),
        'commits': 0,
        'files_changed': 0,
        'activity_score': 0,
        'goals': [],
        'insights': [],
        'tags': set()
    }

    # Extract date
    date_match = re.search(r'daily-(\d{4}-\d{2}-\d{2})', filepath.name)
    if date_match:
        data['date'] = date_match.group(1)

    # Extract metrics
    score_match = re.search(r'Activity Score:.*?(\d+\.?\d*)', content)
    if score_match:
        data['activity_score'] = float(score_match.group(1))

    commits_match = re.search(r'Total Commits:.*?(\d+)', content)
    if commits_match:
        data['commits'] = int(commits_match.group(1))

    files_match = re.search(r'Files Changed:.*?(\d+)', content)
    if files_match:
        data['files_changed'] = int(files_match.group(1))

    # Extract projects (from commit lines)
    project_pattern = re.compile(r'\*\*([^*]+?)\*\*')
    data['projects'] = set(project_pattern.findall(content))

    # Extract tags
    tag_pattern = re.compile(r'#(\w+)')
    data['tags'] = set(tag_pattern.findall(content))

    # Extract goals (from Goals section)
    goals_section = re.search(r'## Goals\n(.*?)(?=\n##|\Z)', content, re.DOTALL)
    if goals_section:
        goals = re.findall(r'^[-*]\s*\[.\]\s*(.+)$', goals_section.group(1), re.MULTILINE)
        data['goals'] = goals

    # Extract insights (from Key Insights section)
    insights_section = re.search(r'## Key Insights\n(.*?)(?=\n##|\Z)', content, re.DOTALL)
    if insights_section:
        insights = re.findall(r'^[-*]\s+(.+)$', insights_section.group(1), re.MULTILINE)
        data['insights'] = insights

    return data

def generate_weekly_summary(week_dates):
    """Generate a comprehensive weekly summary"""
    week_start = week_dates[0].strftime('%Y-%m-%d')
    week_end = week_dates[-1].strftime('%Y-%m-%d')

    summary = {
        'total_commits': 0,
        'total_files': 0,
        'total_activity': 0,
        'active_days': 0,
        'projects': defaultdict(int),
        'tags': defaultdict(int),
        'all_insights': [],
        'all_goals': [],
        'daily_scores': []
    }

    # Collect data from each day
    for date in week_dates:
        journal_file = JOURNAL_DIR / f"daily-{date.strftime('%Y-%m-%d')}.md"
        data = parse_daily_journal(journal_file)

        if data:
            summary['total_commits'] += data['commits']
            summary['total_files'] += data['files_changed']
            summary['total_activity'] += data['activity_score']

            if data['commits'] > 0:
                summary['active_days'] += 1

            summary['daily_scores'].append({
                'date': data['date'],
                'score': data['activity_score'],
                'commits': data['commits']
            })

            for project in data['projects']:
                summary['projects'][project] += 1

            for tag in data['tags']:
                summary['tags'][tag] += 1

            summary['all_insights'].extend(data['insights'])
            summary['all_goals'].extend(data['goals'])

    # Generate markdown report
    report = f"""# Weekly Summary: {week_start} to {week_end}

## Overview

- **Active Days:** {summary['active_days']}/7
- **Total Commits:** {summary['total_commits']}
- **Files Changed:** {summary['total_files']}
- **Total Activity Score:** {summary['total_activity']:.2f}
- **Average Daily Score:** {summary['total_activity'] / 7:.2f}

## Daily Activity

"""

    for day_data in summary['daily_scores']:
        if day_data['date']:
            day_name = datetime.strptime(day_data['date'], '%Y-%m-%d').strftime('%A')
            bar = '█' * int(day_data['score'] / 100) if day_data['score'] > 0 else '○'
            report += f"- **{day_name} ({day_data['date']})**: {day_data['commits']} commits, score {day_data['score']:.0f} {bar}\n"

    # Top projects
    if summary['projects']:
        report += "\n## Top Projects\n\n"
        sorted_projects = sorted(summary['projects'].items(), key=lambda x: x[1], reverse=True)
        for project, count in sorted_projects[:5]:
            report += f"- **{project}** ({count} days)\n"

    # Top tags
    if summary['tags']:
        report += "\n## Top Tags\n\n"
        sorted_tags = sorted(summary['tags'].items(), key=lambda x: x[1], reverse=True)
        for tag, count in sorted_tags[:10]:
            report += f"- #{tag} ({count})\n"

    # Key insights from the week
    if summary['all_insights']:
        report += "\n## Key Insights This Week\n\n"
        unique_insights = list(set(summary['all_insights']))[:10]
        for insight in unique_insights:
            report += f"- {insight}\n"

    # Goals completed/tracked
    if summary['all_goals']:
        report += "\n## Goals Tracked\n\n"
        unique_goals = list(set(summary['all_goals']))[:10]
        for goal in unique_goals:
            report += f"- {goal}\n"

    report += "\n## Reflection Prompts\n\n"
    report += "- What was your biggest win this week?\n"
    report += "- What challenged you the most?\n"
    report += "- What would you like to focus on next week?\n"
    report += "- Any patterns you noticed in your work?\n"

    report += f"\n---\n*Generated automatically on {datetime.now().strftime('%Y-%m-%d %H:%M')}*\n"

    return report

def main():
    """Main execution"""
    print(f"Generating weekly summary...")

    week_dates = get_last_week_dates()
    week_start = week_dates[0].strftime('%Y-%m-%d')
    week_end = week_dates[-1].strftime('%Y-%m-%d')

    print(f"Week: {week_start} to {week_end}")

    summary = generate_weekly_summary(week_dates)

    # Save to file
    output_file = OUTPUT_DIR / f"weekly-summary-{week_end}.md"
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(summary)

    print(f"✓ Summary saved to: {output_file}")
    print(f"\nPreview:\n{summary[:500]}...")

if __name__ == "__main__":
    main()
