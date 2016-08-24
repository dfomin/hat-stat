from pymongo import MongoClient

def loadGames(dbName):
    client = MongoClient()
    db = client[dbName]
    dbGames = db['games']
    dbRounds = db['rounds']

    games = {}

    for game in dbGames.find():
        gameId = game['id']
        game['rounds'] = {}
        for round in dbRounds.find({'gameid':gameId}):
            if not checkFields(round):
                continue
            roundNumber = round['roundnumber']
            roundStage = round['stage']
            # TODO: support stages
            if roundStage == 0:
                game['rounds'][roundNumber] = round

        if checkRounds(game):
            games[gameId] = game

    return games

def checkFields(round):
    if not 'stage' in round:
        return False

    return True

def checkRounds(game):
    if not 'rounds' in game:
        return False

    for i in range(len(game['rounds'])):
        if not i in game['rounds']:
            return False

    return True
