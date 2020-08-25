//
//  LTCInfo.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/10/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class LTCInfo: UIView {
    
    var currentlyPlayingLabel: LTCLabel!
    var nameLabel: MarqueeLabel!
    var artistLabel: TapReverseMarquee!
    var albumLabel: TapReverseMarquee!
    
    var width:CGFloat!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init (name: String, artist: String, album: String, text: String) {
        super.init(frame: CGRect())
        
        width = Globals.getRightContainerWidth()
        self.clipsToBounds = true
        
        updateInformation(name: name, artist: artist, album: album, text: text)
        
    }
    
    func getHeight () -> CGFloat {
        return albumLabel.frame.maxY
    }
    
    func updateInformation (name: String, artist: String, album: String, text: String) {
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        currentlyPlayingLabel = LTCLabel(text: text)
        currentlyPlayingLabel.frame = CGRect(x: 0, y: 0, width: width, height: currentlyPlayingLabel.getHeight())
        
        nameLabel = MarqueeLabel(text: name, maxWidth: width, fontSize: 28, fontWeight: UIFont.Weight.bold, textColor: Globals.textColor)
        artistLabel = TapReverseMarquee(text: artist, maxWidth: width, fontSize: Globals.rLabelFontSize, fontWeight: UIFont.Weight.bold, textColor: Globals.textColor)
        albumLabel = TapReverseMarquee(text: album, maxWidth: width, fontSize: 13, fontWeight: UIFont.Weight.bold, textColor: Globals.textColor)
        
        nameLabel.frame = CGRect(x: 0, y: currentlyPlayingLabel.frame.maxY + 10, width: width, height: nameLabel.height)
        artistLabel.frame = CGRect(x: 0, y: nameLabel.frame.maxY + 8, width: width, height: artistLabel.height)
        albumLabel.frame = CGRect(x: 0, y: artistLabel.frame.maxY + 8, width: width, height: albumLabel.height)
        
        
        self.addSubview(currentlyPlayingLabel)
        self.addSubview(nameLabel)
        self.addSubview(artistLabel)
        self.addSubview(albumLabel)
        
    }
    
}
