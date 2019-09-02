//
//  MessageService.swift
//  smack@devslopes
//
//  Created by Ario Nugroho on 28/08/19.
//  Copyright © 2019 Ario Nugroho. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    //need selected channel variable
    var messages = [Message]()
    var selectedChannel : Channel?
    //find all available channel
    func findAllChannel(completion: @escaping CompletionHandler) {
        Alamofire.request(URL_GET_CHANNEL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                guard let data = response.data else {return}
                
                //when Channel.swift model using decodable protocol
//
//                do {
//                self.channels = try JSONDecoder().decode([Channel].self, from: data)
//                } catch {
//                    print(error)
//                }
//
//                print(self.channels)
        
                
                do {
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let name = item["name"].stringValue
                            let channelDescription = item["description"].stringValue
                            let id = item["_id"].stringValue
                            
                            let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                            self.channels.append(channel)
                        }
                        NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                        print(MessageService.instance.channels.count)
                        completion(true)
                    }
                    
              
                } catch {
                    print(error)
                }
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    func findAllMessagesForChannel(channelId: String, completion: @escaping CompletionHandler) {
        
        Alamofire.request("\(URL_GET_MSG)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                
                self.clearMessages()
                guard let data = response.data else {return}
                
                do {
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let messageBody = item["messageBody"].stringValue
                            let id = item["_id"].stringValue
                            let userName = item["userName"].stringValue
                            let userAvatar = item["userAvatar"].stringValue
                            let channelId = item["channelId"].stringValue
                            let userAvatarColor = item["userAvatarColor"].stringValue
                            let timeStamp = item["timeStamp"].stringValue
                            
                            let newMessages = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                            
                            self.messages.append(newMessages)
                        }
                        
                        //NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                        //print(MessageService.instance.channels.count)
                        print(self.messages)
                        completion(true)
                    }
                } catch {
                    print(error)
                }
                
            } else {
                
                debugPrint(response.result.error as Any)
                completion(false)
                
            }
        }
        
    }
    
    func clearMessages() {
        
        messages.removeAll()
        
    }
    
    func clearAllChannel() {
        
        channels.removeAll()
        
    }
}
