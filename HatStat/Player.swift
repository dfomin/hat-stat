//
//  Player.swift
//  HatStat
//
//  Created by Dmitry Fomin on 26/05/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

class Player {
    
    let id: Int
    let name: String
    let penalty: Int
    
    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        penalty = json["penalty"].intValue
    }
}
