//
//  ChatViewController.swift
//  smack@devslopes
//
//  Created by Ario Nugroho on 21/08/19.
//  Copyright © 2019 Ario Nugroho. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    //Outlets
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var messageTextBox: UITextField!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //bind the view to keyboard
        view.bindToKeyboard()
        //dismiss keyboard when tapping outside keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatViewController.handleTap))
        self.view.addGestureRecognizer(tap)
        //menu button on top left corner will reveal the channel view controller
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        //customize with and drag swreveal
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        //tap to dismiss from rear view controller ie. channel view controller
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)

        //shooting out chatviewcontroller that we have selected channel so that we can listen that notification
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        
        //check if we already login
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }
        
        //load available channel
//        MessageService.instance.findAllChannel { (success) in
//
//        }
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            //get channels
            onLoginGetMessages()
        } else {
            channelNameLabel.text = "Please Login"
        }
    }
    
    @objc func channelSelected(_ notif: Notification) {
        
        updateWithChannel()
        
    }
    
    //use to dismiss keyboard
    @objc func handleTap() {
        
        view.endEditing(true)
        
    }
    
    func updateWithChannel() {
        //we have to unwrap selected channel because it can contain nil(when its not selected) if there is value then fill the string else use empty string (coalescing nil)
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLabel.text = "#\(channelName)"
        getMessages()
    }
    
    @IBAction func sendMessagePressed(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
            //get channel id and textfield
            guard let channelId = MessageService.instance.selectedChannel?.id else {return}
            guard let message = messageTextBox.text else {return}
            
            //called socket
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId) { (success) in
                if success {
                    //message text will reset to blank string
                    self.messageTextBox.text = ""
                    //and dismiss keyboard
                    self.messageTextBox.resignFirstResponder()
                }
            }
        }
        
    }
    
    func onLoginGetMessages() {
        MessageService.instance.findAllChannel { (success) in
            if success {
                //do stuff with channel
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelNameLabel.text = "No Channels Yet!"
                }
            }
        }
    }
    
    func getMessages() {
        
        guard let channelId = MessageService.instance.selectedChannel?.id else {return}
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            
        }
        
    }

}
