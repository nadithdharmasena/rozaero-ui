//
//  RLogo.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/8/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class RLogo: UIView {
    
    var image: CustomImage!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let width = Globals.getLogoWidth()
        let height = Globals.getLogoHeight()
        
        image = CustomImage(image_name: "RLogo", width: width, height: height)
        image.frame = CGRect(x:0,y:0, width: width, height: height)
        image.backgroundColor = UIColor.clear
        
        self.addSubview(image)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
