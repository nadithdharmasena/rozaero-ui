//
//  HomeVC_Location.swift
//  Rozaero
//
//  Created by Nadith Dharmasena on 8/23/19.
//  Copyright © 2019 Nadith Dharmasena. All rights reserved.
//

import UIKit
import CoreLocation

// Location related activities
extension HomeController {
    
    func checkSystemLocationAuthorization () {
        if CLLocationManager.locationServicesEnabled() {
            // System-wide location services are enabled
            setupLocationManager()
            checkAppLocationAuthorization()
        } else {
            // System-wide location services are disabled
            notifyAuthorizationStatus()
        }
    }
    
    func checkAppLocationAuthorization () {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            // Add whatever functionality necessary
            Globals.locationManager.startUpdatingLocation()
            
        case .denied, .restricted:
            // Show alert telling user how to change permissions
            notifyAuthorizationStatus()
            
        case .notDetermined:
            Globals.locationManager.requestWhenInUseAuthorization()
            
        case .authorizedAlways:
            break
        @unknown default:
            Globals.displayAlert(header: "Unknown Error", message: "We really do not know what went wrong here. We are working hard to fix this bug.", whichVC: self)
            fatalError()
        }
    }
    
    func setupLocationManager () {
        Globals.locationManager.delegate = self
        Globals.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        Globals.locationManager.distanceFilter = 10
    }
    
    func notifyAuthorizationStatus () {
        
        let locationAlert = UIAlertController(title: "Rozaero wants to use your location", message: "Rozaero uses your location to find parties near you. Please modify your settings to allow Rozaero to access your device's location. Restart the app once you have made the necessary changes.", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Allow", style: .default) { Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        locationAlert.addAction(settingsAction)
        locationAlert.addAction(cancelAction)
        
        self.present(locationAlert, animated: true, completion: nil)
        
    }
    
    
}

// CLLocationManagerDelegate related activities
extension HomeController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        let timestamp = NSDate().timeIntervalSince1970
        
        if timestamp - locationUpdateTimeStamp > 1 {
            locationUpdateTimeStamp = timestamp
            currentLocation = location
            
            requestLocalParties()
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAppLocationAuthorization()
    }
    
}
