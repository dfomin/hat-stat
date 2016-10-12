from gamestatmanager import GameStatManager
from realgamedetector import *
from gamestat import *
from collections import defaultdict
from operator import itemgetter

manager = GameStatManager('prod')
real_games = list(filter_real_games(manager.games.values()))
# real_games = games.values()

packs_stat = defaultdict(int)
words_stat = defaultdict(int)
device_words = {}
for game in real_games:
    game_stat = GameStat(game)
    device_id = game['deviceid']
    if device_id not in device_words:
        device_words[device_id] = set()
    for word in game_stat.words_for_pack(0):
        device_words[device_id].add(word)
    for pack_id in game_stat.word_packs():
        words_count = len(game_stat.words_for_pack(pack_id))
        if pack_id in packs_stat:
            packs_stat[pack_id] += words_count
        else:
            packs_stat[pack_id] = words_count
for _, words in device_words.items():
    for word in words:
        if word in words_stat:
            words_stat[word] += 1
        else:
            words_stat[word] = 1

real_games_count = len(real_games)
print(real_games_count)

for pack_id, count in packs_stat.items():
    print(str(pack_id) + ": " + str(count / real_games_count))
# words_stat = sorted(words_stat.items(), key=lambda k_v: k_v[1], reverse=True)
# for word, value in words_stat:
#    print(str(value) + ": " + word)
