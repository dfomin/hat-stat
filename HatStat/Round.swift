//
//  Round.swift
//  HatStat
//
//  Created by Dmitry Fomin on 26/05/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

class Round {
    
    let gameId: String
    let roundNumber: Int
    let stage: Int
    let playerId: Int
    let time: Double
    let settings: Settings
    let roundWords: [RoundWord]
    
    init?(json: JSON) {
        gameId = json["gameid"].stringValue
        roundNumber = json["roundnumber"].intValue
        playerId = json["player"].intValue
        time = json["time"].doubleValue
        settings = Settings(json: json["settings"])
        
        if let stage = json["stage"].int {
            self.stage = stage
        } else {
            return nil
        }
        
        var roundWords = [RoundWord]()
        if json["skipped"].exists() {
            for (_, jsonWord) in json["skipped"] {
                roundWords.append(RoundWord(json: jsonWord, state: GuessingState.skipped))
            }
        }
        
        for (_, jsonWord) in json["words"] {
            roundWords.append(RoundWord(json: jsonWord, state: nil))
        }
        
        self.roundWords = roundWords
    }
}
