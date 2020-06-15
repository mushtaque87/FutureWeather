//
//  CurrentCityViewModel.swift
//  FutureWeather
//
//  Created by Mushtaque Ahmed on 15/06/2020.
//  Copyright © 2020 Mushtaque Ahmed. All rights reserved.
//

import Foundation
import CoreLocation
class CurrentCityViewModel: NSObject , LocationDelegate {
   
    
    var currentLocation : CLLocation?
    var networkManager : NetworkManager?
    let locationManager  = LocationManager()
    lazy var forecastList = [List]()
    weak var delegate: WeatherForecastVCDelegate?

    
    init(networkManager : NetworkManager) {
        super.init()
        self.networkManager = networkManager
        self.locationManager.delegate = self
    }
    
    func sendLocation(with location: CLLocation?) {
        if let loc = location {
            print(loc)
            fetchCurrentCityWeatherForecast(with: loc)
        }
           
    }
    
    func fetchCurrentCityWeatherForecast(with location:CLLocation) {
        let url = URL(string:String(format: Constants.ServerApi.getCityWeatherForecast, location.coordinate.latitude,location.coordinate.longitude))!
        self.networkManager?.fetchCurrentCityWeatherForecast(url:url , onSuccess: { (forecast) in
            //print(forecast)
            if let list =  forecast.list {
                self.forecastList = list
                DispatchQueue.main.async {
                    self.delegate?.reloadTableView()
                }
            }
        }, onFailure: { (error) in
            print(error)
        })
    }
    
}


