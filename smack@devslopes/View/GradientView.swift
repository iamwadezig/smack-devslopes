//
//  GradientView.swift
//  smack@devslopes
//
//  Created by Ario Nugroho on 21/08/19.
//  Copyright © 2019 Ario Nugroho. All rights reserved.
//

import UIKit

//so it will be updated realtime in main.storyboard
@IBDesignable
class GradientView: UIView {
    
    //to update layout of this view
    @IBInspectable var topColor: UIColor = UIColor.blue {
        didSet {
            self.setNeedsLayout()
        }
    }
    @IBInspectable var bottomColor: UIColor = UIColor.green {
        didSet {
            self.setNeedsLayout()
        }
    }
    //create layer to added to this UIView SubClass ie. GradientView
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        //we can also set with 3 gradient color
        //gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor, topColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
}
