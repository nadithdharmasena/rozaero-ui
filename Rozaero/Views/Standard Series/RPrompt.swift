//
//  RPrompt.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/8/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class RPrompt: UIView {
    
    var prompt: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (text: String) {
        super.init(frame: CGRect())
        
        prompt = UILabel()
        prompt.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        prompt.textColor = Globals.textColor
        prompt.text = text
        prompt.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        prompt.isUserInteractionEnabled = true
        prompt.sizeToFit()
        
        self.addSubview(prompt)
        
    }
    
    func getHeight () -> CGFloat {
        return prompt.frame.maxY
    }

}
