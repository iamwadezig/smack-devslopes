//
//  LoginViewController.swift
//  smack@devslopes
//
//  Created by Ario Nugroho on 21/08/19.
//  Copyright © 2019 Ario Nugroho. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //Outlets
    
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passText: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard let email = userNameText.text, userNameText.text != "" else {return}
        guard let pass = passText.text, passText.text != "" else {return}
        
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    
    @IBAction func closePressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
        
    }
    
    func setupView() {
        spinner.isHidden = true
        userNameText.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedString.Key.foregroundColor:smackPurplePlaceHolder])
        passText.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedString.Key.foregroundColor:smackPurplePlaceHolder])
    }
}
