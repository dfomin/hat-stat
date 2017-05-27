//
//  WordGuessTime.swift
//  HatStat
//
//  Created by Dmitry Fomin on 27/05/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

class WordGuessTime {
    
    var words = [String: (time: Double, count: Int)]()
    
    func add(word: String, time: Double, guessed: Bool) {
        if words[word] != nil {
            let oldTime = words[word]!.time
            let oldCount = words[word]!.count
            words[word] = (oldTime + time, oldCount + (guessed ? 1 : 0))
        } else {
            words[word] = (time, guessed ? 1 : 0)
        }
    }
    
    func statFor(word: String) -> (word: String, average: Double, time: Double, count: Int) {
        if let stat = words[word] {
            if stat.count > 0 {
                return (word, stat.time / Double(stat.count), stat.time, stat.count)
            } else {
                return (word, 0, 0, 0)
            }
        } else {
            return (word, 0, 0, 0)
        }
    }
    
    func fullStat() -> [(word: String, average: Double, time: Double, count: Int)] {
        var result = [(word: String, average: Double, time: Double, count: Int)]()
        for word in words.keys {
            let stat = statFor(word: word)
            if stat.count > 0 {
                result.append(stat)
            }
        }
        
        return result.sorted{ $0.average < $1.average }
    }
}
