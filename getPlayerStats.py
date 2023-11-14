import requests
from bs4 import BeautifulSoup

class NFLStatsScraper:
    def __init__(self, url):
        self.url = url

    def get_html(self):
        try:
            response = requests.get(self.url)
            response.raise_for_status()
            return response.text
        except requests.HTTPError as http_err:
            print(f'HTTP error occurred: {http_err}')
        except Exception as err:
            print(f'An error occurred: {err}')

    def parse_stats(self, html):
        soup = BeautifulSoup(html, 'html.parser')

        # Example: Find and return the stats table
        # This is a placeholder - you'll need to adjust the selector based on the actual webpage structure
        stats_table = soup.find('table', class_='stats-table')
        return stats_table

    def get_stats(self):
        html = self.get_html()
        if html:
            return self.parse_stats(html)
        else:
            return None
