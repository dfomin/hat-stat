//
//  Settings.swift
//  HatStat
//
//  Created by Dmitry Fomin on 26/05/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

class Settings {
    
    let canChangeWord: Bool
    let roundTime: Int
    let badItalic: Bool
    
    init(json: JSON) {
        canChangeWord = json["canchangeword"].boolValue
        roundTime = json["roundtime"].intValue
        badItalic = json["baditalicsimulated"].boolValue
    }
}
