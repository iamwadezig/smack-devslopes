//
//  LoginViewController.swift
//  smack@devslopes
//
//  Created by Ario Nugroho on 21/08/19.
//  Copyright © 2019 Ario Nugroho. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func closePressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
        
    }
}
