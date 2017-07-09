//
//  PackWord.swift
//  HatStat
//
//  Created by Dmitry Fomin on 09/07/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

class PackWord {
    
    let word: String
    let level: Double
    let description: String
    
    init(json: JSON) {
        word = json["phrase"].stringValue
        level = json["levcomplexityel"].doubleValue
        description = json["description"].stringValue
    }
}
