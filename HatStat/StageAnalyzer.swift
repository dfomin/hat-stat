//
//  StageAnalyzer.swift
//  HatStat
//
//  Created by Dmitry Fomin on 30/05/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

class StageAnalyzer {
    
    var stages = [Int: Int]()
    
    func process(game: Game) {
        let stage = (game.guessedWords + game.deletedWords) / game.words.count
        
        if stages[stage] == nil {
            stages[stage] = 1
        } else {
            stages[stage]! += 1
        }
    }
}
