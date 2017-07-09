//
//  main.swift
//  HatStat
//
//  Created by Dmitry Fomin on 25/05/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

func loadGames(allGames: Bool = false) -> [String: Game] {
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
            games[round.gameId]?.addRound(round)
        }
    }
    
    jsonRounds.removeAll()
    
    if !allGames {
        var corruptedGames = [String]()
        for game in games.values {
            if !game.fixRounds() || !game.checkForReal() {
                corruptedGames.append(game.id)
            }
        }
        
        for id in corruptedGames {
            games[id] = nil
        }
    }
    
    return games
}

func loadUsers() -> [User] {
    var users = [User]()
    let jsonUsers = DBDumpLoader.loadUsers()
    for jsonUser in jsonUsers {
        let user = User(json: jsonUser)
        users.append(user)
    }
    
    return users
}

func loadPacks() -> [Int: Pack] {
    var packs = [Int: Pack]()
    let jsonPacks = DBDumpLoader.loadPacks()
    for jsonPack in jsonPacks {
        if jsonPack.isEmpty {
            continue
        }
        
        let pack = Pack(json: jsonPack)
        packs[pack.id] = pack
        
        print(pack.id)
    }
    
    return packs
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

func countWordsGuessTime(games: [String: Game], forPack packId: Int, countLimit: Int) {
    let wordGuessTime = WordGuessTime()
    for game in games.values {
        for round in game.rounds {
            if round.stage == 0 {
                for roundWord in round.roundWords {
                    if roundWord.wordId < game.words.count {
                        if game.words[roundWord.wordId].badItalic {
                            continue
                        }
                        
                        if game.words[roundWord.wordId].packId == packId || packId == -1 {
                            wordGuessTime.add(word: game.words[roundWord.wordId].word, time: roundWord.time, guessed: roundWord.state == .guessed)
                        }
                    }
                }
            }
        }
    }
    
    var level = [String: Double]()
    for game in games.values {
        for word in game.words {
            level[word.word] = word.level
        }
    }
    
    let levelDetector = WordLevelAverageTime()
    
    for stat in wordGuessTime.fullStat() {
        if stat.count >= countLimit || countLimit == -1 {
            //print("\(stat.word): \(stat.average) \(level[stat.word]!)")
            levelDetector.add(word: stat.word, level: level[stat.word]!, averageTime: stat.average)
        }
    }
    
    print("\(levelDetector.words.count)")
    for i in 0...4 {
        let filtered = levelDetector.words.filter{ abs(Int($1.level) - Int($1.timeLevel)) == i }
        print("\(i) \(filtered.count)")
        for word in filtered {
            print("\(word.key) \(word.value.level) \(word.value.timeLevel)")
            //print("\(word.key) \(word.value.timeLevel)")
        }
    }
    
    for stat in levelDetector.words {
        if level[stat.key]! == 0 {
            //print("\(stat.key) \(stat.value.timeLevel)")
        }
    }
}

func analyzeStages(games: [String: Game]) {
    let analyzer = StageAnalyzer()
    for game in games.values {
        analyzer.process(game: game)
    }
    
    for key in analyzer.stages.keys.sorted() {
        print("\(key): \(analyzer.stages[key]!)")
    }
}

func analyzeBadItalic(games: [String: Game]) {
    let analyzer = BadItalicAnalyzer()
    for game in games.values {
        analyzer.process(game: game)
    }
    
    print("on: \(analyzer.enableStat.on), off: \(analyzer.enableStat.off)")
    print("disabled: \(analyzer.disabledInProcess)")
}

func countPackUsage(games: [String: Game]) {
    let packUsage = PackUsage()
    for game in games.values {
        packUsage.process(game: game)
    }
    
    for packId in packUsage.packStat.keys.sorted() {
        print("\(packId): \(packUsage.packStat[packId]!)")
    }
}

func countUsers(users: [User]) {
    let manager = UserManager()
    for user in users {
        manager.add(user: user)
    }
    
    print("users: \(manager.uniqueUsers)")
}

func checkPackWords(games: [Game], packs: [Int: Pack]) {
    for game in games {
        for word in game.words {
            let packId = word.packId
            if packId == 13 {
                let pack = packs[packId]!
                if pack.words[word.word] == nil {
                    print("\(word.word) \(packId) \(game.id)")
                }
            }
        }
    }
}

func main() {
    let games = loadGames(allGames: true)
    let users = loadUsers()
    let packs = loadPacks()
    
    print("real games: \(games.count)")
    countUsers(users: users)
    
    //countWordStat(games: games)
    
    //countWordsGuessTime(games: games, forPack: 13, countLimit: -1)
    
    //analyzeStages(games: games)
    
    //analyzeBadItalic(games: games)
    
    //countPackUsage(games: games)
    
    checkPackWords(games: Array(games.values), packs: packs)
}

main()
