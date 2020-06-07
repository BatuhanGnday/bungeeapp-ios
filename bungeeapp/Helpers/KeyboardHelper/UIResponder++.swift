//
//  UIResponder++.swift
//  bungeeapp
//
//  Created by Batuhan Günday on 6.06.2020.
//  Copyright © 2020 Bungee Inc. All rights reserved.
//

import UIKit

extension UIResponder {

    private static weak var _currentFirstResponder: UIResponder?

    private static var currentFirstResponder: UIResponder? {
        _currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)

        return _currentFirstResponder
    }

    @objc func findFirstResponder(_ sender: Any) {
        UIResponder._currentFirstResponder = self
    }
    
    static func getBoundsOfFirstResponder() -> CGRect {
        if let firstResponder = self.currentFirstResponder,
            firstResponder.isKind(of: UITextField.self) {
            let firstResponderView = firstResponder as! UITextField
            var frame = firstResponderView.frame
            let position = firstResponderView.superview?.convert(firstResponderView.frame.origin, to: nil)
            
            frame.origin = position!
            return frame
        }
        return CGRect.zero
        
    }
    
    static func getFirstResponderView() -> UIView? {
        if let firstResponder = self.currentFirstResponder,
            firstResponder.isKind(of: UITextField.self) {
            let firstResponderView = firstResponder as! UITextField

            return firstResponderView
        }
        return nil
    }
    
}
