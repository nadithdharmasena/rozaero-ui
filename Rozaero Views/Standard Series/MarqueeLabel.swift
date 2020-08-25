//
//  MarqueeLabel.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/9/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class MarqueeLabel: UIView {

    var label:UILabel!
    var labelCopy:UILabel?
    
    var width:CGFloat!
    var height:CGFloat!
    var containerWidth:CGFloat!
    
    var startX:CGFloat?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (text: String, maxWidth: CGFloat, fontSize: CGFloat, fontWeight: UIFont.Weight, textColor: UIColor) {
        super.init(frame: CGRect())
        
        label = createLabel(text: text, pos: 0, fontSize: fontSize, fontWeight: fontWeight, textColor: textColor)
        
        setDefaults(maxWidth: maxWidth)
        
        if width > containerWidth {
            startX = width + (containerWidth / 2)
            labelCopy = createLabel(text: text, pos: startX!, fontSize: fontSize, fontWeight: fontWeight, textColor: textColor)
            
            marquee()
            
            self.addSubview(labelCopy!)
        }
        
        self.clipsToBounds = true
        self.addSubview(label)
        
    }
    
    func setDefaults (maxWidth:CGFloat) {
        width = label.frame.maxX
        height = label.frame.maxY
        containerWidth = maxWidth
    }
    
    func createLabel (text: String, pos: CGFloat, fontSize: CGFloat, fontWeight: UIFont.Weight, textColor:UIColor) -> UILabel {
        
        let label = UILabel()
        label.frame = CGRect(x: pos, y: 0, width: 0, height: 0)
        label.textColor = textColor
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        label.sizeToFit()
        
        return label
        
    }
    
    func marquee () {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear], animations: {
            
            self.label.center.x -= 10
            self.labelCopy!.center.x -= 10
            
        }) { result in
            
            if self.label.frame.maxX <= 0 {
                self.label.center.x = self.labelCopy!.frame.maxX + (self.width / 2) + (self.containerWidth / 2)
            }
            
            if self.labelCopy!.frame.maxX <= 0 {
                self.labelCopy!.center.x = self.label.frame.maxX + (self.width / 2) + (self.containerWidth / 2)
            }
            
            self.marquee()
        }
        
    }

}
