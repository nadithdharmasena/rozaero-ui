//
//  ViewController.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/8/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit
import Alamofire

class LoginController: UIViewController {
    
    var rBase:LoginControllerBase!
    var login: RHText!
    var emailInput: RInputWithLabel!
    var passwordInput: RInputWithLabel!
    var loginButton: RGButton!
    var createAccount: RPrompt!
    var forgotPassword: RPrompt!
    
    var valid: Bool = true
    var swipeable: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupLayout()
        
    }
    
    func setupLayout () {
        
        rBase = LoginControllerBase(frame: CGRect())
        
        login = RHText(text: "Login")
        rBase.addView(view: login, width: Globals.getContainerWidth(), height: login.getHeight(), marginTop: Globals.getBelowLogoMargin())
        
        emailInput = RInputWithLabel(label: "Email Address")
        rBase.addView(view: emailInput, width: Globals.getContainerWidth(), height: emailInput.getHeight(), marginTop: Globals.getInputMarginTop())
        emailInput.input.delegate = rBase
        
        passwordInput = RInputWithLabel(label: "Password")
        passwordInput.input.isSecureTextEntry = true
        rBase.addView(view: passwordInput, width: Globals.getContainerWidth(), height: passwordInput.getHeight(), marginTop: Globals.getInputMarginTop())
        passwordInput.input.delegate = rBase
        
        addLoginButton()
        addCreateAccount()
        addForgotPassword()
        
        rBase.loginController = self
        rBase.resizeScreen()
        self.view.addSubview(rBase)
        
        if #available(iOS 11.0, *) {
            rBase.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
    }
    
    func addLoginButton () {
        loginButton = RGButton(text: "Login")
        rBase.addView(view: loginButton, width: Globals.getContainerWidth(), height: Globals.buttonHeight, marginTop: Globals.getButtonMarginTop())
        
        loginButton.button.addTarget(self, action: #selector(LoginController.handleLoginTap), for: .touchUpInside)
    }
    
    func addCreateAccount () {
        createAccount = RPrompt(text: "Create an account.")
        rBase.addView(view: createAccount, width: Globals.getContainerWidth(), height: createAccount.getHeight(), marginTop: Globals.getInputMarginTop())
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginController.handleCreateAccountTap))
        createAccount.prompt.addGestureRecognizer(tapGesture)
    }
    
    func addForgotPassword () {
        forgotPassword = RPrompt(text: "Forgot my password.")
        rBase.addView(view: forgotPassword, width: Globals.getContainerWidth(), height: createAccount.getHeight(), marginTop: Globals.getPromptMarginTop())
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginController.handleForgotPasswordTap))
        forgotPassword.prompt.addGestureRecognizer(tapGesture)
    }

}


class LoginControllerBase: RBase {
    
    var loginController: LoginController!
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let processedTextField: CustomTextField = textField as! CustomTextField
        let textFieldID: String = processedTextField.id
        
        switch (textFieldID) {
        case "Email Address":
            loginController.passwordInput.input.becomeFirstResponder()
        default:
            break
        }
        
        return super.textFieldShouldReturn(textField)
    }
    
}

