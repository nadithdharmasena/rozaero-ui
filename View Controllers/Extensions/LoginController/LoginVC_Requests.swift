//
//  LoginVC_Requests.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/12/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit
import Alamofire

extension LoginController {
    
    func makeRequest () {
        
        let email = emailInput.input.text!
        let password = passwordInput.input.text!
        let loginURL = Globals.baseURL + "login"
        
        let myParams: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        Alamofire.request(loginURL, method: .post, parameters: myParams, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            if let responseJSON = response.result.value {
                
                let responseObject:Dictionary<String, Any> = responseJSON as! Dictionary<String, Any>
                let statusCode = responseObject["status"] as! Int
                
                switch (statusCode) {
                case Globals.wrongPasswordResponse:
                    print("Wrong password")
                    Globals.displayWarning(input: self.passwordInput, message: "Wrong password")
                case Globals.noUserResponse:
                    print("Unrecognized email")
                    Globals.displayWarning(input: self.emailInput, message: "Unrecognized email address")
                case Globals.databaseError, Globals.internalError, Globals.inputError:
                    Globals.displayAlert(header: "Internal Error", message: "There was a problem with Rozaero's servers. Please try again later.", whichVC: self)
                case Globals.successResponse:
                    
                    let authToken = responseObject["data"] as! String
                    UserDefaults.standard.set(authToken, forKey: "authToken")
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "HomeController")
                    
                    self.view.window!.rootViewController = rootViewController
                    self.dismiss(animated: false)
                    
                default:
                    Globals.displayAlert(header: "Something went wrong", message: "We really do not know what this error is. Hopefully, we fix it in the future.", whichVC: self)
                }
                
                
            }
            
        }
        
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
        
        if Globals.isEmpty(inputStr: password) {
            Globals.displayWarning(input: passwordInput, message: "Enter a password")
            return false
        }
        
        return true
        
    }
    
    
}
