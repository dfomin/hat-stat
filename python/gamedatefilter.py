def filter_game_with_date(games, date):
    return filter(lambda game: 'timestamp' in game and game['timestamp'] >= date, games)