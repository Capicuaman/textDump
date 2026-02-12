#!/usr/bin/env python3
"""
Daily Journal Automation Agent

Automatically tracks work across git repositories and generates/updates daily journal entries.
Preserves manual edits while updating auto-generated sections based on git activity.

Usage:
    python3 journal_agent.py [options]

Options:
    --dry-run       Print output to console without writing files
    --test-mode     Write to /tmp/journal_test/ instead of live journal directory
    --date DATE     Generate for specific date (YYYY-MM-DD format)
    --force         Force update even if activity is low
    --verbose       Enable verbose logging output
    --live          Run in live mode (default if no other mode specified)
"""

import json
import subprocess
import re
import os
import sys
import argparse
from datetime import datetime, timedelta
from pathlib import Path
from typing import Dict, List, Tuple, Optional


# --- Configuration ---
SCRIPT_DIR = Path(__file__).parent
CONFIG_FILE = SCRIPT_DIR / 'config.json'
LOG_FILE = SCRIPT_DIR / 'journal_agent.log'


# --- Logging ---
class Logger:
    """Simple logger for tracking script execution"""

    def __init__(self, verbose=False, log_file=None):
        self.verbose = verbose
        self.log_file = log_file

    def log(self, message, level='INFO'):
        """Log a message with timestamp"""
        timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        log_line = f"[{timestamp}] [{level}] {message}"

        if self.verbose or level == 'ERROR':
            print(log_line)

        if self.log_file:
            try:
                with open(self.log_file, 'a') as f:
                    f.write(log_line + '\n')
            except Exception as e:
                print(f"Warning: Could not write to log file: {e}")

    def info(self, message):
        self.log(message, 'INFO')

    def error(self, message):
        self.log(message, 'ERROR')

    def debug(self, message):
        if self.verbose:
            self.log(message, 'DEBUG')


# --- 1. Configuration Loading ---
def load_config(config_path: Path) -> Dict:
    """Load configuration from JSON file"""
    try:
        with open(config_path, 'r') as f:
            return json.load(f)
    except (FileNotFoundError, json.JSONDecodeError) as e:
        print(f"Error loading config file: {e}")
        sys.exit(1)


# --- 2. Git Analysis Module ---
class GitAnalyzer:
    """Analyzes git repositories for commit activity"""

    def __init__(self, logger: Logger):
        self.logger = logger

    def run_git_command(self, repo_path: str, command: List[str]) -> Optional[str]:
        """Run a git command and return the output"""
        try:
            result = subprocess.run(
                ['git', '-C', repo_path] + command,
                capture_output=True,
                text=True,
                check=True
            )
            return result.stdout.strip()
        except subprocess.CalledProcessError as e:
            self.logger.error(f"Git command failed in {repo_path}: {e}")
            return None
        except Exception as e:
            self.logger.error(f"Error running git command: {e}")
            return None

    def get_commits_for_date(self, repo_path: str, target_date: datetime) -> List[Dict]:
        """Get all commits for a specific date"""
        date_str = target_date.strftime('%Y-%m-%d')
        since = f"{date_str} 00:00:00"
        until = f"{date_str} 23:59:59"

        # Get commit log with detailed information
        log_format = '%H|%at|%s|%an'  # hash|timestamp|subject|author
        commits_raw = self.run_git_command(
            repo_path,
            ['log', f'--since={since}', f'--until={until}', f'--format={log_format}', '--all']
        )

        if not commits_raw:
            return []

        commits = []
        for line in commits_raw.split('\n'):
            if not line:
                continue

            parts = line.split('|')
            if len(parts) < 4:
                continue

            commit_hash, timestamp, subject, author = parts[0], parts[1], parts[2], parts[3]

            # Get files changed for this commit
            files_changed = self.get_files_changed(repo_path, commit_hash)

            # Get lines changed
            lines_added, lines_deleted = self.get_lines_changed(repo_path, commit_hash)

            commits.append({
                'hash': commit_hash,
                'timestamp': int(timestamp),
                'datetime': datetime.fromtimestamp(int(timestamp)),
                'subject': subject,
                'author': author,
                'files_changed': files_changed,
                'lines_added': lines_added,
                'lines_deleted': lines_deleted
            })

        return commits

    def get_files_changed(self, repo_path: str, commit_hash: str) -> List[str]:
        """Get list of files changed in a commit"""
        files_raw = self.run_git_command(
            repo_path,
            ['diff-tree', '--no-commit-id', '--name-only', '-r', commit_hash]
        )

        if not files_raw:
            return []

        return [f.strip() for f in files_raw.split('\n') if f.strip()]

    def get_lines_changed(self, repo_path: str, commit_hash: str) -> Tuple[int, int]:
        """Get number of lines added and deleted in a commit"""
        stats = self.run_git_command(
            repo_path,
            ['show', '--stat', '--format=', commit_hash]
        )

        if not stats:
            return 0, 0

        # Parse the summary line: "X files changed, Y insertions(+), Z deletions(-)"
        match = re.search(r'(\d+) insertion.*?(\d+) deletion', stats)
        if match:
            return int(match.group(1)), int(match.group(2))

        # Check for only insertions
        match = re.search(r'(\d+) insertion', stats)
        if match:
            return int(match.group(1)), 0

        # Check for only deletions
        match = re.search(r'(\d+) deletion', stats)
        if match:
            return 0, int(match.group(1))

        return 0, 0

    def group_commits_by_time(self, commits: List[Dict]) -> Dict[str, List[Dict]]:
        """Group commits into morning/afternoon/evening periods"""
        periods = {
            'morning': [],    # 6:00 - 12:00
            'afternoon': [],  # 12:00 - 18:00
            'evening': []     # 18:00 - 22:00
        }

        for commit in commits:
            hour = commit['datetime'].hour

            if 6 <= hour < 12:
                periods['morning'].append(commit)
            elif 12 <= hour < 18:
                periods['afternoon'].append(commit)
            elif 18 <= hour <= 22:
                periods['evening'].append(commit)
            else:
                # Late night commits go to evening with a note
                commit['late_night'] = True
                periods['evening'].append(commit)

        return periods

    def calculate_activity_score(self, all_commits: List[Dict], repo_weight: float = 1.0) -> float:
        """Calculate activity score based on git activity"""
        if not all_commits:
            return 0.0

        num_commits = len(all_commits)
        total_files = sum(len(c['files_changed']) for c in all_commits)
        total_lines = sum(c['lines_added'] + c['lines_deleted'] for c in all_commits)

        # Count unique file types
        file_extensions = set()
        for commit in all_commits:
            for file in commit['files_changed']:
                ext = Path(file).suffix
                if ext:
                    file_extensions.add(ext)

        # Activity score formula from the plan
        score = (num_commits * 10) + (total_files * 2) + (total_lines * 0.1) + (len(file_extensions) * 5)

        # Apply repository weight
        weighted_score = score * repo_weight

        return weighted_score


# --- 3. Template Processing Module ---
class TemplateProcessor:
    """Processes journal templates and populates with data"""

    def __init__(self, template_path: str, logger: Logger):
        self.template_path = template_path
        self.logger = logger
        self.template_content = self._load_template()

    def _load_template(self) -> str:
        """Load the template file"""
        try:
            with open(self.template_path, 'r') as f:
                return f.read()
        except Exception as e:
            self.logger.error(f"Error loading template: {e}")
            return ""

    def generate_journal_entry(
        self,
        target_date: datetime,
        repos_data: Dict[str, Dict],
        activity_score: float
    ) -> str:
        """Generate a complete journal entry from template and data"""

        # Start with template
        content = self.template_content

        # Basic date/time replacements
        content = self._populate_date_context(content, target_date)

        # Populate daily log from git commits
        content = self._populate_daily_log(content, repos_data)

        # Populate metrics from git data
        content = self._populate_metrics(content, repos_data, activity_score)

        # Populate related notes (wiki links to changed files)
        content = self._populate_related_notes(content, repos_data)

        # Generate tags
        content = self._populate_tags(content, target_date, repos_data)

        # Add auto-update timestamp
        content = self._add_auto_update_marker(content)

        return content

    def _populate_date_context(self, content: str, target_date: datetime) -> str:
        """Populate date and context section"""
        now = datetime.now()

        replacements = {
            '{{DATE}}': target_date.strftime('%B %d, %Y'),
            '{{DAY_OF_WEEK}}': target_date.strftime('%A'),
            '{{YEAR}}': target_date.strftime('%Y'),
            '{{MONTH}}': target_date.strftime('%B'),
            '{{WEEK_NUMBER}}': f"Week{target_date.strftime('%U')}",
            '{{TEMPLATE_CREATION_DATE}}': target_date.strftime('%B %d, %Y'),
            '{{LAST_MODIFIED_DATE}}': now.strftime('%B %d, %Y'),
        }

        # Leave weather and mood as placeholders for manual entry
        replacements['{{WEATHER_CONDITIONS}}'] = '_____'
        replacements['{{TEMPERATURE}}'] = '_____'
        replacements['{{MOOD_EMOJI}}'] = '😊'
        replacements['{{MOOD_DESCRIPTION}}'] = '_____'

        for placeholder, value in replacements.items():
            content = content.replace(placeholder, value)

        return content

    def _populate_daily_log(self, content: str, repos_data: Dict[str, Dict]) -> str:
        """Populate daily log section with git commits"""

        # Aggregate all commits by time period
        all_periods = {
            'morning': [],
            'afternoon': [],
            'evening': []
        }

        for repo_name, repo_info in repos_data.items():
            periods = repo_info.get('periods', {})
            for period, commits in periods.items():
                for commit in commits:
                    # Add repo context to commit
                    commit_with_repo = commit.copy()
                    commit_with_repo['repo'] = repo_name
                    all_periods[period].append(commit_with_repo)

        # Generate activity entries for each period
        morning_entries = self._generate_period_entries(all_periods['morning'])
        afternoon_entries = self._generate_period_entries(all_periods['afternoon'])
        evening_entries = self._generate_period_entries(all_periods['evening'])

        # Replace placeholders
        content = self._replace_activity_placeholders(content, 'MORNING', morning_entries)
        content = self._replace_activity_placeholders(content, 'AFTERNOON', afternoon_entries)
        content = self._replace_activity_placeholders(content, 'EVENING', evening_entries)

        return content

    def _generate_period_entries(self, commits: List[Dict]) -> List[str]:
        """Generate human-readable activity entries from commits"""
        if not commits:
            return ['_____']

        entries = []

        # Group commits by project/topic
        for commit in commits:
            repo = commit.get('repo', 'unknown')
            subject = commit['subject']
            time_str = commit['datetime'].strftime('%H:%M')

            # Check for late night flag
            late_night = commit.get('late_night', False)
            time_note = f" (late night: {time_str})" if late_night else ""

            entry = f"Worked on {repo}: {subject}{time_note}"
            entries.append(entry)

        return entries

    def _replace_activity_placeholders(self, content: str, period: str, entries: List[str]) -> str:
        """Replace activity placeholders for a specific time period"""
        # Find the section for this period
        period_header = f"### {period.capitalize()}"

        if period_header not in content:
            return content

        # Replace numbered placeholders
        for i in range(1, 10):  # Support up to 9 placeholders
            placeholder = f"{{{{{period}_ACTIVITY_{i}}}}}"
            if i <= len(entries):
                content = content.replace(placeholder, entries[i-1])
            else:
                # Remove extra placeholders
                content = content.replace(f"- {placeholder}\n", "")

        return content

    def _populate_metrics(self, content: str, repos_data: Dict[str, Dict], activity_score: float) -> str:
        """Populate metrics section with git-derived data"""

        # Calculate total commits
        total_commits = sum(len(repo['commits']) for repo in repos_data.values())

        # Estimate focus time (rough calculation based on commit time spread)
        focus_hours = self._estimate_focus_time(repos_data)

        # Count deep work sessions (continuous commit periods)
        deep_work_sessions = self._count_deep_work_sessions(repos_data)

        # Calculate productivity score (normalized activity score)
        productivity_score = min(10, int(activity_score / 10))

        replacements = {
            '{{FOCUS_HOURS}}': str(focus_hours),
            '{{DEEP_WORK_SESSIONS}}': str(deep_work_sessions),
            '{{MEETING_COUNT}}': '0',  # Can't track from git
            '{{ENERGY_LEVEL}}': '_____',
            '{{PRODUCTIVITY_SCORE}}': str(productivity_score)
        }

        for placeholder, value in replacements.items():
            content = content.replace(placeholder, value)

        return content

    def _estimate_focus_time(self, repos_data: Dict[str, Dict]) -> float:
        """Estimate focus time based on commit timestamps"""
        all_timestamps = []

        for repo_info in repos_data.values():
            for commit in repo_info.get('commits', []):
                all_timestamps.append(commit['timestamp'])

        if len(all_timestamps) < 2:
            return 0.5 if all_timestamps else 0.0

        # Sort timestamps
        all_timestamps.sort()

        # Calculate time gaps between commits
        # Group commits within 2-hour windows as continuous work
        focus_time = 0.0
        current_session_start = all_timestamps[0]

        for i in range(1, len(all_timestamps)):
            gap = (all_timestamps[i] - all_timestamps[i-1]) / 3600  # Convert to hours

            if gap <= 2:  # Within 2 hours = same session
                continue
            else:
                # End current session
                session_duration = (all_timestamps[i-1] - current_session_start) / 3600
                focus_time += max(0.5, session_duration)  # Minimum 30 min per session
                current_session_start = all_timestamps[i]

        # Add final session
        final_duration = (all_timestamps[-1] - current_session_start) / 3600
        focus_time += max(0.5, final_duration)

        return round(focus_time, 1)

    def _count_deep_work_sessions(self, repos_data: Dict[str, Dict]) -> int:
        """Count deep work sessions (continuous commit periods)"""
        all_timestamps = []

        for repo_info in repos_data.values():
            for commit in repo_info.get('commits', []):
                all_timestamps.append(commit['timestamp'])

        if not all_timestamps:
            return 0

        all_timestamps.sort()

        # Count sessions (gaps > 2 hours start new session)
        sessions = 1
        for i in range(1, len(all_timestamps)):
            gap = (all_timestamps[i] - all_timestamps[i-1]) / 3600
            if gap > 2:
                sessions += 1

        return sessions

    def _populate_related_notes(self, content: str, repos_data: Dict[str, Dict]) -> str:
        """Populate related notes with wiki-style links to changed files"""

        # Collect unique files changed across all repos
        all_files = set()
        for repo_name, repo_info in repos_data.items():
            commits = repo_info.get('commits', [])
            self.logger.debug(f"Processing {len(commits)} commits from {repo_name}")
            for commit in commits:
                files = commit.get('files_changed', [])
                self.logger.debug(f"  Commit {commit.get('hash', '')[:8]}: {len(files)} files")
                all_files.update(files)

        self.logger.debug(f"Total unique files changed: {len(all_files)}")

        # Convert to wiki-style links
        # Focus on documentation and important files (md, py, js, etc.)
        important_extensions = {'.md', '.py', '.js', '.ts', '.jsx', '.tsx', '.html', '.css'}

        related_links = []
        for file in sorted(all_files):
            ext = Path(file).suffix
            if ext in important_extensions:
                # Create wiki-style link
                link = f"[[{file}]]"
                related_links.append(link)
                self.logger.debug(f"  Added related note: {link}")

        # Limit to top 5 most relevant
        related_links = related_links[:5]

        self.logger.debug(f"Final related links count: {len(related_links)}")

        if not related_links:
            related_links = ['_____', '_____', '_____']

        # Replace placeholders (template uses [[RELATED_NOTE_X]] format)
        for i in range(1, 10):
            placeholder = f"[[RELATED_NOTE_{i}]]"
            if i <= len(related_links):
                content = content.replace(placeholder, related_links[i-1])
            else:
                content = content.replace(f"- {placeholder}\n", "")

        return content

    def _populate_tags(self, content: str, target_date: datetime, repos_data: Dict[str, Dict]) -> str:
        """Generate and populate tags"""

        tags = []

        # Add repo-based tags (without # prefix - template adds it)
        for repo_name in repos_data.keys():
            if repos_data[repo_name].get('commits'):
                # Sanitize repo name for tag
                tag_name = repo_name.replace('-', '_').lower()
                if tag_name not in tags:
                    tags.append(tag_name)

        # Add any custom theme tags based on commit messages (without # prefix)
        theme_keywords = {
            'fix': 'bugfix',
            'feature': 'feature',
            'refactor': 'refactoring',
            'test': 'testing',
            'doc': 'documentation',
            'video': 'video_generation',
            'marketing': 'marketing'
        }

        all_commit_subjects = []
        for repo_info in repos_data.values():
            for commit in repo_info.get('commits', []):
                all_commit_subjects.append(commit['subject'].lower())

        for keyword, tag in theme_keywords.items():
            if any(keyword in subject for subject in all_commit_subjects):
                if tag not in tags:
                    tags.append(tag)

        # Format tags: first tag without # (template provides it), rest with #
        if tags:
            if len(tags) == 1:
                theme_tags_str = tags[0]
            else:
                theme_tags_str = tags[0] + ' ' + ' '.join(f'#{tag}' for tag in tags[1:])
        else:
            theme_tags_str = ''

        content = content.replace('{{THEME_TAGS}}', theme_tags_str)

        return content

    def _add_auto_update_marker(self, content: str) -> str:
        """Add HTML comment marking last auto-update time"""
        timestamp = datetime.now().strftime('%Y-%m-%d %H:%M')
        marker = f"\n<!-- Last auto-update: {timestamp} -->\n"

        # Add before the final ---
        if '\n---\n*Template created:' in content:
            content = content.replace(
                '\n---\n*Template created:',
                marker + '\n---\n*Template created:'
            )
        else:
            content += marker

        return content


# --- 4. Smart Merge Module ---
class JournalMerger:
    """Handles intelligent merging of auto-generated content with manual entries"""

    def __init__(self, logger: Logger):
        self.logger = logger

    def merge_with_existing(self, journal_path: str, new_content: str) -> str:
        """Merge new auto-generated content with existing journal, preserving manual edits"""

        # Check if file exists
        if not os.path.exists(journal_path):
            self.logger.info(f"No existing journal at {journal_path}, creating new one")
            return new_content

        # Load existing content
        try:
            with open(journal_path, 'r') as f:
                existing_content = f.read()
        except Exception as e:
            self.logger.error(f"Error reading existing journal: {e}")
            return new_content

        # Parse both versions into sections
        existing_sections = self._parse_sections(existing_content)
        new_sections = self._parse_sections(new_content)

        # Merge strategy:
        # - Preserve manual sections (Goals, Insights, Reflection)
        # - Update auto-generated sections (Date & Context, Daily Log, Metrics, Related Notes, Tags)
        # - Append to Daily Log instead of replacing

        auto_sections = [
            'Date & Context',
            'Metrics & Tracking',
            'Related Notes'
        ]

        manual_sections = [
            "Today's Goals",
            'Insights & Learnings',
            'Reflection',
            "Tomorrow's Preview"
        ]

        merged_sections = {}

        for section_name, section_content in existing_sections.items():
            # Check if section has user content (not just placeholders)
            has_user_content = self._has_user_content(section_content)

            if section_name in manual_sections and has_user_content:
                # Preserve manual sections
                merged_sections[section_name] = section_content
                self.logger.debug(f"Preserving manual section: {section_name}")
            elif section_name == 'Daily Log':
                # Special handling: append new entries to existing
                merged_sections[section_name] = self._merge_daily_log(
                    existing_sections.get(section_name, ''),
                    new_sections.get(section_name, '')
                )
            else:
                # Use new content for auto-generated sections
                if section_name in new_sections:
                    merged_sections[section_name] = new_sections[section_name]
                else:
                    merged_sections[section_name] = section_content

        # Add any new sections from new_content
        for section_name in new_sections:
            if section_name not in merged_sections:
                merged_sections[section_name] = new_sections[section_name]

        # Reconstruct journal
        merged_content = self._reconstruct_journal(merged_sections, new_content)

        return merged_content

    def _parse_sections(self, content: str) -> Dict[str, str]:
        """Parse journal content into sections"""
        sections = {}

        # Split by ## headers
        parts = re.split(r'\n## ', content)

        # First part is title
        if parts:
            sections['_title'] = parts[0].strip()

        # Parse remaining sections
        for part in parts[1:]:
            lines = part.split('\n', 1)
            if len(lines) == 2:
                # Remove emoji from section name
                section_name = re.sub(r'^[^\w\s]+\s*', '', lines[0]).strip()
                section_content = lines[1].strip()
                sections[section_name] = section_content

        return sections

    def _has_user_content(self, section_content: str) -> bool:
        """Check if a section has user-entered content (not just placeholders)"""
        # Remove markdown formatting
        text = re.sub(r'[#*\-\[\]_]', '', section_content)

        # Check for placeholders
        if '_____' in text:
            # Has placeholders, check if there's also real content
            non_placeholder_text = text.replace('_____', '').strip()
            if len(non_placeholder_text) > 20:  # Arbitrary threshold
                return True
            return False

        # Check for template variables
        if '{{' in section_content:
            return False

        # Check for empty checkbox items
        empty_pattern = r'- \[ \] \s*$'
        lines = section_content.split('\n')
        non_empty_lines = [l for l in lines if l.strip() and not re.match(empty_pattern, l.strip())]

        return len(non_empty_lines) > 0

    def _merge_daily_log(self, existing_log: str, new_log: str) -> str:
        """Merge daily log sections, appending new entries"""

        # Parse both logs by time period
        existing_periods = self._parse_daily_log_periods(existing_log)
        new_periods = self._parse_daily_log_periods(new_log)

        # Merge each period
        merged_periods = {}

        for period in ['Morning', 'Afternoon', 'Evening']:
            existing_entries = existing_periods.get(period, [])
            new_entries = new_periods.get(period, [])

            # Remove placeholder entries from existing
            existing_entries = [e for e in existing_entries if '_____' not in e]

            # Combine, avoiding duplicates
            all_entries = existing_entries.copy()
            for entry in new_entries:
                if entry not in all_entries and '_____' not in entry:
                    all_entries.append(entry)

            merged_periods[period] = all_entries

        # Reconstruct daily log
        merged_log = ""
        for period in ['Morning', 'Afternoon', 'Evening']:
            time_range = {
                'Morning': '(6:00 - 12:00)',
                'Afternoon': '(12:00 - 18:00)',
                'Evening': '(18:00 - 22:00)'
            }

            merged_log += f"\n### {period} {time_range[period]}\n"

            entries = merged_periods.get(period, [])
            if entries:
                for entry in entries:
                    merged_log += f"- {entry}\n"
            else:
                merged_log += "- _____\n"

        return merged_log.strip()

    def _parse_daily_log_periods(self, log_content: str) -> Dict[str, List[str]]:
        """Parse daily log into time periods"""
        periods = {}

        current_period = None

        for line in log_content.split('\n'):
            # Check for period header
            if line.startswith('### '):
                # Extract period name
                match = re.match(r'### (\w+)', line)
                if match:
                    current_period = match.group(1)
                    periods[current_period] = []
            elif line.startswith('- ') and current_period:
                # Extract entry
                entry = line[2:].strip()
                if entry:
                    periods[current_period].append(entry)

        return periods

    def _reconstruct_journal(self, sections: Dict[str, str], template: str) -> str:
        """Reconstruct journal from sections"""

        # Start with title
        content = sections.get('_title', '# Daily Note')
        content += '\n\n'

        # Define section order (from template)
        section_order = [
            'Date & Context',
            "Today's Goals",
            'Daily Log',
            'Insights & Learnings',
            'Reflection',
            'Metrics & Tracking',
            "Tomorrow's Preview",
            'Related Notes'
        ]

        # Add sections in order
        for section_name in section_order:
            if section_name in sections:
                # Find emoji prefix from template
                emoji_match = re.search(rf'## ([^\w\s]+)\s*{re.escape(section_name)}', template)
                emoji = emoji_match.group(1) + ' ' if emoji_match else ''

                content += f"## {emoji}{section_name}\n"

                # Get section content and remove any footer that might be included
                section_content = sections[section_name]
                # Remove footer if it was included in section parsing
                section_content = re.sub(r'\n---\n\n\*\*Tags:.*$', '', section_content, flags=re.DOTALL)

                content += section_content
                content += '\n\n'

        # Add footer (tags, etc.)
        # Extract footer from new template (which has the updated tags)
        footer_match = re.search(r'\n---\n\n\*\*Tags:.*$', template, re.DOTALL)
        if footer_match:
            content += footer_match.group(0)

        return content


# --- 5. Main Execution ---
class JournalAgent:
    """Main journal automation agent"""

    def __init__(self, config: Dict, args):
        self.config = config
        self.args = args
        self.logger = Logger(
            verbose=args.verbose,
            log_file=LOG_FILE if config.get('logging', {}).get('enabled', True) else None
        )

        self.git_analyzer = GitAnalyzer(self.logger)
        self.template_processor = TemplateProcessor(
            config['journal']['template_path'],
            self.logger
        )
        self.journal_merger = JournalMerger(self.logger)

    def run(self):
        """Main execution flow"""
        try:
            self.logger.info("="*50)
            self.logger.info("Daily Journal Automation Agent - Starting")
            self.logger.info("="*50)

            # Determine target date
            if self.args.date:
                target_date = datetime.strptime(self.args.date, '%Y-%m-%d')
            else:
                target_date = datetime.now()

            self.logger.info(f"Target date: {target_date.strftime('%Y-%m-%d')}")

            # Analyze all repositories
            repos_data = {}
            total_activity_score = 0.0

            for repo in self.config['repositories']:
                if not repo['enabled']:
                    continue

                repo_name = repo['name']
                repo_path = repo['path']
                repo_weight = repo['weight']

                self.logger.info(f"Analyzing repository: {repo_name}")

                # Get commits for target date
                commits = self.git_analyzer.get_commits_for_date(repo_path, target_date)

                if not commits:
                    self.logger.info(f"  No commits found in {repo_name}")
                    continue

                self.logger.info(f"  Found {len(commits)} commits")

                # Group commits by time period
                periods = self.git_analyzer.group_commits_by_time(commits)

                # Calculate activity score
                activity_score = self.git_analyzer.calculate_activity_score(commits, repo_weight)
                total_activity_score += activity_score

                repos_data[repo_name] = {
                    'commits': commits,
                    'periods': periods,
                    'activity_score': activity_score
                }

            self.logger.info(f"Total activity score: {total_activity_score:.2f}")

            # Check if update is needed
            if not self.args.force and total_activity_score < self.config['thresholds']['min_commits']:
                self.logger.info("Activity score below threshold, skipping update")
                return

            # Generate journal entry
            self.logger.info("Generating journal entry...")
            new_content = self.template_processor.generate_journal_entry(
                target_date,
                repos_data,
                total_activity_score
            )

            # Determine output path
            if self.args.test_mode:
                output_dir = Path('/tmp/journal_test')
                output_dir.mkdir(parents=True, exist_ok=True)
            else:
                output_dir = Path(self.config['journal']['directory'])

            journal_filename = f"daily-{target_date.strftime('%Y-%m-%d')}.md"
            journal_path = output_dir / journal_filename

            # Merge with existing if needed
            if self.config['features']['preserve_manual_edits']:
                self.logger.info("Merging with existing journal...")
                final_content = self.journal_merger.merge_with_existing(str(journal_path), new_content)
            else:
                final_content = new_content

            # Output
            if self.args.dry_run:
                self.logger.info("\n" + "="*50)
                self.logger.info("DRY RUN - Journal content:")
                self.logger.info("="*50)
                print(final_content)
            else:
                # Write to file
                with open(journal_path, 'w') as f:
                    f.write(final_content)

                self.logger.info(f"Journal written to: {journal_path}")

            self.logger.info("="*50)
            self.logger.info("Daily Journal Automation Agent - Complete")
            self.logger.info("="*50)

        except Exception as e:
            self.logger.error(f"Fatal error: {e}")
            import traceback
            self.logger.error(traceback.format_exc())
            sys.exit(1)


def main():
    """Main entry point"""
    parser = argparse.ArgumentParser(
        description='Daily Journal Automation Agent',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=__doc__
    )

    parser.add_argument('--dry-run', action='store_true',
                        help='Print output to console without writing files')
    parser.add_argument('--test-mode', action='store_true',
                        help='Write to /tmp/journal_test/ instead of live directory')
    parser.add_argument('--date', type=str,
                        help='Generate for specific date (YYYY-MM-DD format)')
    parser.add_argument('--force', action='store_true',
                        help='Force update even if activity is low')
    parser.add_argument('--verbose', action='store_true',
                        help='Enable verbose logging output')
    parser.add_argument('--live', action='store_true',
                        help='Run in live mode (default)')

    args = parser.parse_args()

    # Load configuration
    config = load_config(CONFIG_FILE)

    # Create and run agent
    agent = JournalAgent(config, args)
    agent.run()


if __name__ == '__main__':
    main()
