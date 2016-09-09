class GameStat:
    game = {}

    def __init__(self, game):
        self.game = game

    def game_id(self):
        return self.game['id']

    def average_word_time(self):
        time = 0
        words_count = 0
        for _, round in self.game['rounds'].items():
            for _, round_word in round['words'].items():
                time += round_word['time']
                words_count += 1

        return time / words_count

    def version(self):
        if self.game_id().find('.') != -1:
            return "1.0"
        else:
            return "1.1"
