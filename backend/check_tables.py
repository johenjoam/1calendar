import sqlite3

with open("schema.sql", "r") as f:
    schema = f.read()

conn = sqlite3.connect("1calendar.db")
cursor = conn.cursor()
cursor.executescript(schema)
conn.commit()                  
cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
print(cursor.fetchall())
conn.close()

