//
//  CurrentCityViewModel.swift
//  FutureWeather
//
//  Created by Mushtaque Ahmed on 15/06/2020.
//  Copyright © 2020 Mushtaque Ahmed. All rights reserved.
//

import UIKit

class CurrentCityViewModel: NSObject {
    
    let network = NetworkManager(with: HttpClient(session: URLSession(configuration: URLSessionConfiguration.default)))
    
    let networkManager : NetworkManager
//    let dataManager : Datamanager

    
    init(networkManager : NetworkManager) {
           self.networkManager = networkManager
//           self.dataManager = dataManager
       }
}
