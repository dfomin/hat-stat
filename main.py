from pymongo import MongoClient
client = MongoClient()
db = client['prod']
games = db['games']
rounds = db['rounds']

realGames = 0
for game in games.find():
    gameId = game['id']
    gameWordsCount = len(game['words'])
    guessedRoundWordsCount = 0
    allRoundWordsCount = 0
    time = 0.0
    for round in rounds.find({'gameid':gameId}):
        for _, word in round['words'].items():
            allRoundWordsCount += 1
            time += word['time']
            if word['guessed']:
                guessedRoundWordsCount += 1

    averageTime = 100000
    if allRoundWordsCount > 0:
        averageTime = time / allRoundWordsCount

    if gameWordsCount > 10 and averageTime > 2:
        print gameId, guessedRoundWordsCount, gameWordsCount, averageTime
        realGames += 1

print realGames
