from dbprovider import *
from realgamedetector import *
from gamestat import *
from collections import defaultdict
from operator import itemgetter

games = load_games('prod')
real_games = filter_real_games(games.values())
# real_games = games.values()
# print(len(list(realGames)))

words_stat = defaultdict(int)
for game in real_games:
    game_stat = GameStat(game)
    if game_stat.version() == "1.1":
        pass
#        print(str(game_stat.game_id()) + " " +
#              str(game_stat.average_word_time()) + " " +
#              str(game_stat.skipped_words()))
    for word in game_stat.words_for_pack(0):
        if word in words_stat:
            words_stat[word] += 1
        else:
            words_stat[word] = 1
words_stat = sorted(words_stat.items(), key=lambda k_v: k_v[1], reverse=True)
for word, value in words_stat:
    print(str(value) + ": " + word)
