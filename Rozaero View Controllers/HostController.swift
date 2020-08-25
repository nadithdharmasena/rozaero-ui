//
//  HostController.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/22/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

class HostController: UIViewController {
    
    var rBase: RBase!
    var hostParty: RHText!
    var initialExplanation: RParagraph!
    var selectLocation: RHMiniText!
    var selectLocationExplanation: RParagraph!
    var choosePlaylist: RHMiniText!
    var choosePlaylistExplanation: RParagraph!
    var activateParty: RHMiniText!
    var activatePartyExplanation: RParagraph!
    var understoodButton: RGButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupLayout()
        
    }
    
    func setupLayout () {
        
        rBase = RBase(frame: CGRect())
        
        hostParty = RHText(text: "Hosting Events")
        rBase.addView(view: hostParty, width: Globals.getContainerWidth(), height: hostParty.getHeight(), marginTop: Globals.getBelowLogoMargin())
        
        initialExplanation = RParagraph(text: Globals.hostInitialExplanation)
        initialExplanation.textView.frame = CGRect(x: 0, y: 0, width: Globals.getContainerWidth(), height: initialExplanation.getHeight())
        rBase.addView(view: initialExplanation, width: Globals.getContainerWidth(), height: initialExplanation.getHeight(), marginTop: Globals.paragraphBelowHeaderMargin)
        
        selectLocation = RHMiniText(text: "Select Location")
        rBase.addView(view: selectLocation, width: Globals.getContainerWidth(), height: selectLocation.getHeight(), marginTop: Globals.getBelowLogoMargin())
        
        selectLocationExplanation = RParagraph(text: Globals.selectLocationExplanation)
        selectLocationExplanation.textView.frame = CGRect(x: 0, y: 0, width: Globals.getContainerWidth(), height: selectLocationExplanation.getHeight())
        rBase.addView(view: selectLocationExplanation, width: Globals.getContainerWidth(), height: selectLocationExplanation.getHeight(), marginTop: Globals.paragraphBelowHeaderMargin)
        
        choosePlaylist = RHMiniText(text: "Choose Playlist")
        rBase.addView(view: choosePlaylist, width: Globals.getContainerWidth(), height: choosePlaylist.getHeight(), marginTop: Globals.getBelowParagraphMargin())
        
        choosePlaylistExplanation = RParagraph(text: Globals.choosePlaylistExplanation)
        choosePlaylistExplanation.textView.frame = CGRect(x: 0, y: 0, width: Globals.getContainerWidth(), height: choosePlaylistExplanation.getHeight())
        rBase.addView(view: choosePlaylistExplanation, width: Globals.getContainerWidth(), height: choosePlaylistExplanation.getHeight(), marginTop: Globals.paragraphBelowHeaderMargin)

        understoodButton = RGButton(text: "Understood")
        rBase.addView(view: understoodButton, width: Globals.getContainerWidth(), height: Globals.buttonHeight, marginTop: Globals.getBelowParagraphMargin())
        
        understoodButton.button.addTarget(self, action: #selector(HostController.handleUnderstood), for: .touchUpInside)
        
        rBase.resizeScreen()
        self.view.addSubview(rBase)
        
        if #available(iOS 11.0, *) {
            rBase.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
    }

}

// Gesture related activities
extension HostController {
    
    @objc
    func handleUnderstood (sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
