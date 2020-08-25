//
//  LTCLabel.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/10/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class LTCLabel: UIView {

    var label: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (text: String) {
        super.init(frame: CGRect())
        
        label = createLabel(text: text)
        self.addSubview(label)
        
    }
    
    func createLabel (text: String) -> UILabel {
        let tempLabel = UILabel()
        tempLabel.textColor = Globals.yellowColor
        tempLabel.text = text
        tempLabel.font = UIFont.systemFont(ofSize: Globals.rLabelFontSize, weight: UIFont.Weight.bold)
        tempLabel.sizeToFit()
        
        return tempLabel
    }
    
    func getHeight () -> CGFloat {
        return label.frame.maxY
    }

}
