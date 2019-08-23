//
//  CreateAccountViewController.swift
//  smack@devslopes
//
//  Created by Ario Nugroho on 22/08/19.
//  Copyright © 2019 Ario Nugroho. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
   }
   
    @IBAction func closePressed(_ sender: Any) {
        //if you use dismiss it will return to previous vc, thats not what we want, we want it to go all the way back to initialvc. use the unwind
        performSegue(withIdentifier: TO_CHANNEL, sender: nil)
        
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
}
