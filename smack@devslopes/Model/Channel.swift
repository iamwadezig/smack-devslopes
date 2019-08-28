//
//  Channel.swift
//  smack@devslopes
//
//  Created by Ario Nugroho on 28/08/19.
//  Copyright © 2019 Ario Nugroho. All rights reserved.
//

import Foundation

struct Channel {
    
    public private(set) var channelTitle : String!
    public private(set) var channelDescription : String!
    public private(set) var id : String!
    
    //use when using decodable protocol, each var name must be the same as on body of the database, the drawback is that. but we prefer use above statement without protocol, just because its more customable, we can ignore which we dont need. with decodable you have to list all available variable in database.
//
//    public private(set) var _id : String!
//    public private(set) var description : String!
//    public private(set) var name : String!
//    public private(set) var __v : Int?
    
}
