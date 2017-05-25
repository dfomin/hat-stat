from gamestatmanager import GameStatManager
from packmanager import PackManager
from realgamedetector import *
from gamestat import *
from collections import defaultdict

manager = GameStatManager('prod')
pack_manager = PackManager('prod')
real_games = list(filter_real_games(manager.games.values()))

packs_stat = defaultdict(int)
words_stat = defaultdict(int)
words_time = defaultdict(list)
words_level = defaultdict(int)
device_words = {}
for game in real_games:
    game_stat = GameStat(game)

    # times = game_stat.word_guess_time(pack_id)
    # for word, time in times.items():
    #     if pack_manager.getPackOfWord(word) != pack_id:
    #         continue
    #
    #     if word not in words_time:
    #         words_time[word] = list()
    #
    #     words_time[word].append(time)
    #
    #     if word not in words_level:
    #         words_level[word] = game_stat.word_level(word, pack_id)

    device_id = game['deviceid']
    if device_id not in device_words:
       device_words[device_id] = list()
    for word in game_stat.words_for_pack(0):
       device_words[device_id].append(word)
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
   print(str(pack_id) + ": " + str(count))

# words_stat = sorted(words_stat.items(), key=lambda k_v: k_v[1], reverse=True)
# for word, value in words_stat:
#    print(str(value) + ": " + word)

# words_time_result = defaultdict(float)
# for word, times in words_time.items():
#     words_time_result[word] = sum(times) / len(times)
#
# f = open("pack" + str(pack_id) + ".txt", "w")
# words_time_result = sorted(words_time_result.items(), key=lambda k_v: k_v[1], reverse=True)
# for word, time in words_time_result:
#     f.write(word + " (" + str(int(words_level[word])) + "): " + "%.2f" % time + "(" + str(len(words_time[word])) + ")\n")
    #print(word + " (" + str(int(words_level[word])) + "): " + "%.2f" % time + "(" + str(len(words_time[word])) + ")")
