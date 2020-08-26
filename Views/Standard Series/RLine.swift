//
//  RLine.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/8/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class RLine: UIView {
    
    var line:UIView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init () {
        super.init(frame: CGRect())
        
        line = UIView()
        line.frame = CGRect(x: 0, y: 0, width: Globals.getContainerWidth(), height: Globals.lineHeight)
        line.backgroundColor = Globals.rLabelColor
        
        self.addSubview(line)
        
    }

}
