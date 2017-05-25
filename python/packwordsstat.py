class PackWordsStat:
    pack_manager = {}
    pack_id = -1

    def __init__(self, pack_id, pack_manager):
        self.pack_id = pack_id
        self.pack_manager = pack_manager

    def process_games(self, games):
        for game in games:
            self.process_game(game)

    def process_game(self, game):
        for word in game['words']:
