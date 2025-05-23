import os
import sqlite3
from pathlib import Path

# Connect to SQLite database (or create it if it doesn't exist)
conn = sqlite3.connect('engines.db')
cursor = conn.cursor()

# Create a table to store markdown filenames
cursor.execute('''
CREATE TABLE IF NOT EXISTS files (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    filename TEXT UNIQUE,
    product_name TEXT
)
''')
conn.commit()

def clean_filename(file, keywords):
    for keyword in keywords:
        if keyword in file:
            file = file.replace(keyword, '')
    # Remove trailing spaces
    file = file.strip()
    return file

def is_file_in_db(filename):
    """Check if the file is already in the database."""
    cursor.execute('SELECT 1 FROM files WHERE filename = ?', (filename,))
    return cursor.fetchone() is not None

def add_file_to_db(filename, product_name):
    """Add a new file to the database."""
    cursor.execute('INSERT INTO files (filename, product_name) VALUES (?, ?)', (filename, product_name))
    conn.commit()

def parse_markdown_files(directory):
    """Parse markdown files in the given directory."""
    categories = {"System", "Maintenance", "Install", "Programming", "Transactions", "Dialect"}
    
    for root, _, files in os.walk(directory):
        # Extract the first-level folder name
        relative_path = Path(root).relative_to(directory)
        product_name = relative_path.parts[0] if len(relative_path.parts) > 0 else "Unknown"

        if any(keyword in product_name.lower() for keyword in ["data", "readme", ]):
            continue
        
        for file in files:
            if file.endswith('.md'):
                filepath = Path(root) / file
                
                # Check if the file part is contained in the folder name (we have main product name)
                if len(filepath.parts)>2 and " ".join(filepath.parts[:2]) in filepath.stem:
                    product_name = " ".join(filepath.parts[:2])
                # Check if the file contains any of the group keywords
                elif any(keyword in file for keyword in categories):
                    product_name = clean_filename(filepath.stem, categories)
                else:
                    product_name = filepath.stem
                    
                if not is_file_in_db(filepath.name):
                    print(f"New file found: {filepath.name} in product: {product_name}")
                    add_file_to_db(filepath.name, product_name)
                else:
                    print(f"File already in database: {filepath.name}")


# Specify the directory to search for markdown files
directory_to_search = '.'

# Parse markdown files in the specified directory
parse_markdown_files(directory_to_search)

# Close the database connection
conn.close()