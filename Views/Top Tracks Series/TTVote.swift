//
//  TTVote.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/9/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class TTVote: UIView {
    
    var label: UILabel!
    var numVotes: Int!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init (numVotes: Int) {
        super.init(frame: CGRect())
        
        self.numVotes = numVotes
        
        label = UILabel()
        label.textColor = Globals.yellowColor
        label.text = String(numVotes) + " Votes"
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.bold)
        label.sizeToFit()
        
        self.addSubview(label)
        
    }
    
    func incrementVotes () {
        
        self.numVotes += 1
        label.text = String(self.numVotes) + " Votes"
        label.sizeToFit()
        
    }
    
    func getHeight () -> CGFloat {
        return label.frame.maxY
    }
    
}
