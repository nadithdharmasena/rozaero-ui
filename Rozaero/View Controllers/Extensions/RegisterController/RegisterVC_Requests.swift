//
//  RegisterVC_Requests.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/17/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit
import Alamofire

extension RegisterController {
    
    func makeRequest () {
        
        let username = usernameInput.input.text!
        let email = emailInput.input.text!
        let password = passwordInput.input.text!
        let retypePassword = retypePasswordInput.input.text!
        let registerURL = Globals.baseURL + "register"
        
        let myParams: [String: Any] = [
            "username": username,
            "email": email,
            "password": password,
            "retype_password": retypePassword
        ]
        
        Alamofire.request(registerURL, method: .post, parameters: myParams, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            if let responseJSON = response.result.value {
                
                let responseObject:Dictionary<String, Any> = responseJSON as! Dictionary<String, Any>
                let statusCode = responseObject["status"] as! Int
                
                switch (statusCode) {
                case Globals.passwordMismatchError:
                    print("Mismatched password")
                case Globals.usernameError:
                    print("Username taken")
                    Globals.displayWarning(input: self.usernameInput, message: "Already taken")
                case Globals.emailError:
                    print("Email already registered")
                    Globals.displayWarning(input: self.emailInput, message: "Already registered")
                case Globals.databaseError, Globals.internalError, Globals.inputError:
                    Globals.displayAlert(header: "Internal Error", message: "There was a problem with Rozaero's servers. Please try again later.", whichVC: self)
                case Globals.successResponse:
                    
                    let data = responseObject["data"] as! String
                    
                    self.dismiss(animated: false)

                    let validateEmailController: ValidateEmailController = ValidateEmailController()
                    validateEmailController.username = data
                    self.presentingViewController?.present(validateEmailController, animated: true)
                    
                default:
                    Globals.displayAlert(header: "Something went wrong", message: "We really do not know what this error is. Hopefully, we fix it in the future.", whichVC: self)
                }
                
                
            }
            
        }
        
    }
    
    func validateUsername () -> Bool {
        let username: String = usernameInput.input.text!

        if Globals.isEmpty(inputStr: username) {
            Globals.displayWarning(input: usernameInput, message: "Enter a username")
            return false
        } else if (username.count > 24) {
            Globals.displayWarning(input: usernameInput, message: "Too many characters")
            return false
        }

        return true
    }
    
    func validateEmail () -> Bool {
        let email: String = emailInput.input.text!
        
        if Globals.isEmpty(inputStr: email) {
            Globals.displayWarning(input: emailInput, message: "Enter an email address")
            return false
        } else if email.range(of: Globals.emailRegExp, options: .regularExpression) == nil {
            Globals.displayWarning(input: emailInput, message: "Invalid email address format")
            return false
        }
        
        return true
    }
    
    func validatePassword () -> Bool {
        let password: String = passwordInput.input.text!
        let retype: String = retypePasswordInput.input.text!
        
        if Globals.isEmpty(inputStr: password) || Globals.isEmpty(inputStr: retype) {
            if Globals.isEmpty(inputStr: password) {
                Globals.displayWarning(input: passwordInput, message: "Enter a password")
            }
            
            if Globals.isEmpty(inputStr: retype) {
                Globals.displayWarning(input: retypePasswordInput, message: "Re-enter password format")
            }
            
            return false
        } else if password != retype {
            Globals.displayWarning(input: passwordInput, message: "Passwords do not match")
            Globals.displayWarning(input: retypePasswordInput, message: "Passwords do not match")
            return false
        }
        
        return true
        
    }
    
}
