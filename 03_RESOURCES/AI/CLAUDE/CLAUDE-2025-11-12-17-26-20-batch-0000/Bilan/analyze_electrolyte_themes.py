
import json
import re
from collections import Counter, defaultdict

# --- Configuration ---
JSON_FILE_PATH = '/Users/ideaopedia/Documents/textDump/03_RESOURCES/AI/CLAUDE/CLAUDE-2025-11-12-17-26-20-batch-0000/electrolyte_business_conversations.json'
# Words to ignore. We add 'electrolyte' and 'bilan' because they are common to all entries and won't help differentiate sub-themes.
STOP_WORDS = set([
    "a", "an", "and", "the", "in", "on", "for", "with", "is", "are", "of",
    "to", "it", "that", "using", "how", "what", "when", "where", "why",
    "and", "my", "from", "by", "about", "com", "http", "https", "me", "do",
    "can", "you", "your", "this", "file", "code", "help", "give", "make",
    "electrolyte", "bilan" # Added context-specific stop words
])
MIN_THEME_LENGTH = 5
MIN_KEYWORD_LENGTH = 3
TOP_N_THEMES = 5

# --- 1. Load and Process Data ---
try:
    with open(JSON_FILE_PATH, 'r') as f:
        conversations = json.load(f)
except (FileNotFoundError, json.JSONDecodeError) as e:
    print(f"Error reading or parsing JSON file: {e}")
    exit()

themes = list(set([
    conv['name'] for conv in conversations 
    if conv['name'] and len(conv['name']) > MIN_THEME_LENGTH
]))

# --- 2. Identify Keywords and Group Themes ---
keyword_to_themes = defaultdict(list)

for theme in themes:
    words = re.findall(r'\b\w+\b', theme.lower())
    for word in words:
        if word not in STOP_WORDS and len(word) >= MIN_KEYWORD_LENGTH:
            keyword_to_themes[word].append(theme)

# --- 3. Find the Top Themes (Most Connected Keywords) ---
connected_keywords = {
    word: theme_list for word, theme_list in keyword_to_themes.items() 
    if len(theme_list) > 1
}
keyword_counts = Counter({word: len(themes) for word, themes in connected_keywords.items()})
top_themes = keyword_counts.most_common(TOP_N_THEMES)

# --- 4. Print the Report ---
print("="*50)
print("   TOP ELECTROLYTE BUSINESS THEMES REPORT")
print("="*50)
print(f"\nFound {len(top_themes)} major sub-themes:\n")

if not top_themes:
    print("No significant overlapping themes were found.")
    print("Here are all the individual conversation topics:")
    for theme in themes:
        print(f"  - {theme}")
else:
    for i, (theme_word, count) in enumerate(top_themes):
        print(f"--- Theme {i+1}: \"{theme_word.upper()}\" ({count} related conversations) ---\\n")
        for conversation_title in connected_keywords[theme_word]:
            print(f"  - {conversation_title}")
        print("\n" + "-"*50 + "\n")
