//
//  TapReverseMarquee.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/9/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class TapReverseMarquee: MarqueeLabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    override init (text: String, maxWidth: CGFloat, fontSize: CGFloat, fontWeight: UIFont.Weight, textColor: UIColor) {
        super.init(frame: CGRect())
        
        label = createLabel(text: text, pos: 0, fontSize: fontSize, fontWeight: fontWeight, textColor: textColor)
        
        setDefaults(maxWidth:maxWidth)
        
        if width > containerWidth {
            addTapGesture()
        }
        
        self.clipsToBounds = true
        self.addSubview(label)
        
    }
    
    func addTapGesture () {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(TapReverseMarquee.handleTap))
        self.addGestureRecognizer(tap)
        
    }
    
    @objc
    func handleTap(sender:UITapGestureRecognizer) {
        
        let necessaryTranslation = self.label.frame.maxX - self.containerWidth
        
        UIView.animate(withDuration: 3.5, delay: 0, options: [.curveEaseInOut], animations: {
            
            self.label.center.x -= necessaryTranslation
            
        }) {result in
            
            UIView.animate(withDuration: 3.5, delay: 1, options: [.curveEaseInOut], animations: {
                
                self.label.center.x += necessaryTranslation
                
            })
            
        }
        
        
        
    }
    
}
