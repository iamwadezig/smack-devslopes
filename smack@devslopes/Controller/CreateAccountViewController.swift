//
//  CreateAccountViewController.swift
//  smack@devslopes
//
//  Created by Ario Nugroho on 22/08/19.
//  Copyright © 2019 Ario Nugroho. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    //MARK: - Default Variable
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor : UIColor?
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
   }
    //MARK: - View Did Appear
    override func viewDidAppear(_ animated: Bool) {
        
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && bgColor == nil {
                userImg.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    
    
    //MARK: - Close Button
    @IBAction func closePressed(_ sender: Any) {
        //if you use dismiss it will return to previous vc, thats not what we want, we want it to go all the way back to initialvc. use the unwind. set it up first on ChannelViewController because we want to go there when dismiss
        performSegue(withIdentifier: TO_CHANNEL, sender: nil)
        
    }
    //MARK: - Setup View
    //change the color text of placeholder text
    func setupView() {
        spinner.isHidden = true
        userNameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor:smackPurplePlaceHolder])
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor:smackPurplePlaceHolder])
        passTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor:smackPurplePlaceHolder])
        //tapping outside onscreen keyboard will dismiss keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountViewController.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    //MARK: - Pick Avatar Button
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    //MARK: - Change BackgroundColor Button
    @IBAction func pickBGColorPressed(_ sender: Any) {
        //create random backgroundcolor
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        UIView.animate(withDuration: 0.2) {
            self.userImg.backgroundColor = self.bgColor
        }
        
        
    }
    //MARK: - Create Account Button
    @IBAction func createAccountPressed(_ sender: Any) {
        //loading wheel
        spinner.isHidden = false
        spinner.startAnimating()
        //alternative of unwrapping optional string
        guard let userName = userNameTxt.text, userNameTxt.text != "" else {return}
        guard let email = emailTxt.text , emailTxt.text != "" else {return}
        guard let pass = passTxt.text , passTxt.text != "" else {return}
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success {
                        AuthService.instance.createUser(name: userName, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: TO_CHANNEL, sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                            }
                        })
                    }
                })
                // print("registered user!")
            }
        }
        
    }
}
