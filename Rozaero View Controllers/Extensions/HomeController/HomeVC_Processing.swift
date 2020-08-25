//
//  HomeVC_Processing.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/23/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit

// API Data Processing activities
extension HomeController {
    
    func processLocalPartyData (data: Array<Dictionary<String, Any>>) {
         
        localParties = [LParty]()
        
        for party in data {
            let host = party["host"] as! String
            let name = party["name"] as! String
            let code = party["code"] as! String
            let id = party["id"] as! String
            
            let lParty: LParty = LParty(host: host, name: name, code: code, id: id)
            localParties.append(lParty)
        }
        
        decideLayout()
        
    }
    
    func decideLayout () {
        
        if localParties.count > 0 {
            setupFullLayout()
            return
        }
        
        setupEmptyLayout()
        
    }
    
    func processMyParties (data: Array<Dictionary<String, Any>>) {
        
        for element in data {
            
            let name: String = element["name"] as! String
            let id: String = element["id"] as! String
            let code: String = element["code"] as! String
            let active: Bool = element["active"] as! Bool

            let yParty: YParty = YParty(name: name, id: id, code: code, active: active)
            self.myPartiesList.append(yParty)
            
        }
        
    }
    
}
