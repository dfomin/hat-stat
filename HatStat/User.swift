//
//  User.swift
//  HatStat
//
//  Created by Dmitry Fomin on 31/05/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

class User {
    
    var deviceId: String
    var deviceModel: String
    var device: String
    var os: String
    var osVersion: String
    var version: String
    var pushToken: String
    var timestamp: Int
    
    init?(json: JSON) {
        deviceId = json["deviceid"].stringValue
        deviceModel = json["deviceModel"].stringValue
        device = json["device"].stringValue
        os = json["os"].stringValue
        osVersion = json["osVersion"].stringValue
        version = json["version"].stringValue
        pushToken = json["pushToken"].stringValue
        timestamp = json["timestamp"].intValue
    }
}
