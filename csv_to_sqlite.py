import pandas as pd
import sqlite3

# File paths
csv_file = 'Online_Retail.csv'
db_file = 'Online_Retail.db'
table_name = 'online_retail'

# Read CSV into DataFrame
df = pd.read_csv(csv_file)

# Connect to SQLite database (it will be created if it doesn't exist)
conn = sqlite3.connect(db_file)

# Write the DataFrame to SQLite
df.to_sql(table_name, conn, if_exists='replace', index=False)

conn.close()
print(f"CSV data has been written to {db_file} in table '{table_name}'")
