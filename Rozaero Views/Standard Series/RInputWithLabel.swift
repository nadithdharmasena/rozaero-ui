//
//  RInputWithLabel.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/8/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class RInputWithLabel: UIView {
    
    var input: CustomTextField!
    var label: RLabel!
    var line: CALayer!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (label: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        createInput(text: label)
        createLabel(text: label)
        
    }
    
    func createLabel (text: String) {
        
        label = RLabel(text: text)
        label.frame = CGRect(x: 15, y: input.frame.maxY + 8, width: 0, height: 0)
        label.sizeToFit()
        
        self.addSubview(label)
        
    }
    
    func createInput (text: String) {
        input = CustomTextField(text: text)
        input.frame = CGRect(x: 0, y: 0, width: Globals.getContainerWidth(), height: Globals.inputHeight)
        
        input.textColor = Globals.textColor
        input.backgroundColor = UIColor.clear
        input.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        
        input.textAlignment = .left
        input.keyboardAppearance = UIKeyboardAppearance.dark
        input.autocorrectionType = .no
        input.autocapitalizationType = .none
        
        addLine()
        addPadding()
        
        self.addSubview(input)
    }
    
    func addLine () {
        line = CALayer()
        line.backgroundColor = Globals.rLabelColor.cgColor
        line.frame = CGRect(x: 0, y: Globals.inputHeight - 1, width: Globals.getContainerWidth(), height: 1)
        
        input.layer.addSublayer(line)
    }
    
    func addPadding () {
        
        let paddingLeft = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 5))
        input.leftViewMode = .always
        input.leftView = paddingLeft
        
    }
    
    func getHeight () -> CGFloat {
        return self.label.frame.maxY
    }
    
    func getInputText () -> String? {
        return input.text
    }

}

class CustomTextField: UITextField {
    
    var id: String!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init (text: String) {
        super.init(frame: CGRect())
        self.id = text
    }
    
}
