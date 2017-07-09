//
//  DBDumpLoader.swift
//  HatStat
//
//  Created by Dmitry Fomin on 26/05/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

class DBDumpLoader {
    
    static func loadGames() -> [JSON] {
        return loadObjects(path: "/Users/dfomin/projects/hat-stat/games.json")
    }
    
    static func loadRounds() -> [JSON] {
        return loadObjects(path: "/Users/dfomin/projects/hat-stat/rounds.json")
    }
    
    static func loadUsers() -> [JSON] {
        return loadObjects(path: "/Users/dfomin/projects/hat-stat/users.json")
    }
    
    static func loadPacks() -> [JSON] {
        return loadObjects(path: "/Users/dfomin/projects/hat-stat/packs.json")
    }
    
    private static func loadObjects(path: String) -> [JSON] {
        let objects = DBDumpFileReader.readFile(filePath: path)
        var jsonObjects = [JSON]()
        for object in objects {
            let json = JSON(parseJSON: object)
            jsonObjects.append(json)
        }
        
        return jsonObjects
    }
}
