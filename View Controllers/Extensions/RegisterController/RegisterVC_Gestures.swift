//
//  RegisterVC_Gestures.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/17/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

extension RegisterController {
    
    @objc
    func handleRegisterTap (sender: UIButton) {
        
        if valid {
            
            let isUsernameValid: Bool = validateUsername()
            let isEmailValid: Bool = validateEmail()
            let isPasswordValid: Bool = validatePassword()
            
            
            if isUsernameValid && isEmailValid && isPasswordValid {
                // Post information to server
                valid = false
                makeRequest()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.valid = true
                }
            }
            
        }
        
    }
    
    @objc
    func handleSwipeRight (sender: UIPanGestureRecognizer) {
        
        if sender.translation(in: sender.view).x > CGFloat(integerLiteral: 25) && swipeable {
            
            swipeable = false
            self.performSegue(withIdentifier: "registerToLogin", sender: self)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.swipeable = true
            }
            
        }
        
    }
    
}
