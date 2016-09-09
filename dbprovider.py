from pymongo import MongoClient


def load_games(db_name):
    client = MongoClient()
    db = client[db_name]
    db_games = db['games']
    db_rounds = db['rounds']

    games = {}

    for game in db_games.find():
        gameId = game['id']
        game['rounds'] = {}
        for round in db_rounds.find({'gameid':gameId}):
            if not check_fields(round):
                continue
            round_number = round['roundnumber']
            round_stage = round['stage']
            # TODO: support stages
            if round_stage == 0:
                game['rounds'][round_number] = round

        if check_rounds(game):
            games[gameId] = game

    return games


def check_fields(round):
    if not 'stage' in round:
        return False

    return True


def check_rounds(game):
    if not 'rounds' in game:
        return False

    for i in range(len(game['rounds'])):
        if not i in game['rounds']:
            return False

    return True
