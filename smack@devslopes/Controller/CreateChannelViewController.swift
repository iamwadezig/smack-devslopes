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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()

    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func createButtonPressed(_ sender: Any) {
        
    }
    
    func setupView() {
        spinner.isHidden = true
        
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(CreateChannelViewController.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
        
        userText.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedString.Key.foregroundColor:smackPurplePlaceHolder])
        descText.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedString.Key.foregroundColor:smackPurplePlaceHolder])
        
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        
        dismiss(animated: true, completion: nil)
        
    }
}
