//
//  LPButton.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/13/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class LPButton: UIView {

    var parentVC: HomeController!
    var button: IButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (info: String, parent_vc: HomeController) {
        super.init(frame: CGRect())
        
        parentVC = parent_vc
        
        button = IButton(info: info)
        button.frame = CGRect(x: 0, y: 0, width: Globals.getContainerWidth(), height: Globals.buttonHeight - 5)
        button.backgroundColor = Globals.buttonColor
        button.setTitle("Join", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.regular)
        button.titleLabel?.textColor = Globals.textColor
        button.titleLabel?.sizeToFit()
        button.layer.cornerRadius = Globals.buttonCornerRadius
        
        button.addTarget(self, action: #selector(LPButton.handlePress), for: .touchUpInside)
        self.addSubview(button)
    }
    
    func getWidth () -> CGFloat {
        return button.frame.width
    }
    
    func getHeight () -> CGFloat {
        return button.frame.height
    }
    
    @objc
    func handlePress (sender: IButton) {
        self.parentVC.handleInitPvc(id: sender.info!)
    }

}
