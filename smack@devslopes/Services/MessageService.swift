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
    
    func clearAllChannel() {
        
        channels.removeAll()
        
    }
}
