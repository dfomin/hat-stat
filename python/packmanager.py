from pymongo import MongoClient
from collections import defaultdict


class PackManager:
    words = defaultdict(int)

    def __init__(self, db_name):
        client = MongoClient()
        db = client[db_name]
        db_packs = db['packs']

        for pack in db_packs.find():
            pack_id = pack['id']
            for pack_word in pack['phrases']:
                word = pack_word['phrase']
                self.words[word] = pack_id

    def get_pack_of_word(self, word):
        if word not in self.words:
            return -1
        else:
            return self.words[word]
