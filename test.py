import requests
from bs4 import BeautifulSoup
import pandas as pd
from io import StringIO

url = 'https://www.pro-football-reference.com/boxscores/202409050kan.htm'

response = requests.get(url)
soup = BeautifulSoup(response.text, 'html.parser')

# Find the 'player_offense' table directly
player_offense_table = soup.find('table', {'id': 'player_offense'})

if player_offense_table is None:
    print("Player offense table not found!")
else:
    html_data = StringIO(str(player_offense_table))
    df = pd.read_html(html_data)[0]
    print(df.head())
    df.to_csv('boxscore_player_offense.csv', index=False)
