
import json
import os

# --- Configuration ---
SOURCE_JSON_PATH = '/Users/ideaopedia/Documents/textDump/03_RESOURCES/AI/CLAUDE/CLAUDE-2025-11-12-17-26-20-batch-0000/conversations.json'
OUTPUT_JSON_PATH = '/Users/ideaopedia/Documents/textDump/01_PROJECTS/BILAN/electrolyte_business_conversations.json'
# Keywords to identify relevant conversations (case-insensitive)
KEYWORDS = ['electrolyte', 'bilan']

# --- 1. Load Source Data ---
try:
    with open(SOURCE_JSON_PATH, 'r') as f:
        all_conversations = json.load(f)
except (FileNotFoundError, json.JSONDecodeError) as e:
    print(f"Error reading or parsing the source JSON file: {e}")
    exit()

# --- 2. Filter for Electrolyte-Related Conversations ---
electrolyte_conversations = []
for conv in all_conversations:
    # Ensure the 'name' key exists and is a string
    if 'name' in conv and isinstance(conv['name'], str):
        # Check if any keyword is in the conversation name (case-insensitive)
        if any(keyword.lower() in conv['name'].lower() for keyword in KEYWORDS):
            electrolyte_conversations.append(conv)

# --- 3. Write to a New File ---
# Ensure the output directory exists
output_dir = os.path.dirname(OUTPUT_JSON_PATH)
os.makedirs(output_dir, exist_ok=True)

with open(OUTPUT_JSON_PATH, 'w') as f:
    json.dump(electrolyte_conversations, f, indent=4)

print(f"Successfully isolated {len(electrolyte_conversations)} conversations.")
print(f"Data saved to: {OUTPUT_JSON_PATH}")

