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
        
        self.words = words
        
        var teams = [Team]()
        let jsonTeams = json["teams"]
        for (_, jsonTeam) in jsonTeams {
            teams.append(Team(json: jsonTeam))
        }
        
        self.teams = teams
    }
}
