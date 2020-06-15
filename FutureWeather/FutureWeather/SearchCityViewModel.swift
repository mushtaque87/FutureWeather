//
//  SearchCityViewModel.swift
//  FutureWeather
//
//  Created by Mushtaque Ahmed on 15/06/2020.
//  Copyright © 2020 Mushtaque Ahmed. All rights reserved.
//

import UIKit

class SearchCityViewModel: NSObject {
    // let locationManager  = LocationManager()
    var networkManager : NetworkManager?
    weak var delegate: WeatherForecastVCDelegate?
    lazy var cityWeathertList = [CityWeather]()

    init(networkManager : NetworkManager) {
        super.init()
        self.networkManager = networkManager
    }
    
    func searchedCities(with cities:[String]){
        self.cityWeathertList.removeAll()
        cities.forEach { (city) in
            DispatchQueue.global().async {
                self.fetchSearchedCityWeather(with: String(city).trimmingCharacters(in: .whitespaces))
            }
        }
    }
    

    
    func fetchSearchedCityWeather(with cityName:String) {
        let url = URL(string:String(format: Constants.ServerApi.getCurrentCityWeather, cityName))!
        print(url)
        self.networkManager?.fetchCityWeather(url:url , onSuccess: { (weather) in
            self.cityWeathertList.append(weather)
            DispatchQueue.main.async {
                self.delegate?.reloadTableView()
            }
        }, onFailure: { (error) in
            print(error)
        })
    }
    
}
