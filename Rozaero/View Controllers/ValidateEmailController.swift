//
//  ValidateEmailViewController.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/16/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit
import Alamofire

class ValidateEmailController: UIViewController {
    
    var rBase: ValidateEmailBase!
    var validateEmail: RHText!
    var explanation: RParagraph!
    var codeInput: RInputWithLabel!
    var validateButton: RGButton!
    var lock: CustomImage!
    
    var username: String!
    var valid: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupLayout()
        
    }
    
    func setupLayout () {
        
        rBase = ValidateEmailBase(frame: CGRect())
        
        validateEmail = RHText(text: "Validate Email")
        rBase.addView(view: validateEmail, width: Globals.getContainerWidth(), height: validateEmail.getHeight(), marginTop: Globals.getBelowLogoMargin())
        
        explanation = RParagraph(text: Globals.validateEmailMessage)
        explanation.textView.frame = CGRect(x: 0, y: 0, width: Globals.getContainerWidth(), height: explanation.getHeight())
        rBase.addView(view: explanation, width: Globals.getContainerWidth(), height: explanation.getHeight(), marginTop: Globals.paragraphBelowHeaderMargin)
        
        codeInput = RInputWithLabel(label: "Enter Code")
        rBase.addView(view: codeInput, width: Globals.getContainerWidth(), height: codeInput.getHeight(), marginTop: Globals.getInputMarginTop())
        codeInput.input.delegate = rBase
        codeInput.input.autocapitalizationType = .allCharacters
        
        addValidateButton()
        
        rBase.valEmailController = self
        rBase.resizeScreen()
        self.view.addSubview(rBase)
        
        if #available(iOS 11.0, *) {
            rBase.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
    }
    
    func addValidateButton () {
        validateButton = RGButton(text: "")
        validateButton.button.backgroundColor = Globals.buttonColor.withAlphaComponent(0.75)
        
        rBase.addView(view: validateButton, width: Globals.getContainerWidth(), height: Globals.buttonHeight, marginTop: Globals.getButtonMarginTop())
        
        lock = CustomImage(image_name: "Lock", width: 15, height: 23)
        lock.frame = CGRect(x: 0, y: 0, width: lock.width, height: lock.height)
        lock.backgroundColor = UIColor.clear
        lock.center.x = validateButton.center.x
        lock.center.y = validateButton.frame.height / 2
        validateButton.addSubview(lock)
        
        validateButton.button.addTarget(self, action: #selector(ValidateEmailController.handleValidateTap), for: .touchUpInside)
    }

}

extension ValidateEmailController {
    
    @objc
    func handleValidateTap (sender: UIButton) {
        
        if valid {
            
            let isCodeValid: Bool = validateCode()
            
            
            if isCodeValid {
                // Post information to server
                valid = false
                makeRequest()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.valid = true
                }
            }
            
        }
        
    }
    
}

extension ValidateEmailController {
    
    func makeRequest () {
        
        let username = self.username
        let code = codeInput.input.text!
        let validateURL = Globals.baseURL + "register/validate"
        
        let myParams: [String: Any] = [
            "username": username!,
            "code": code
        ]
        
        print(validateURL)
        
        Alamofire.request(validateURL, method: .post, parameters: myParams, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            if let responseJSON = response.result.value {
                
                let responseObject:Dictionary<String, Any> = responseJSON as! Dictionary<String, Any>
                let statusCode = responseObject["status"] as! Int
                
                switch (statusCode) {
                case Globals.wrongCodeResponse:
                    Globals.displayWarning(input: self.codeInput, message: "Invalid code")
                case Globals.databaseError, Globals.internalError, Globals.inputError:
                    Globals.displayAlert(header: "Internal Error", message: "There was a problem with Rozaero's servers. Please try again later.", whichVC: self)
                case Globals.successResponse:
                    
                    self.dismiss(animated: true)
                    
                default:
                    Globals.displayAlert(header: "Something went wrong", message: "We really do not know what this error is. Hopefully, we fix it in the future.", whichVC: self)
                }
                
            }
            
        }
        
    }
    
    func validateCode () -> Bool {
        
        if rBase.isInvalid() {
            Globals.displayWarning(input: codeInput, message: "Invalid code")
            return false
        }
        
        return true
    }
    
}

class ValidateEmailBase: RBase {
    
    var valEmailController: ValidateEmailController!
    
    func validate () {
        if isInvalid() {
            valEmailController.valid = false
            
            valEmailController.validateButton.button.setTitle("", for: .normal)
            valEmailController.validateButton.button.backgroundColor = Globals.buttonColor.withAlphaComponent(0.75)
            
            valEmailController.validateButton.addSubview(valEmailController.lock)
            
        } else {
            valEmailController.valid = true
            
            valEmailController.lock.removeFromSuperview()
            valEmailController.validateButton.button.setTitle("Validate", for: .normal)
            valEmailController.validateButton.button.backgroundColor = Globals.buttonColor
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.validate()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        validate()
    }
    
    func isInvalid () -> Bool {
        return valEmailController.codeInput.input.text!.count != 8 ? true : false
    }
}
