
import json
import os

# Path to the conversations.json file
json_file_path = '/Users/ideaopedia/Documents/textDump/03_RESOURCES/AI/CLAUDE/CLAUDE-2025-11-12-17-26-20-batch-0000/conversations.json'
output_html_path = '/Users/ideaopedia/Documents/textDump/03_RESOURCES/AI/CLAUDE/CLAUDE-2025-11-12-17-26-20-batch-0000/themes_mindmap.html'

# Read the JSON data
with open(json_file_path, 'r') as f:
    conversations = json.load(f)

# Extract themes (conversation names) and format for Markmap
themes = [conv['name'] for conv in conversations if conv['name']]
markdown_content = "# Conversation Themes\n\n"
for theme in themes:
    markdown_content += f"- {theme}\n"

# Generate HTML with Markmap
html_content = f"""
<!DOCTYPE html>
<html>
<head>
    <title>Conversation Themes Mind Map</title>
    <script src="https://cdn.jsdelivr.net/npm/markmap-autoloader"></script>
    <style>
        html, body, .markmap {{
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }}
    </style>
</head>
<body>
    <div class="markmap">
        <script type="text/template">
{markdown_content}
        </script>
    </div>
</body>
</html>
"""

# Write the HTML file
with open(output_html_path, 'w') as f:
    f.write(html_content)

print(f"Mind map has been generated at: {output_html_path}")
