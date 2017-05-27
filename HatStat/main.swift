//
//  main.swift
//  HatStat
//
//  Created by Dmitry Fomin on 25/05/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

func loadGames() -> [String: Game] {
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
    
    return games
}

func countWordStat(games: [String: Game]) {
    let wordPopularity = WordPopularity()
    for game in games.values {
        for word in game.words {
            wordPopularity.add(word: word.word, packId: word.packId, uniqueId: game.deviceId)
        }
    }
    
    let wordStat = wordPopularity.wordsFor(pack: 0)
    for stat in wordStat {
        print("\(stat.word): \(stat.count) \(stat.ids)")
    }
}

func countWordsGuessTime(games: [String: Game], forPack packId: Int) {
    let wordGuessTime = WordGuessTime()
    for game in games.values {
        for round in game.rounds {
            for roundWord in round.roundWords {
                if roundWord.wordId < game.words.count {
                    if game.words[roundWord.wordId].packId == packId || packId == -1 {
                        wordGuessTime.add(word: game.words[roundWord.wordId].word, time: roundWord.time, guessed: roundWord.state == .guessed)
                    }
                }
            }
        }
    }
    
    for stat in wordGuessTime.fullStat() {
        print("\(stat.word): \(stat.average) \(stat.count)")
    }
}

func main() {
    let games = loadGames()
    print("real games: \(games.count)")
    
    //countWordStat(games: games)
    
    //countWordsGuessTime(games: games, forPack: 6)
}

main()
