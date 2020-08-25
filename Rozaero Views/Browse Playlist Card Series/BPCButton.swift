//
//  BPCButton.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/11/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class BPCButton: UIView {
    
    var button: IButton!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (width: CGFloat, height: CGFloat, trackID: String) {
        super.init(frame: CGRect())
        
        button = IButton(info: trackID)
        button.frame = CGRect(x: 0, y: 0, width: width, height: height)
        button.backgroundColor = Globals.buttonColor
        button.setTitle("Vote", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.bold)
        button.titleLabel?.textColor = Globals.textColor
        button.titleLabel?.sizeToFit()
        button.layer.cornerRadius = Globals.buttonCornerRadius
        
        button.addTarget(self, action: #selector(BPCButton.handlePress), for: .touchUpInside)
        self.addSubview(button)
    }
    
    @objc
    func handlePress (sender: IButton) {
        print(sender.info as String)
    }
    
}
