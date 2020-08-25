//
//  LPCard.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/13/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class LPCard: UIView {
    
    var parentVC: HomeController!
    var innerContainer: UIView!
    
    var name: MarqueeLabel!
    var host: TapReverseMarquee!
    var button: LPButton!
    
    static let offset: CGFloat = 24
    static let cardWidth: CGFloat = LPCard.offset + Globals.getContainerWidth()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (name: String, host: String, id: String, parent_vc: HomeController) {
        super.init(frame: CGRect())
        
        innerContainer = UIView()
        parentVC = parent_vc
        
        self.name = MarqueeLabel(text: name, maxWidth: Globals.getContainerWidth(), fontSize: Globals.largeTextSize, fontWeight: UIFont.Weight.regular
            , textColor: Globals.textColor)
        self.name.frame = CGRect(x: 0, y: 0, width: self.name.width, height: self.name.height)
        
        self.host = TapReverseMarquee(text: host, maxWidth: Globals.getContainerWidth(), fontSize: 16, fontWeight: UIFont.Weight.regular, textColor: Globals.textColor)
        self.host.frame = CGRect(x: 0, y: self.name.frame.maxY + 10, width: self.host.width, height: self.host.height)
        
        button = LPButton(info: id, parent_vc: parentVC)
        button.frame = CGRect(x: 0, y: self.host.frame.maxY + 16, width: button.getWidth(), height: button.getHeight())
        
        self.backgroundColor = Globals.backgroundColor
        
        innerContainer.addSubview(self.name)
        innerContainer.addSubview(self.host)
        innerContainer.addSubview(button)
        
        innerContainer.frame = CGRect(x: LPCard.offset, y: 0, width: Globals.getContainerWidth(), height: button.frame.maxY)
        
        self.addSubview(innerContainer)
        
    }
    
    func getHeight () -> CGFloat {
        return button.frame.maxY
    }
    

}
