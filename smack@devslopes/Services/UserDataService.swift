//
//  UserDataService.swift
//  smack@devslopes
//
//  Created by Ario Nugroho on 24/08/19.
//  Copyright © 2019 Ario Nugroho. All rights reserved.
//

import Foundation

class UserDataService{

static let instance = UserDataService()
    //public means other can use it but private(set) only in this class can set it modify the value
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id:String, avatarColor:String, avatarName:String, email: String, name: String) {
        
        self.id = id
        self.avatarName = avatarName
        self.avatarColor = avatarColor
        self.email = email
        self.name = name
        
    }
    
    func setAvatarName(avatarName:String) {
        
        self.avatarName = avatarName
    }
}
