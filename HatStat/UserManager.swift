//
//  UserManager.swift
//  HatStat
//
//  Created by Dmitry Fomin on 31/05/2017.
//  Copyright © 2017 Pigowl. All rights reserved.
//

import Foundation

class UserManager {
    
    var users = [String: [User]]()
    
    var uniqueUsers: Int {
        return users.count
    }
    
    func add(user: User) {
        if users[user.deviceId] == nil {
            users[user.deviceId] = [user]
        } else {
            users[user.deviceId]!.append(user)
        }
    }
}
