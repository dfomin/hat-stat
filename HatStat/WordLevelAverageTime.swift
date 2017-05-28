//
//  WordLevelAverageTime.swift
//  HatStat
//
//  Created by Dmitry Fomin on 28/05/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

class WordLevelAverageTime {
    
    var words = [String: (level: Double, timeLevel: Double)]()
    
    func add(word: String, level: Double, averageTime: Double) {
        words[word] = (level, WordLevelAverageTime.timeBasedLevel(time: averageTime))
    }
    
    static func timeBasedLevel(time: Double) -> Double {
        if time < 8.0 {
            return 1
        } else if time < 12.0 {
            return 2
        } else if time < 16.0 {
            return 3
        } else if time < 20.0 {
            return 4
        } else {
            return 5
        }
    }
}
