//
//  IButton.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/11/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class IButton: UIButton {
    
    var info:String!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init (info: String) {
        super.init(frame: CGRect())
        self.info = info
    }
    
}
