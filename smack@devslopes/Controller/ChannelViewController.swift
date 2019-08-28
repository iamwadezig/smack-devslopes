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
    //create somekind of access point when ctrl click ing in createaccountviewcontroller in top label to exit symbol
    @IBAction func unwindFromCreateAccountViewController(unwindSegue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting the width of the revealed view controller minus the size of the menu button plus both left and right margin.
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 82
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelViewController.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)

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

    
}
