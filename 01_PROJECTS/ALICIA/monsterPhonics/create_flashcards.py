
import csv
from bs4 import BeautifulSoup

# Path to the HTML file
html_file_path = '/Users/ideaopedia/Documents/textDump/01_PROJECTS/ALICIA/monsterPhonics/monster_phonics_word_lists.html'
# Path to the output CSV file
csv_file_path = '/Users/ideaopedia/Documents/textDump/01_PROJECTS/ALICIA/monsterPhonics/anki_flashcards.csv'

# Read the HTML file
with open(html_file_path, 'r', encoding='utf-8') as f:
    html_content = f.read()

# Parse the HTML
soup = BeautifulSoup(html_content, 'html.parser')

# Find all character sections
character_sections = soup.find_all('div', class_='character-section')

# Open the CSV file for writing
with open(csv_file_path, 'w', newline='', encoding='utf-8') as csvfile:
    csv_writer = csv.writer(csvfile)
    # Write the header row
    csv_writer.writerow(['Front', 'Back'])

    # Iterate over each character section
    for section in character_sections:
        # Get the category from the h2 tag
        category = section.find('h2', class_='character-title').get_text(strip=True)

        # Find the table in the section
        table = section.find('table')

        if table:
            # Iterate over each row in the table body
            for row in table.find('tbody').find_all('tr'):
                # Iterate over each cell in the row
                for cell in row.find_all('td'):
                    word = cell.get_text(strip=True)
                    if word:
                        # Write the word and category to the CSV
                        csv_writer.writerow([word, category])

print(f"Flashcards created successfully at: {csv_file_path}")
