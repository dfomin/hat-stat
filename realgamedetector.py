def filterRealGames(games):
    return filter(checkGame, games)

def checkGame(game):
    gameWordsCount = len(game['words'])

    guessedWords = 0
    skippedWords = 0
    deletedWords = 0
    allWords = 0
    time = 0

    for _, round in game['rounds'].items():
        for _, word in round['words'].items():
            allWords += 1
            time += word['time']

            if word['guessed'] and not word['deleted']:
                guessedWords += 1

            if word['deleted']:
                deletedWords += 1

        skippedWords += len(round['skipped'])

    averageTime = time / allWords if allWords > 0 else 100

    if guessedWords == gameWordsCount and averageTime > 2 and gameWordsCount > 10:
        return True
    else:
        return False
