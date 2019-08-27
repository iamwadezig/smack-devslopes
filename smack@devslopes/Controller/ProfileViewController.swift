//
//  ProfileViewController.swift
//  smack@devslopes
//
//  Created by Ario Nugroho on 27/08/19.
//  Copyright © 2019 Ario Nugroho. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    //Outlets

    @IBOutlet weak var nameProfile: UILabel!
    @IBOutlet weak var emailProfile: UILabel!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
   }

    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
        
    }
    
    func setupView() {
        
        nameProfile.text = UserDataService.instance.name
        emailProfile.text = UserDataService.instance.email
        imageProfile.image = UIImage(named: UserDataService.instance.avatarName)
        imageProfile.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

}
