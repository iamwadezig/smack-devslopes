//
//  CreateChannelViewController.swift
//  smack@devslopes
//
//  Created by Ario Nugroho on 29/08/19.
//  Copyright © 2019 Ario Nugroho. All rights reserved.
//

import UIKit

class CreateChannelViewController: UIViewController {

    //Outlets
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var descText: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func createButtonPressed(_ sender: Any) {
        
        guard let channelName = userText.text, userText.text != "" else {return}
        guard let channelDesc = descText.text else {return}
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDesc) { (success) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func setupView() {
        
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(CreateChannelViewController.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        userText.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor:smackPurplePlaceHolder])
        descText.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedString.Key.foregroundColor:smackPurplePlaceHolder])
        
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        
        dismiss(animated: true, completion: nil)
        
    }
}
