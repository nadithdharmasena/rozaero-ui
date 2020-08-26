//
//  TTCard.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/9/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class TTCard: UIView {
    
    var voteDisplayContainer:UIView!
    var voteDisplay:TTVote!
    var lowerContainer:UIView!
    var trackNameAndArtist:TTNameWithLabel!
    var voteButton:TTButton!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (name:String, artist:String, trackID: String, numVotes:Int, partyVC: PartyViewController) {
        super.init(frame: CGRect())
        
        updateInformation(name: name, artist: artist, trackID: trackID, numVotes: numVotes, partyVC: partyVC)
        
    }
    
    func updateInformation (name: String, artist: String, trackID: String, numVotes: Int, partyVC: PartyViewController) {
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        voteDisplayContainer = UIView()
        updateVotes(numVotes: numVotes)
        
        lowerContainer = UIView()
        
        trackNameAndArtist = TTNameWithLabel(name: name, artist: artist)
        trackNameAndArtist.frame = CGRect(x: 0, y: 0, width: trackNameAndArtist.getWidth(), height: trackNameAndArtist.getHeight())
        
        voteButton = TTButton(trackID: trackID, partyVC: partyVC, voteDisplay: voteDisplay)
        voteButton.frame = CGRect(x: Globals.getContainerWidth() - voteButton.getWidth(), y: 0, width: voteButton.getWidth(), height: voteButton.getHeight())
        
        let lowerContainerHeight = max(trackNameAndArtist.frame.maxY, voteButton.frame.maxY)
        
        lowerContainer.frame = CGRect(x: 0, y: voteDisplay.getHeight() + 6, width: Globals.getContainerWidth(), height: lowerContainerHeight)
        
        lowerContainer.addSubview(trackNameAndArtist)
        lowerContainer.addSubview(voteButton)
        
        self.addSubview(voteDisplayContainer)
        self.addSubview(lowerContainer)
        
    }
    
    func updateVotes (numVotes: Int) {
        
        for view in voteDisplayContainer.subviews {
            view.removeFromSuperview()
        }
        
        voteDisplay = TTVote(numVotes: numVotes)
        voteDisplayContainer.frame = CGRect(x: 0, y: 0, width: Globals.getContainerWidth(), height: voteDisplay.getHeight())
        voteDisplayContainer.addSubview(voteDisplay)
        
    }
    
    func getHeight () -> CGFloat {
        return lowerContainer.frame.maxY
    }

}
