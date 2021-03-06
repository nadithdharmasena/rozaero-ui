//
//  RHMiniText.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/22/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class RHMiniText: UIView {
    
    var header: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (text: String) {
        
        super.init(frame: CGRect())
        
        header = UILabel()
        header.textColor = Globals.headerColor
        header.text = text
        header.font = UIFont.systemFont(ofSize: Globals.getMiniHeaderSize(), weight: UIFont.Weight.bold)
        header.sizeToFit()
        
        self.addSubview(header)
        
    }
    
    func getHeight () -> CGFloat {
        return header.frame.maxY
    }
    
}
