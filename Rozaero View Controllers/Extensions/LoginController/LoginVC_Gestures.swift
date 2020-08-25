//
//  LoginVC_Gestures.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/12/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

extension LoginController {
    
    @objc
    func handleLoginTap (sender: UIButton) {
        
        if valid {
            
            let isEmailValid: Bool = validateEmail()
            let isPasswordValid: Bool = validatePassword()
            
            
            if isEmailValid && isPasswordValid {
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
    func handleCreateAccountTap (sender: UITapGestureRecognizer) {
        
        let registerController = RegisterController()
        registerController.modalTransitionStyle = .coverVertical
        
        self.present(registerController, animated: true)
        
    }
    
    @objc
    func handleForgotPasswordTap (sender: UITapGestureRecognizer) {
    }
    
}
