class GameStat:
    game = {}

    def __init__(self, game):
        self.game = game

    def game_id(self):
        if 'id' in self.game:
            return self.game['id']
        else:
            return ""

    def check_word_from_pack(self, word, pack_id):
        for _, game_word in self.game['words'].items():
            if game_word['word'] == word and game_word['packid'] == pack_id:
                return True
        return False

    def check_word(self, word):
        for _, game_word in self.game['words'].items():
            if game_word['word'] == word:
                return True
        return False

    def words_for_pack(self, pack_id):
        words = []
        for _, word in self.game['words'].items():
            if word['packid'] == pack_id:
                words.append(word['word'])
        return words

    def average_word_time(self):
        time = 0
        words_count = 0
        for _, round in self.game['rounds'].items():
            for _, round_word in round['words'].items():
                time += round_word['time']
                words_count += 1
        if words_count > 0:
            return time / words_count
        else:
            return time

    def average_word_guess_time(self):
        time = 0
        words_count = 0
        for _, round in self.game['rounds'].items():
            for _, round_word in round['words'].items():
                if round_word['guessed']:
                    time += round_word['time']
                    words_count += 1
        if words_count > 0:
            return time / words_count
        else:
            return time

    def skipped_words(self):
        words_count = 0
        for _, round in self.game['rounds'].items():
            words_count += len(round['skipped'].items())
        return words_count

    def version(self):
        if self.game_id() == "" or self.game_id().find('.') != -1:
            return "1.0"
        else:
            return "1.1"
