import os
import pymysql
from getPlayerStats import NFLStatsScraper

# Connect to the database
try:
    conn = pymysql.connect(
        host='database-group5.cdzoz9uage3b.us-east-2.rds.amazonaws.com',
        user='admin',
        password='',
        # database='database-group5',
        port=3306
    )
    print("Connected to the database.")
    # ... perform database operations ...

    # Don't forget to commit if you make changes to the database
    # conn.commit()

except pymysql.MySQLError as e:
    print(f"An error occurred: {e}")
    conn = None

finally:
    # Ensure that the connection is closed
    if conn:
        conn.close()

url = 'https://www.nfl.com/stats/player-stats/'
scraper = NFLStatsScraper(url)
stats = scraper.get_stats()

if stats:
    print(stats)
else:
    print("Failed to retrieve or parse stats")