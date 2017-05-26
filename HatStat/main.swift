//
//  main.swift
//  HatStat
//
//  Created by Dmitry Fomin on 25/05/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

var games = [Game]()
var jsonGames = DBDumpLoader.loadGames()
for jsonGame in jsonGames {
    if let game = Game(json: jsonGame) {
        games.append(game)
    }
}

jsonGames.removeAll()

var rounds = [Round]()
var jsonRounds = DBDumpLoader.loadRounds()
for jsonRound in jsonRounds {
    if let round = Round(json: jsonRound) {
        rounds.append(round)
    }
}

jsonRounds.removeAll()

print("\(games.count) \(rounds.count)")
