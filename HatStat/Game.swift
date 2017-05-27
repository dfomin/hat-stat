//
//  Game.swift
//  HatStat
//
//  Created by Dmitry Fomin on 26/05/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

class Game {
    
    let id: String
    let deviceId: String
    let words: [Word]
    let teams: [Team]
    var rounds = [Round]()
    
    var averageWordTime: Double {
        get {
            let times = rounds.flatMap{ $0.roundWords }.flatMap{ $0.time }
            return times.isEmpty ? 0 : times.reduce(0, +) / Double(times.count)
        }
    }
    
    var guessedWords: Int {
        get {
            return rounds.flatMap{ $0.roundWords }.filter{ $0.state == .guessed }.count
        }
    }
    
    var deletedWords: Int {
        get {
            return rounds.flatMap{ $0.roundWords }.filter{ $0.state == .deleted }.count
        }
    }
    
    init?(json: JSON) {
        if let id = json["id"].string {
            self.id = id
        } else {
            return nil
        }
        
        if let deviceId = json["deviceid"].string, !deviceId.isEmpty {
            self.deviceId = deviceId
        } else {
            return nil
        }
        
        var words = [Word]()
        let jsonWords = json["words"]
        for (jsonId, jsonWord) in jsonWords {
            words.append(Word(id: Int(jsonId)!, json: jsonWord))
        }
        
        self.words = words.sorted{ $0.id < $1.id }
        
        var teams = [Team]()
        let jsonTeams = json["teams"]
        for (_, jsonTeam) in jsonTeams {
            teams.append(Team(json: jsonTeam))
        }
        
        self.teams = teams
    }
    
    func fixRounds() -> Bool {
        rounds.sort{ $0.roundNumber < $1.roundNumber }
        for (i, round) in rounds.enumerated() {
            if i != round.roundNumber {
                return false
            }
        }
        
        return true
    }
    
    func checkForReal() -> Bool {
        return averageWordTime > 2.0 && (guessedWords + deletedWords >= words.count) && words.count >= 10
    }
}
