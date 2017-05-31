//
//  PackUsage.swift
//  HatStat
//
//  Created by Dmitry Fomin on 31/05/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

class PackUsage {
    
    var packStat = [Int: Int]()
    
    func process(game: Game) {
        for word in game.words {
            let packId = word.packId
            if packStat[packId] == nil {
                packStat[packId] = 1
            } else {
                packStat[packId]! += 1
            }
        }
    }
}
