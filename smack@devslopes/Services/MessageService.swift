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
    var unreadChannels = [String]()
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
        
        Alamofire.request("\(URL_GET_MSG)/\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            
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
    //trying to translate timestamp output from JSON parsing
    
    func returnTimeStamp(components: String) -> String {
        //        "[0.7490196078431373, 0.41568627450980394, 0.6862745098039216, 1]"
        // {
        //   "$date": "2019-09-02T07:59:51.844Z"
        //}
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "{}, ,:,")
        let comma = CharacterSet(charactersIn: "T")
        scanner.charactersToBeSkipped = skipped
        
        var date, time : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &date)
        scanner.scanUpToCharacters(from: comma, into: &time)
        
        let defaultTime = ""
        
        guard let dateUnwrapped = date else {return defaultTime}
        guard let timeUnwrapped = time else {return defaultTime}
        
        let newTimeStamp = "\(dateUnwrapped) \(timeUnwrapped)"
        
        return newTimeStamp
        
        //below are syntax to turn above value we pass in (we got it from mlab), when we create account to avatar background color on channel view controller
        
        //create scanner like in the movie, scanning string
        //let scanner = Scanner(string: components)
        //will skip skipped which contain "[]" "," " "
        //let skipped = CharacterSet(charactersIn: "[], ")
        //will stop at comma
        //let comma = CharacterSet(charactersIn: ",")
        //scanner.charactersToBeSkipped = skipped
        
        //var r, g, b, a : NSString?
        
        //next we will scan and save them to above variable
        //it will scan from 0 ignoring skipped object until before comma, and will pass into &r
        //scanner.scanUpToCharacters(from: comma, into: &r)
        //scanning next
        //scanner.scanUpToCharacters(from: comma, into: &g)
        //scanning next
        //scanner.scanUpToCharacters(from: comma, into: &b)
        //scanning next
        //scanner.scanUpToCharacters(from: comma, into: &a)
        
        //if unwrap fail
        //let defaultColor = UIColor.lightGray
        
        //guard statement to unwrap rgba variable
        
        //guard let rUnwrapped = r else {return defaultColor}
        //guard let gUnwrapped = g else {return defaultColor}
        //guard let bUnwrapped = b else {return defaultColor}
        //guard let aUnwrapped = a else {return defaultColor}
        
        //converting string to double with doubleValue then wrap it to convert into CGFloat
        //let rfloat = CGFloat(rUnwrapped.doubleValue)
        //let gfloat = CGFloat(gUnwrapped.doubleValue)
        //let bfloat = CGFloat(bUnwrapped.doubleValue)
        //let afloat = CGFloat(aUnwrapped.doubleValue)
        
        //let newUIColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        //return newUIColor
    }
}

