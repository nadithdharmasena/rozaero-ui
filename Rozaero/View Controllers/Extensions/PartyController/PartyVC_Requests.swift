//
//  PartyVC_Requests.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/27/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import Alamofire
import UIKit

// Internet activities
extension PartyViewController {
    
    func requestPartyInfo () {
        
        let getPartyURL = Globals.baseURL + "get_party"
        let id = self.id
        
        let myParams: [String: Any] = [
            "token": authToken!,
            "id": id as Any
        ]
        
        Alamofire.request(getPartyURL, method: .post, parameters: myParams, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            if let responseJSON = response.result.value {
                
                let responseObject:Dictionary<String, Any> = responseJSON as! Dictionary<String, Any>
                let statusCode = responseObject["status"] as! Int
                
                switch (statusCode) {
                case Globals.databaseError:
                    print("Database error")
                case Globals.successResponse:
                    
                    let data = responseObject["data"] as! Dictionary<String, Any>
                    
                    self.party_info = data
                    self.requestTracks()
                    
                default:
                    Globals.displayAlert(header: "Something went wrong", message: "We really do not know what this error is. Hopefully, we fix it in the future.", whichVC: self)
                }
            }
        }
        
    }

    func requestTracks () {
        
        let tracksURL = Globals.baseURL + "tracks"
        let id = self.id
        
        let myParams: [String: Any] = [
            "token": authToken!,
            "id": id as Any
        ]
        
        Alamofire.request(tracksURL, method: .post, parameters: myParams, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            if let responseJSON = response.result.value {
                
                let responseObject:Dictionary<String, Any> = responseJSON as! Dictionary<String, Any>
                let statusCode = responseObject["status"] as! Int
                
                switch (statusCode) {
                case Globals.databaseError:
                    print("Database error")
                case Globals.successResponse:
                    
                    let data = responseObject["data"] as! Array<Dictionary<String, Any>>
                    
                    self.tracks_data = data
                    self.setupLayout()
                    
                default:
                    Globals.displayAlert(header: "Something went wrong", message: "We really do not know what this error is. Hopefully, we fix it in the future.", whichVC: self)
                }
            }
        }
        
    }
    
    func incrementTrackVote (trackID: String) {
        
        let addVoteURL = Globals.baseURL + "add_vote"
        let id = self.id
        
        let myParams: [String: Any] = [
            "token": authToken!,
            "track_id": trackID as Any,
            "party_id": id as Any
        ]
        
        Alamofire.request(addVoteURL, method: .post, parameters: myParams, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            if let responseJSON = response.result.value {
                
                let responseObject:Dictionary<String, Any> = responseJSON as! Dictionary<String, Any>
                let statusCode = responseObject["status"] as! Int
                
                switch (statusCode) {
                case Globals.databaseError:
                    print("Database error")
                case Globals.successResponse:
                    break
                default:
                    Globals.displayAlert(header: "Something went wrong", message: "We really do not know what this error is. Hopefully, we fix it in the future.", whichVC: self)
                }
            }
        }
        
    }
    
}
