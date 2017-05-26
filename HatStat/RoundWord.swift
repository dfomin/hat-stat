//
//  RoundWord.swift
//  HatStat
//
//  Created by Dmitry Fomin on 26/05/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

class RoundWord {
    
    let wordId: Int
    let time: Double
    let state: GuessingState
    
    init(json: JSON, state: GuessingState?) {
        wordId = json["word"].intValue
        time = json["time"].doubleValue
        
        if json["state"].exists() {
            assert(state == nil)
            self.state = GuessingState(rawValue: json["state"].intValue)!
        } else if state != nil {
            self.state = state!
        } else {
            if json["deleted"].boolValue {
                self.state = .deleted
            } else {
                self.state = json["guessed"].boolValue ? .guessed : .unguessed
            }
        }
    }
}
