//
//  BPCCard.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/11/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class BPCCard: LTCCard {
    
    var voteButtonContainer: UIView!
    var voteButton: BPCButton!
    var trackID: String!
    var numVotes: Int!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (name: String, artist: String, album: String, artURL:String, trackID: String, numVotes: Int) {
        super.init(frame: CGRect())
        
        updateInformation(name: name, artist: artist, album: album, artURL: artURL, trackID: trackID, numVotes: numVotes)
        
    }
    
    func updateInformation(name: String, artist: String, album: String, artURL: String, trackID: String, numVotes: Int) {
        super.updateInformation(name: name, artist: artist, album: album, artURL: artURL, text: String(numVotes) + " Votes")
        
        let offset:CGFloat = 10
        let width:CGFloat = info.width
        let height:CGFloat = Globals.getLTCImageDimensions() - info.getHeight() - offset
        let yCoord:CGFloat = info.getHeight() + offset
        
        voteButton = BPCButton(width: width, height: height, trackID: trackID)
        voteButton.frame = CGRect(x: 0, y: yCoord, width: width, height: height)
        rightContainer.frame = CGRect(x: Globals.getRightContainerXOffset(), y: 0, width: width, height: voteButton.frame.maxY)
        
        rightContainer.addSubview(voteButton)
        
    }

}
