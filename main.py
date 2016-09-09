from dbprovider import *
from realgamedetector import *
from gamestat import *

games = load_games('prod')
real_games = filter_real_games(games.values())
# print(len(list(realGames)))

for game in real_games:
    game_stat = GameStat(game)
    if game_stat.version() == "1.1":
        print(str(game_stat.game_id()) + " " + str(game_stat.average_word_time()))
