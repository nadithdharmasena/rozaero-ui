//
//  RGButton.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/8/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class RGButton: UIView {
    
    var button: UIButton!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (text: String, width: CGFloat = Globals.getContainerWidth(), height: CGFloat = Globals.buttonHeight) {
        super.init(frame: CGRect())
        
        button = UIButton(frame: CGRect(x: 0, y: 0, width: width, height: height))
        button.backgroundColor = Globals.buttonColor
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        button.titleLabel?.textColor = Globals.textColor
        button.titleLabel?.sizeToFit()
        button.layer.cornerRadius = Globals.buttonCornerRadius
        
        self.addSubview(button)
        
    }

}
