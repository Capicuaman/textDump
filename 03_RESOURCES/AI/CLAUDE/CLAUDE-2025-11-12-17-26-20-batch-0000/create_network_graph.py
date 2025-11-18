
import json
import os
import re
from collections import defaultdict

# --- Configuration ---
JSON_FILE_PATH = '/Users/ideaopedia/Documents/textDump/03_RESOURCES/AI/CLAUDE/CLAUDE-2025-11-12-17-26-20-batch-0000/conversations.json'
OUTPUT_HTML_PATH = '/Users/ideaopedia/Documents/textDump/03_RESOURCES/AI/CLAUDE/CLAUDE-2025-11-12-17-26-20-batch-0000/themes_network_graph.html'
# Words to ignore when finding connections
STOP_WORDS = set([
    "a", "an", "and", "the", "in", "on", "for", "with", "is", "are", "of",
    "to", "it", "that", "using", "how", "what", "when", "where", "why",
    "and", "my", "from", "by", "about", "com", "http", "https"
])

# --- 1. Load and Process Data ---
with open(JSON_FILE_PATH, 'r') as f:
    conversations = json.load(f)

themes = list(set([conv['name'] for conv in conversations if conv['name'] and len(conv['name']) > 5]))

# --- 2. Find Relationships (Edges) ---
nodes = [{"id": i, "label": theme} for i, theme in enumerate(themes)]
edges = []
keyword_to_themes = defaultdict(list)

# Find keywords in each theme title
for i, theme in enumerate(themes):
    words = re.findall(r'\b\w+\b', theme.lower())
    for word in words:
        if word not in STOP_WORDS and len(word) > 2:
            keyword_to_themes[word].append(i)

# Create edges for themes sharing keywords
for word, theme_indices in keyword_to_themes.items():
    if len(theme_indices) > 1:
        for i in range(len(theme_indices)):
            for j in range(i + 1, len(theme_indices)):
                edges.append({"from": theme_indices[i], "to": theme_indices[j]})

# --- 3. Generate HTML ---
html_content = f"""
<!DOCTYPE html>
<html>
<head>
    <title>Conversation Themes Network Graph</title>
    <script type="text/javascript" src="https://unpkg.com/vis-network/standalone/umd/vis-network.min.js"></script>
    <style type="text/css">
        html, body {{
            margin: 0;
            padding: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
        }}
        #mynetwork {{
            width: 100%;
            height: 100%;
        }}
    </style>
</head>
<body>

<div id="mynetwork"></div>

<script type="text/javascript">
    var nodes = new vis.DataSet({json.dumps(nodes)});
    var edges = new vis.DataSet({json.dumps(edges)});

    var container = document.getElementById('mynetwork');
    var data = {{
        nodes: nodes,
        edges: edges
    }};
    var options = {{
        nodes: {{
            shape: 'dot',
            size: 16,
            font: {{
                size: 14,
                color: '#333'
            }},
            borderWidth: 2
        }},
        edges: {{
            width: 2,
            color: {{
                color: '#848484',
                highlight: '#848484',
                hover: '#848484'
            }}
        }},
        physics: {{
            forceAtlas2Based: {{
                gravitationalConstant: -26,
                centralGravity: 0.005,
                springLength: 230,
                springConstant: 0.18
            }},
            maxVelocity: 146,
            solver: 'forceAtlas2Based',
            timestep: 0.35,
            stabilization: {{iterations: 150}}
        }}
    }};

    var network = new vis.Network(container, data, options);
</script>

</body>
</html>
"""

# --- 4. Write HTML File ---
with open(OUTPUT_HTML_PATH, 'w') as f:
    f.write(html_content)

print(f"Network graph has been generated at: {OUTPUT_HTML_PATH}")

