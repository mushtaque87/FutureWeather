//
//  NetworkManager.swift
//  FlaskApp
//
//  Created by Mushtaque Ahmed on 09/06/2020.
//  Copyright © 2020 Mushtaque Ahmed. All rights reserved.
//

import Foundation

class NetworkManager {
    
    let httpClient: HttpClient
    
    required init(with httpClient:HttpClient) {
        self.httpClient = httpClient
    }
    
    func fetchCurrentCityWeatherForecast(url : URL ,
                          onSuccess  successCompletionHandler : @escaping (CityForecast) -> Void,
                          onFailure failedHandler: @escaping(Error) -> Void )
    {
        
        self.httpClient.get(url: url) { (data, respose, error) in
            if error != nil  {
                failedHandler(error!)
            } else {
                print(String(data: data!, encoding: .utf8)!)
                do {
                    let cityforecast : CityForecast = try JSONDecoder().decode(CityForecast.self, from: data!)
                    successCompletionHandler(cityforecast)
                } catch {
                    print("Throwable Error \(error)")
                }
            }
        }
    }
    
    func fetchCityWeather(url : URL ,
                          onSuccess  successCompletionHandler : @escaping (CityWeather) -> Void,
                          onFailure failedHandler: @escaping(Error) -> Void )
    {
        
        self.httpClient.get(url: url) { (data, respose, error) in
            if error != nil  {
                failedHandler(error!)
            } else {
               print(String(data: data!, encoding: .utf8)!)
                do {
                    let cityWeather : CityWeather = try JSONDecoder().decode(CityWeather.self, from: data!)
                    successCompletionHandler(cityWeather)
                } catch {
                    print("Throwable Error \(error)")
                }
            }
        }
    }
    
}

