//
//  HomeViewController.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/17/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class HomeController: UIViewController {
    
    var authToken: String?
    var username: String?
    
    var rHome: RHome!
    var partiesAroundHere: RHText!
    var nothingHere: RLabel!
    var localPartyContainer: LPContainer!
    var line: RLine!
    var yourParties: RHTextWithLabel!
    var partyGrid: YPGrid!
    
    var currentLocation: CLLocation!
    var locationUpdateTimeStamp: Double = 0
    
    var localParties = [LParty]()
    var myPartiesList = [YParty]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        authToken = UserDefaults.standard.object(forKey: "authToken") as? String
        
        requestAccountInfo()
        requestMyParties()
        checkSystemLocationAuthorization()
        
        rHome = RHome(frame: CGRect())
        rHome.resizeScreen()
        self.view.addSubview(rHome)
        
        if #available(iOS 11.0, *) {
            rHome.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
    }
    
    func empty () {
        
        for view in rHome.innerContainer.subviews {
            view.removeFromSuperview()
        }
        
    }
    
    func setupFixedBeginLayout () {
        
        partiesAroundHere = RHText(text: "Parties Around Here")
        rHome.addInnerView(view: partiesAroundHere, width: Globals.getContainerWidth(), height: partiesAroundHere.getHeight(), marginTop: 0)
        
        localPartyContainer = LPContainer(parent_vc: self)
        
    }
    
    func setupFullLayout () {
        
        empty()
        setupFixedBeginLayout()
        
        rHome.addInnerView(view: localPartyContainer, width: Globals.getContainerWidth(), height: 0, marginTop: 20)
        localPartyContainer.setYOffset(yOffset: localPartyContainer.frame.minY)
        
        localPartyContainer.addParties(parties: self.localParties)
        
        line = RLine()
        rHome.addInnerView(view: line, width: Globals.getContainerWidth(), height: 1, marginTop: 35)
        
        setupFixedEndLayout()
        
    }
    
    func setupEmptyLayout () {
        
        empty()
        setupFixedBeginLayout()
        
        rHome.addInnerView(view: localPartyContainer, width: Globals.getContainerWidth(), height: 0, marginTop: 25)
        localPartyContainer.setYOffset(yOffset: localPartyContainer.frame.minY)
        
        localPartyContainer.addMessage()
        
        line = RLine()
        rHome.addInnerView(view: line, width: Globals.getContainerWidth(), height: 1, marginTop: 35)
        
        setupFixedEndLayout()
        
    }
    
    func setupFixedEndLayout () {
        
        yourParties = RHTextWithLabel(text: "Your Parties", label: "Approved to host.")
        rHome.addInnerView(view: yourParties, width: Globals.getContainerWidth(), height: yourParties.getHeight(), marginTop: 25)
        
        partyGrid = YPGrid(home_vc: self)
        rHome.addInnerView(view: partyGrid, width: Globals.getContainerWidth(), height: 0, marginTop: 25)
        
        partyGrid.setYOffset(yOffset: partyGrid.frame.minY)
        
        for party in self.myPartiesList {
            partyGrid.addBox(party: party)
        }
        
        partyGrid.generateGrid(username: self.username!)
        
        let addTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeController.handleAdd))
        partyGrid.add.addGestureRecognizer(addTapGesture)
        
        rHome.resizeScreen()
        
    }
    
}


// Misc. related activities
extension HomeController {
    
    @objc
    func handleAdd (sender: UITapGestureRecognizer) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let hostViewController = storyboard.instantiateViewController(withIdentifier: "HostController")
        
        show(hostViewController, sender: self)
        
        
    }
    
    func handleLogout () {
        
        UserDefaults.standard.removeObject(forKey: "authToken")
        
        self.dismiss(animated: false)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginController")
        
        self.view.window!.rootViewController = loginViewController

    }
    
}

// Party View Controller activities
extension HomeController {
    
    func handleInitPvc (id: String) {
        
        let registerController = PartyViewController(authToken: self.authToken!, id: id)
        registerController.modalTransitionStyle = .coverVertical
        
        self.present(registerController, animated: true)
        
        
    }
    
}
