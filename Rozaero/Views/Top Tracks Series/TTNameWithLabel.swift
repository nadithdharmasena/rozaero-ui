//
//  TTNameWithLabel.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/9/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class TTNameWithLabel: UIView {
    
    var nameLabel:MarqueeLabel!
    var artistLabel:TapReverseMarquee!
    var containerWidth:CGFloat!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (name: String, artist: String) {
        super.init(frame: CGRect())
        
        let containerWidthMultiplier:CGFloat = 1 - (Globals.ttVoteButtonWidthMultiplier + Globals.ttDistanceBetweenTextAndVoteButton)
        containerWidth = Globals.getContainerWidth() * containerWidthMultiplier
        
        nameLabel = MarqueeLabel(text: name, maxWidth: containerWidth, fontSize: 16, fontWeight: UIFont.Weight.bold, textColor: Globals.textColor)
        nameLabel.frame = CGRect(x: 0, y: 0, width: containerWidth, height: nameLabel.height)
        
        artistLabel = TapReverseMarquee(text: artist, maxWidth: containerWidth, fontSize: Globals.rLabelFontSize, fontWeight: UIFont.Weight.bold, textColor: Globals.rLabelColor)
        artistLabel.frame = CGRect(x: 0, y: nameLabel.frame.maxY + 4, width: containerWidth, height: artistLabel.height)
        
        self.addSubview(nameLabel)
        self.addSubview(artistLabel)
        
        
    }
    
    func getWidth () -> CGFloat {
        return containerWidth
    }
    
    func getHeight () -> CGFloat {
        return artistLabel.frame.maxY
    }
    
}
