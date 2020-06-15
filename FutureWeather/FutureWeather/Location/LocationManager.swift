//
//  LocationManager.swift
//  FutureWeather
//
//  Created by Mushtaque Ahmed on 15/06/2020.
//  Copyright © 2020 Mushtaque Ahmed. All rights reserved.
//


import Foundation
import CoreLocation


protocol LocationDelegate : class {
    func sendLocation(with location:CLLocation?)
}


class LocationManager : NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var currentLoc: CLLocation?
    weak var  delegate : LocationDelegate?

    override init() {
        super.init()
//        self.locationManager.requestWhenInUseAuthorization()
       // self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
           // locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        currentLoc  = locations[0]
        delegate?.sendLocation(with: currentLoc)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }

    
    
}
