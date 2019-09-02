//
//  KeyboardBoundView.swift
//  SmackAlpha
//
//  Created by Jonny B on 7/11/17.
//  Copyright © 2017 Jonny B. All rights reserved.
//

import UIKit

//not great approach for ui in iphonex but for tutorials sake we will use it, use angela yu (appBrewery) approach i think its programmatic
//binding the uiview to the keyboard, so when the view selected it will rose up following keyboard pop up from bottom

extension UIView {
    
    func bindToKeyboard(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(UIView.keyboardWillChange(_:)), name: UIApplication.keyboardWillChangeFrameNotification, object: nil)
        
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let curFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let deltaY = targetFrame.origin.y - curFrame.origin.y
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: {
            self.frame.origin.y += deltaY
            
        },completion: {(true) in
            self.layoutIfNeeded()
        })
    }
}
