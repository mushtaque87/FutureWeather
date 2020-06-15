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
    
    func fetchCurrentCityWeather(url : URL ,
                          onSuccess  successCompletionHandler : @escaping (CurrentCity) -> Void,
                          onFailure failedHandler: @escaping(Error) -> Void )
    {
        
        self.httpClient.get(url: url) { (data, respose, error) in
            if error != nil  {
                failedHandler(error!)
            } else {
                print(String(data: data!, encoding: .utf8)!)
                do {
                    let currentCity : CurrentCity = try JSONDecoder().decode(CurrentCity.self, from: data!)
                    successCompletionHandler(currentCity)
                } catch {
                    print("Throwable Error \(error)")
                }
            }
        }
    }
    
    func fetchSearchedCitiesWeather(url : URL ,
                          onSuccess  successCompletionHandler : @escaping (SearchedCity) -> Void,
                          onFailure failedHandler: @escaping(Error) -> Void )
    {
        
        self.httpClient.get(url: url) { (data, respose, error) in
            if error != nil  {
                failedHandler(error!)
            } else {
                print(String(data: data!, encoding: .utf8)!)
                do {
                    let contacts : SearchedCity = try JSONDecoder().decode(SearchedCity.self, from: data!)
                    successCompletionHandler(contacts)
                } catch {
                    print("Throwable Error \(error)")
                }
            }
        }
    }
    
}

