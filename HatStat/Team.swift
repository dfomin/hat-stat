//
//  Team.swift
//  HatStat
//
//  Created by Dmitry Fomin on 26/05/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

class Team {
    
    let id: Int
    let name: String
    let players: [Player]
    
    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        
        var players = [Player]()
        for (_, jsonPlayer) in json["players"] {
            players.append(Player(json: jsonPlayer))
        }
        
        self.players = players
    }
}
