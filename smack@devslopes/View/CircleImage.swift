//
//  CircleImage.swift
//  smack@devslopes
//
//  Created by Ario Nugroho on 25/08/19.
//  Copyright © 2019 Ario Nugroho. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {

    override func awakeFromNib() {
        self.setupView()
    }

    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
}
