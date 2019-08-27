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
    
    func returnUIColor(components: String) -> UIColor {
//        "[0.7490196078431373, 0.41568627450980394, 0.6862745098039216, 1]"
        
        //below are syntax to turn above value we pass in (we got it from mlab), when we create account to avatar background color on channel view controller
        
        //create scanner like in the movie, scanning string
        let scanner = Scanner(string: components)
        //will skip skipped which contain "[]" "," " "
        let skipped = CharacterSet(charactersIn: "[], ")
        //will stop at comma
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a : NSString?
        
        //next we will scan and save them to above variable
        //it will scan from 0 ignoring skipped object until before comma, and will pass into &r
        scanner.scanUpToCharacters(from: comma, into: &r)
        //scanning next
        scanner.scanUpToCharacters(from: comma, into: &g)
        //scanning next
        scanner.scanUpToCharacters(from: comma, into: &b)
        //scanning next
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        //if unwrap fail
        let defaultColor = UIColor.lightGray
        
        //guard statement to unwrap rgba variable
        
        guard let rUnwrapped = r else {return defaultColor}
        guard let gUnwrapped = g else {return defaultColor}
        guard let bUnwrapped = b else {return defaultColor}
        guard let aUnwrapped = a else {return defaultColor}
        
        //converting string to double with doubleValue then wrap it to convert into CGFloat
        let rfloat = CGFloat(rUnwrapped.doubleValue)
        let gfloat = CGFloat(gUnwrapped.doubleValue)
        let bfloat = CGFloat(bUnwrapped.doubleValue)
        let afloat = CGFloat(aUnwrapped.doubleValue)
        
        let newUIColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        return newUIColor
    }
    
    func logoutUser() {
        id = ""
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.userEmail = ""
        AuthService.instance.authToken = ""
    }
}
