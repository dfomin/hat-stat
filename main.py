from dbprovider import *
from realgamedetector import *

games = loadGames('prod')
realGames = filterRealGames(games.values())
print len(realGames)
