//
//  Pack.swift
//  HatStat
//
//  Created by Dmitry Fomin on 09/07/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

class Pack {
    
    let id: Int
    let name: String
    let description: String
    let language: String
    let version: Int
    let paid: Bool
    let words: [String: PackWord]
    
    init(json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        description = json["description"].stringValue
        language = json["language"].stringValue
        version = json["version"].intValue
        paid = json["paid"].boolValue
        
        var words = [String: PackWord]()
        
        for object in json["phrases"].array! {
            let word = PackWord(json: object)
            words[word.word] = word
        }
        
        self.words = words
    }
}
