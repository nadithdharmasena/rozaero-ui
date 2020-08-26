//
//  RegisterControllerViewController.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/15/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit
import Alamofire

class RegisterController: UIViewController {
    
    var rBase: RegControllerBase!
    var register: RHText!
    var usernameInput: RInputWithLabel!
    var emailInput: RInputWithLabel!
    var passwordInput: RInputWithLabel!
    var retypePasswordInput: RInputWithLabel!
    var registerButton: RGButton!
    var lock: CustomImage!
    var valid: Bool = false
    
    var swipeable: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupLayout()
        
    }
    
    func setupLayout () {
        
        addBase()
        
        register = RHText(text: "Register")
        rBase.addView(view: register, width: Globals.getContainerWidth(), height: register.getHeight(), marginTop: Globals.getRegisterBelowLogoMargin())
        
        usernameInput = RInputWithLabel(label: "Username")
        rBase.addView(view: usernameInput, width: Globals.getContainerWidth(), height: usernameInput.getHeight(), marginTop: Globals.getRegisterInputMarginTop())
        usernameInput.input.delegate = rBase
        
        emailInput = RInputWithLabel(label: "Email Address")
        rBase.addView(view: emailInput, width: Globals.getContainerWidth(), height: emailInput.getHeight(), marginTop: Globals.getRegisterInputMarginTop())
        emailInput.input.delegate = rBase
        emailInput.input.keyboardType = .emailAddress
        
        passwordInput = RInputWithLabel(label: "Password")
        passwordInput.input.isSecureTextEntry = true
        rBase.addView(view: passwordInput, width: Globals.getContainerWidth(), height: passwordInput.getHeight(), marginTop: Globals.getRegisterInputMarginTop())
        passwordInput.input.delegate = rBase
        
        retypePasswordInput = RInputWithLabel(label: "Retype Password")
        retypePasswordInput.input.isSecureTextEntry = true
        rBase.addView(view: retypePasswordInput, width: Globals.getContainerWidth(), height: retypePasswordInput.getHeight(), marginTop: Globals.getRegisterInputMarginTop())
        retypePasswordInput.input.delegate = rBase
        
        addRegisterButton()
        
        rBase.regController = self
        rBase.resizeScreen()
        self.view.addSubview(rBase)
        
        if #available(iOS 11.0, *) {
            rBase.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
    }
    
    func addBase () {
        
        rBase = RegControllerBase(frame: CGRect())
        
    }
    
    func addRegisterButton () {
        registerButton = RGButton(text: "")
        registerButton.button.backgroundColor = Globals.buttonColor.withAlphaComponent(0.75)
        
        rBase.addView(view: registerButton, width: Globals.getContainerWidth(), height: Globals.buttonHeight, marginTop: Globals.getButtonMarginTop())
        
        lock = CustomImage(image_name: "Lock", width: 15, height: 23)
        lock.frame = CGRect(x: 0, y: 0, width: lock.width, height: lock.height)
        lock.backgroundColor = UIColor.clear
        lock.center.x = registerButton.center.x
        lock.center.y = registerButton.frame.height / 2
        registerButton.addSubview(lock)
        
        registerButton.button.addTarget(self, action: #selector(RegisterController.handleRegisterTap), for: .touchUpInside)
        
    }

}

