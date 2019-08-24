//
//  CreateAccountViewController.swift
//  smack@devslopes
//
//  Created by Ario Nugroho on 22/08/19.
//  Copyright © 2019 Ario Nugroho. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   }
   
    @IBAction func closePressed(_ sender: Any) {
        //if you use dismiss it will return to previous vc, thats not what we want, we want it to go all the way back to initialvc. use the unwind. set it up first on ChannelViewController because we want to go there when dismiss
        performSegue(withIdentifier: TO_CHANNEL, sender: nil)
        
    }
    
    //Buttons
    @IBAction func pickAvatarPressed(_ sender: Any) {
    }
    @IBAction func pickBGColorPressed(_ sender: Any) {
    }
    @IBAction func createAccountPressed(_ sender: Any) {
        //alternative of unwrapping optional string
        guard let email = emailTxt.text , emailTxt.text != "" else {return}
        guard let pass = passTxt.text , passTxt.text != "" else {return}
        
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            
            if success {
                print("registered user!")
            }
        }
        
    }
}
