//
//  WordPopularity.swift
//  HatStat
//
//  Created by Dmitry Fomin on 27/05/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

class WordPopularity {
    
    private var words = [Int: [String: Set<String>]]()
    
    func add(word: String, packId: Int, uniqueId: String) {
        if words[packId] != nil {
            if words[packId]![word] != nil {
                words[packId]![word]!.insert(uniqueId)
            } else {
                words[packId]![word] = Set([uniqueId])
            }
        } else {
            words[packId] = [word: Set([uniqueId])]
        }
    }
    
    func wordsFor(pack packId: Int) -> [(word: String, count: Int, ids: Set<String>)] {
        return words[packId]!.map{ key, value in (word: key, count: value.count, ids: value) }.sorted{ $0.count > $1.count }
    }
}
