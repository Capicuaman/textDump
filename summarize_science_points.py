
import json
import re

# --- Configuration ---
JSON_FILE_PATH = '/Users/ideaopedia/Documents/textDump/03_RESOURCES/AI/CLAUDE/CLAUDE-2025-11-12-17-26-20-batch-0000/electrolyte_business_conversations.json'
TARGET_THEMES = [
    "Electrolyte Production Guidance",
    "Electrolyte salts for runners"
]

# --- 1. Load Data ---
try:
    with open(JSON_FILE_PATH, 'r') as f:
        conversations = json.load(f)
except (FileNotFoundError, json.JSONDecodeError) as e:
    print(f"Error reading or parsing JSON file: {e}")
    exit()

# --- 2. Extract and Summarize Key Points ---
print("="*50)
print("   Key Points: Product Science & Formulation")
print("="*50)

for theme_name in TARGET_THEMES:
    found = False
    for conv in conversations:
        if 'name' in conv and conv['name'] == theme_name:
            found = True
            print(f"\n--- From Conversation: \"{theme_name}\" ---\n")
            
            if 'chat_messages' in conv and conv['chat_messages']:
                # Simple summary: concatenate all non-empty text from messages
                full_text = " ".join([
                    msg.get('text', '') for msg in conv['chat_messages'] if msg.get('text')
                ])
                
                # Basic keyword extraction to find important points
                # (A more advanced implementation would use NLP)
                sentences = re.split(r'[.!?]', full_text)
                key_points = []
                
                # Look for sentences with important-sounding words
                keywords = ['sodium', 'potassium', 'magnesium', 'chloride', 'ratio', 'osmolarity', 'ingredient', 'formulation', 'production', 'mixing', 'sourcing']
                for sentence in sentences:
                    if any(keyword in sentence.lower() for keyword in keywords):
                        point = sentence.strip()
                        if point and point not in key_points:
                            key_points.append(point)
                
                if key_points:
                    for i, point in enumerate(key_points, 1):
                        print(f"  {i}. {point}.")
                else:
                    # Fallback if no keywords are found
                    print("  - Could not automatically extract key points. The conversation likely covers high-level concepts.")
                    print(f"  - Full text summary: {full_text[:300]}...")

            else:
                print("  - No chat messages found in this conversation.")
            break
    if not found:
        print(f"\n--- Conversation \"{theme_name}\" not found ---")

print("\n" + "="*50)
