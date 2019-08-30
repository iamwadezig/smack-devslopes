//
//  SocketService.swift
//  smack@devslopes
//
//  Created by Ario Nugroho on 29/08/19.
//  Copyright © 2019 Ario Nugroho. All rights reserved.
//

import UIKit
import SocketIO

class SocketService : NSObject {
    
    static let instance = SocketService()
    
    let manager = SocketManager(socketURL: URL(string: "\(BASE_URL)")!)
    //note ! cannot use var. already tried lazy var socket: SocketIOClient = SocketManager(blabla).defaultsocket it wont work too
    lazy var socket: SocketIOClient = manager.defaultSocket
    
    override init() {
        super.init()
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
        
    }
    
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        socket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        //listening when new channelCreated created
        socket.on("channelCreated") { (dataArray, ack) in
            //parsed out information and append to messageservice array
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDesc = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            //create new object called newchannel
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            //append it to array
            MessageService.instance.channels.append(newChannel)
            completion(true)
            
        }
    }
}

    
    
    

