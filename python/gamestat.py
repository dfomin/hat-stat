from collections import defaultdict


class GameStat:
    game = {}

    def __init__(self, game):
        self.game = game

    def game_id(self):
        return self.game['id']

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

    def word_packs(self):
        packs = set()
        for _, word in self.game['words'].items():
            packs.add(word['packid'])
        return packs

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

    def word_guess_time(self, pack_id):
        words_time = defaultdict(float)
        for _, round in self.game['rounds'].items():
            for _, round_word in round['words'].items():
                word_info = self.word_by_id(round_word['word'])
                if word_info is None:
                    continue
                if word_info['packid'] != pack_id:
                    continue

                word = word_info['word']
                if word not in words_time:
                    words_time[word] = round_word['time']
                else:
                    words_time[word] += round_word['time']

        return words_time

        # words_time = sorted(words_time.items(), key=lambda k_v: k_v[1], reverse=True)
        # for word, value in words_time:
        #     print(word + ": " + str(value))

    def word_by_id(self, word_id):
        if str(word_id) not in self.game['words']:
            print(self.game_id(), word_id)
            return None
        else:
            return self.game['words'][str(word_id)]

    def word_level(self, word, pack_id):
        for _, game_word in self.game['words'].items():
            if word == game_word['word'] and pack_id == game_word['packid']:
                return game_word['level']
