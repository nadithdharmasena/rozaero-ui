//
//  PartyViewController.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/23/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit
import Alamofire

class PartyViewController: UIViewController {
    
    var rBase: RBase!
    
    var id: String!
    var authToken: String!
    
    var tracks_data: Array<Dictionary<String, Any>>!
    var party_info: Dictionary<String, Any>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        requestPartyInfo()
        reloadView()
        
    }
    
    
    func reloadView () {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.requestPartyInfo()
            self.reloadView()
        }
        
    }
    
    init(authToken: String, id: String) {
        self.authToken = authToken
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout () {
        
        rBase = RBase(frame: CGRect())
        
        displayCurrentTrack()
        
        let main_divider: RLine = RLine()
        main_divider.line.backgroundColor = Globals.yellowColor
        rBase.addView(view: main_divider, width: rBase.containerWidth, height: 1, marginTop: Globals.getBelowParagraphMargin())
        
        displayTracks()
        
        let secondary_divider: RLine = RLine()
        rBase.addView(view: secondary_divider, width: rBase.containerWidth, height: 1, marginTop: Globals.getBelowParagraphMargin())
        
        let info_header: RHText = RHText(text: "Information")
        rBase.addView(view: info_header, width: info_header.frame.width, height: info_header.getHeight(), marginTop: Globals.getBelowParagraphMargin())
        
        displayPartyInfo()
            
        rBase.resizeScreen()
        self.view.addSubview(rBase)
        
        if #available(iOS 11.0, *) {
            rBase.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
    }

}

// Gesture Handling activities
extension PartyViewController {
    
    func handleVote (trackID: String) {
        incrementTrackVote(trackID: trackID)
    }
    
    
}
