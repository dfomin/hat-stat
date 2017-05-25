from pymongo import MongoClient


class GameStatManager:
    games = {}

    def __init__(self, db_name):
        client = MongoClient()
        db = client[db_name]
        db_games = db['games']
        db_rounds = db['rounds']

        for game in db_games.find():
            gameId = game['id']
            game['rounds'] = {}
            for round in db_rounds.find({'gameid': gameId}):
                if not self.check_fields(round):
                    continue
                round_number = round['roundnumber']
                round_stage = round['stage']
                # TODO: support stages
                if round_stage == 0:
                    game['rounds'][round_number] = round

            if self.check_rounds(game):
                self.games[gameId] = game

    @staticmethod
    def check_fields(round):
        if 'stage' not in round:
            return False

        return True

    @staticmethod
    def check_rounds(game):
        if 'rounds' not in game:
            return False

        for i in range(len(game['rounds'])):
            if not i in game['rounds']:
                return False

        return True
