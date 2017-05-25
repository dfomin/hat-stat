//
//  main.swift
//  HatStat
//
//  Created by Dmitry Fomin on 25/05/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

let objects = DBDumpFileReader.readFile(filePath: "/Users/dfomin/projects/hat-stat/games.json")
var jsonObjects = [JSON]()
for object in objects {
    let json = JSON(parseJSON: object)
    jsonObjects.append(json)
}

print(jsonObjects.count)
