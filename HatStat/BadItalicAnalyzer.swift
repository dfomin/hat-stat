//
//  BadItalicAnalyzer.swift
//  HatStat
//
//  Created by Dmitry Fomin on 30/05/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

class BadItalicAnalyzer {
    
    var enableStat = (on: 0, off: 0)
    var disabledInProcess = 0
    
    func process(game: Game) {
        if game.rounds.first!.settings.badItalic {
            enableStat = (enableStat.on + 1, enableStat.off)
        } else {
            enableStat = (enableStat.on, enableStat.off + 1)
        }
        
        if game.rounds.first!.settings.badItalic {
            for round in game.rounds {
                if !round.settings.badItalic {
                    disabledInProcess += 1
                    break;
                }
            }
        }
    }
}
