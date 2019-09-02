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
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var typingUserLabel: UILabel!
    
    //Variables
    var isTyping = false
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //bind the view to keyboard
        view.bindToKeyboard()
        //dismiss keyboard when tapping outside keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatViewController.handleTap))
        self.view.addGestureRecognizer(tap)
        //set the delegate and datasource of tableview
        messageTableView.delegate = self
        messageTableView.dataSource = self
        //set the tableview estimated row height
        messageTableView.estimatedRowHeight = 80
        messageTableView.rowHeight = UITableView.automaticDimension
        
        sendButton.isHidden = true
        
        
        //menu button on top left corner will reveal the channel view controller
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        //customize with and drag swreveal
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        //tap to dismiss from rear view controller ie. channel view controller
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)

        //shooting out chatviewcontroller that we have selected channel so that we can listen that notification
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        //reload tableview when socket grab new message
        SocketService.instance.getChatMessage { (success) in
            if success {
                self.messageTableView.reloadData()
                //jump straight to the latest message
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.messageTableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
        }
        //typing user
        SocketService.instance.getTypingUser { (typingUsers) in
            guard let channelId = MessageService.instance.selectedChannel?.id else {return}
            var names = ""
            var numberOfTypers = 0
            
            for (typingUser, channel) in typingUsers {
                if typingUser != UserDataService.instance.name && channel == channelId {
                    if names == "" {
                        names = typingUser
                    } else {
                        names = "\(names), \(typingUser)"
                    }
                    numberOfTypers += 1
                }
            }
            
            if numberOfTypers > 0 && AuthService.instance.isLoggedIn == true {
                var verb = "is"
                if numberOfTypers > 1 {
                    verb = "are"
                }
                self.typingUserLabel.text = "\(names) \(verb) typing a message"
            } else {
                self.typingUserLabel.text = ""
            }
        }
        
        
        
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
            messageTableView.reloadData()
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
    
    @IBAction func messageBoxEditing(_ sender: Any) {
        guard let channelId = MessageService.instance.selectedChannel?.id else {return}
        if messageTextBox.text == "" {
            isTyping = false
            sendButton.isHidden = true
            SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
        } else {
            if isTyping == false {
                sendButton.isHidden = false
                SocketService.instance.socket.emit("startType", UserDataService.instance.name, channelId)
           }
            isTyping = true
        }
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
                    SocketService.instance.socket.emit("stopType", UserDataService.instance.name, channelId)
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
            if success {
                self.messageTableView.reloadData()
            }
            
        }
        
    }

}

extension ChatViewController: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        } else {
            return UITableViewCell()
        }
        
        
    }
    

    
}
