//
//  RLabel.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/8/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class RLabel: UILabel {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (text: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        
        self.textColor = Globals.rLabelColor
        self.text = text
        self.font = UIFont.systemFont(ofSize: Globals.rLabelFontSize, weight: UIFont.Weight.bold)
        self.sizeToFit()
        
    }

}
