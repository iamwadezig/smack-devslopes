//
//  ChannelViewController.swift
//  smack@devslopes
//
//  Created by Ario Nugroho on 21/08/19.
//  Copyright © 2019 Ario Nugroho. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    //create somekind of access point when ctrl click ing in createaccountviewcontroller in top label to exit symbol
    @IBAction func unwindFromCreateAccountViewController(unwindSegue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setting the width of the revealed view controller minus the size of the menu button plus both left and right margin.
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 82

    }
    

    @IBAction func logInButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
        
    }
    

}
