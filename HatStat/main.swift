//
//  main.swift
//  HatStat
//
//  Created by Dmitry Fomin on 25/05/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

var games = [String: Game]()
var jsonGames = DBDumpLoader.loadGames()
for jsonGame in jsonGames {
    if let game = Game(json: jsonGame) {
        games[game.id] = game
    }
}

jsonGames.removeAll()

var jsonRounds = DBDumpLoader.loadRounds()
for jsonRound in jsonRounds {
    if let round = Round(json: jsonRound) {
        games[round.gameId]?.rounds.append(round)
    }
}

jsonRounds.removeAll()

var corruptedGames = [String]()
for game in games.values {
    if !game.fixRounds() || !game.checkForReal() {
        corruptedGames.append(game.id)
    }
}

for id in corruptedGames {
    games[id] = nil
}

print("\(games.count)")
