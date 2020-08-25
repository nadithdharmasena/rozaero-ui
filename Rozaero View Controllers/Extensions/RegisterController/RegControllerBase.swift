//
//  RegControllerBase.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/17/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class RegControllerBase: RBase {
    
    var regController: RegisterController!
    
    func validate () {
        if areEmpty() {
            regController.valid = false
            
            regController.registerButton.button.setTitle("", for: .normal)
            regController.registerButton.button.backgroundColor = Globals.buttonColor.withAlphaComponent(0.75)
            
            regController.registerButton.addSubview(regController.lock)
            
        } else {
            regController.valid = true
            
            regController.lock.removeFromSuperview()
            regController.registerButton.button.setTitle("Register", for: .normal)
            regController.registerButton.button.backgroundColor = Globals.buttonColor
        }
    }
    
    func areEmpty () -> Bool {
        
        let username = regController.usernameInput.input.text!
        let email: String = regController.emailInput.input.text!
        let password: String = regController.passwordInput.input.text!
        let retype: String = regController.retypePasswordInput.input.text!
        
        let usernameEmpty = !Globals.isEmpty(inputStr: username)
        let emailEmpty = !Globals.isEmpty(inputStr: email)
        let passwordEmpty = !Globals.isEmpty(inputStr: password)
        let retypeEmpty = !Globals.isEmpty(inputStr: retype)
        
        if usernameEmpty && emailEmpty && passwordEmpty && retypeEmpty {
            return false
        }
        
        return true
        
    }
    
}

extension RegControllerBase {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.validate()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validate()
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let processedTextField: CustomTextField = textField as! CustomTextField
        let textFieldID: String = processedTextField.id
        
        switch (textFieldID) {
        case "Username":
            regController.emailInput.input.becomeFirstResponder()
        case "Email Address":
            regController.passwordInput.input.becomeFirstResponder()
        case "Password":
            regController.retypePasswordInput.input.becomeFirstResponder()
        default:
            break
        }
        
        return super.textFieldShouldReturn(textField)
    }
    
}
