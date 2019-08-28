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
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //menu button on top left corner will reveal the channel view controller
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        //customize with and drag swreveal
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        //tap to dismiss from rear view controller ie. channel view controller
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())

        //check if we already login
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            }
        }
    }
    
    

}
