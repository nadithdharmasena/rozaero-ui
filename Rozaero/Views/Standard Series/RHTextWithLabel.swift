//
//  RHTextWithLabel.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/8/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class RHTextWithLabel: RHText {
    
    var label:RLabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (text: String, label: String) {
        super.init(text: text)
        
        createLabel(text: label)
        
    }
    
    func createLabel (text: String) {
        
        label = RLabel(text: text)
        label.font = UIFont.systemFont(ofSize: Globals.rLabelFontSize - 1, weight: UIFont.Weight.bold)
        label.frame = CGRect(x: 0, y: super.header.frame.maxY + 4, width: 0, height: 0)
        label.sizeToFit()
        
        self.addSubview(label)
        
    }
    
    override func getHeight () -> CGFloat {
        return label.frame.maxY
    }

}
