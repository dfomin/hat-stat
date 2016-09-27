from gamestatmanager import GameStatManager
from realgamedetector import *
from gamestat import *
from collections import defaultdict
from operator import itemgetter

manager = GameStatManager('prod')
real_games = filter_real_games(manager.games.values())
# real_games = games.values()
print(len(list(real_games)))

words_stat = defaultdict(int)
device_words = {}
for game in real_games:
    game_stat = GameStat(game)
    device_id = game['deviceid']
    if device_id not in device_words:
        device_words[device_id] = set()
    for word in game_stat.words_for_pack(0):
        device_words[device_id].add(word)
for _, words in device_words.items():
    for word in words:
        if word in words_stat:
            words_stat[word] += 1
        else:
            words_stat[word] = 1
words_stat = sorted(words_stat.items(), key=lambda k_v: k_v[1], reverse=True)
# for word, value in words_stat:
#    print(str(value) + ": " + word)
