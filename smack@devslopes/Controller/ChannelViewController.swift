//
//  ChannelViewController.swift
//  smack@devslopes
//
//  Created by Ario Nugroho on 21/08/19.
//  Copyright © 2019 Ario Nugroho. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {

    //Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var avatarImage: CircleImage!
    @IBOutlet weak var tableView: UITableView!
    //create somekind of access point when ctrl click ing in createaccountviewcontroller in top label to exit symbol
    @IBAction func unwindFromCreateAccountViewController(unwindSegue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //setting the width of the revealed view controller minus the size of the menu button plus both left and right margin.
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 82
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelViewController.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        SocketService.instance.getChannel { (success) in
            if success {
                self.tableView.reloadData()
            }
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        setupUserInfo()
        
    }
    

    @IBAction func logInButtonPressed(_ sender: Any) {
        //check if we already have already logged in
        if AuthService.instance.isLoggedIn {
            //show profile xib
            let profile = ProfileViewController()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        
        setupUserInfo()
        
    }
    
    func setupUserInfo() {
        
        if AuthService.instance.isLoggedIn {
            loginButton.setTitle(UserDataService.instance.name, for: .normal)
            avatarImage.image = UIImage(named: UserDataService.instance.avatarName)
            avatarImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            loginButton.setTitle("Login", for: .normal)
            avatarImage.image = UIImage(named: "menuProfileIcon")
            avatarImage.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func addChannelButton(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
            let addChannel = CreateChannelViewController()
            addChannel.modalPresentationStyle = .custom
            present(addChannel, animated: true, completion: nil)
        }
        
    }
    
    
}

extension ChannelViewController : UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

extension ChannelViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    
}
