//
//  YPAdd.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/13/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class YPAdd: UIView {

    var box: UIView!
    var plusSign: CustomImage!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init () {
        super.init(frame: CGRect())
        
        box = UIView()
        box.frame = CGRect(x: 0, y: 0, width: YPBox.dimensions, height: YPBox.dimensions)
        box.layer.cornerRadius = 6
        box.layer.borderColor = Globals.rLabelColor.cgColor
        box.layer.borderWidth = 1
        
        plusSign = CustomImage(image_name: "Plus", width: 45, height: 45)
        plusSign.frame = CGRect(x: YPBox.textOffset + 2, y: YPBox.textOffset + 2, width: 45, height: 45)
        plusSign.backgroundColor = UIColor.clear
        box.addSubview(plusSign)
        
        addTapListener()
        
        self.addSubview(box)
        
    }
    
    func addTapListener () {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(YPAdd.handlePress))
        self.addGestureRecognizer(tapGesture)
    }
    
    func getDimensions () -> CGFloat {
        return YPBox.dimensions
    }
    
    @objc
    func handlePress (sender: UITapGestureRecognizer) {
        print(sender)
    }

}
