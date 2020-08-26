//
//  HomeVC_Requests.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/23/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit
import Alamofire

extension HomeController {
    
    func requestLocalParties () {
        
        let latitude = currentLocation.coordinate.latitude
        let longitude = currentLocation.coordinate.longitude
        let closeURL = Globals.baseURL + "close"
        
        let myParams: [String: Any] = [
            "token": authToken!,
            "latitude": latitude,
            "longitude": longitude
        ]
        
        Alamofire.request(closeURL, method: .post, parameters: myParams, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            if let responseJSON = response.result.value {
                
                let responseObject:Dictionary<String, Any> = responseJSON as! Dictionary<String, Any>
                let statusCode = responseObject["status"] as! Int
                
                switch (statusCode) {
                case Globals.databaseError:
                    print("Database error")
                case Globals.successResponse:
                    
                    let data = responseObject["data"] as! Array<Dictionary<String, Any>>
                    self.processLocalPartyData(data: data)
                    
                default:
                    Globals.displayAlert(header: "Something went wrong", message: "We really do not know what this error is. Hopefully, we fix it in the future.", whichVC: self)
                }
            }
        }
        
    }
    
    func requestAccountInfo () {
        
        let userInfoURL = Globals.baseURL + "user_info"
        
        let myParams: [String: Any] = [
            "token": authToken!
        ]
        
        Alamofire.request(userInfoURL, method: .post, parameters: myParams, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            if let responseJSON = response.result.value {
                
                let responseObject:Dictionary<String, Any> = responseJSON as! Dictionary<String, Any>
                let statusCode = responseObject["status"] as! Int
                
                switch (statusCode) {
                case Globals.databaseError:
                    print("Database error")
                case Globals.noUserResponse:
                    print("No user associated")
                case Globals.successResponse:
                    
                    let data = responseObject["data"] as! Dictionary<String, String>
                    self.username = data["username"]
                    
                default:
                    Globals.displayAlert(header: "Something went wrong", message: "We really do not know what this error is. Hopefully, we fix it in the future.", whichVC: self)
                }
            }
        }
        
    }
    
    func requestMyParties () {
        
        let userInfoURL = Globals.baseURL + "my_parties"
        
        let myParams: [String: Any] = [
            "token": authToken!
        ]
        
        Alamofire.request(userInfoURL, method: .post, parameters: myParams, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            if let responseJSON = response.result.value {
                
                let responseObject:Dictionary<String, Any> = responseJSON as! Dictionary<String, Any>
                let statusCode = responseObject["status"] as! Int
                
                switch (statusCode) {
                case Globals.databaseError:
                    print("Database error")
                case Globals.noUserResponse:
                    print("No user associated")
                case Globals.successResponse:
                    
                    let data = responseObject["data"] as! Array<Dictionary<String, Any>>
                    self.processMyParties(data: data)
                    
                default:
                    Globals.displayAlert(header: "Something went wrong", message: "We really do not know what this error is. Hopefully, we fix it in the future.", whichVC: self)
                }
            }
        }
        
    }
    
}
