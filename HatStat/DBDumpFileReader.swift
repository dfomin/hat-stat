//
//  DBDumpFileReader.swift
//  HatStat
//
//  Created by Dmitry Fomin on 25/05/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

class DBDumpFileReader {
    
    static func readFile(filePath: String) -> [String] {
        var content = ""
        do {
            content = try String(contentsOfFile: filePath)
        } catch {
            print("Failed to load file \(filePath)")
            return [String]()
        }
        
        let objects = content.components(separatedBy: "\n")
        return objects
    }
}
