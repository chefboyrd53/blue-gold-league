def calculate_total_score(players):
    return sum(player['points'] for player in players)
