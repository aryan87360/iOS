//
//  UserSingleton.swift
//  SnapchatClone
//
//  Created by Aryan Sharma on 15.01.2024.


import Foundation

class UserSingleton {
    
    static let sharedUserInfo = UserSingleton()
    
    var email = ""
    var username = ""
    
    private init() {
        
    }
    
    
}
