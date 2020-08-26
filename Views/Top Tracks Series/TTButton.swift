//
//  TTButton.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/9/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class TTButton: UIView {
    
    var button: IButton!
    var partyVC: PartyViewController!
    var voteDisplay: TTVote!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (trackID: String, partyVC: PartyViewController, voteDisplay: TTVote) {
        super.init(frame: CGRect())
        
        self.partyVC = partyVC
        self.voteDisplay = voteDisplay
        
        let buttonWidth = Globals.getContainerWidth() * Globals.ttVoteButtonWidthMultiplier
        
        button = IButton(info: trackID)
        button.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: Globals.ttVoteButtonHeight)
        button.backgroundColor = UIColor.clear
        button.layer.borderColor = Globals.rLabelColor.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Vote", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Globals.rLabelFontSize, weight: UIFont.Weight.bold)
        button.titleLabel?.textColor = Globals.textColor
        button.titleLabel?.sizeToFit()
        button.layer.cornerRadius = 14
        
        button.addTarget(self, action: #selector(TTButton.handlePress), for: .touchUpInside)
        self.addSubview(button)
        
    }
    
    @objc
    func handlePress (sender: IButton) {
        // Handle button press
        
        self.voteDisplay.incrementVotes()
        
        let trackID = sender.info as! String
        self.partyVC.handleVote(trackID: trackID)
        
    }
    
    func getWidth () -> CGFloat {
        return button.frame.width
    }
    
    func getHeight () -> CGFloat {
        return button.frame.height
    }

}
