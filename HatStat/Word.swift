//
//  Word.swift
//  HatStat
//
//  Created by Dmitry Fomin on 26/05/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

class Word {
    
    let id: Int
    let word: String
    let level: Double
    let badItalic: Bool
    let packId: Int
    let usage: Int
    
    init(id: Int, json: JSON) {
        self.id = id
        word = json["word"].stringValue
        level = json["level"].doubleValue
        badItalic = json["baditalic"].boolValue
        packId = json["packId"].intValue
        usage = json["usage"].intValue
    }
}
