import os
import sqlite3
import pandas as pd

def ingest_data():
    db_path = '../data/zomato_project.db'
    cleaned_dir = '../data/cleaned'
    
    os.makedirs('../data', exist_ok=True)
    conn = sqlite3.connect(db_path)
    
    if not os.path.exists(cleaned_dir):
        print(f"Error: {cleaned_dir} directory nahi mili!")
        return

    for file in os.listdir(cleaned_dir):
        if file.endswith('.csv'):
            table_name = os.path.splitext(file)[0].lower().strip().replace(' ', '_').replace('-', '_')
            file_path = os.path.join(cleaned_dir, file)
            
            try:
                df = pd.read_csv(file_path)
                df.columns = [c.strip().lower().replace(' ', '_').replace('-', '_') for c in df.columns]
                df.to_sql(table_name, conn, if_exists='replace', index=False)
                print(f"Ingested table into database: {table_name}")
            except Exception as e:
                print(f"Error ingesting {file}: {e}")
                
    conn.close()
    print("All tables successfully ingested into SQLite database!")

if __name__ == '__main__':
    ingest_data()