//
//  Constants.swift
//  Contacts
//
//  Created by Mushtaque Ahmed on 12/21/19.
//  Copyright © 2019 Mushtaque Ahmed. All rights reserved.
//

import Foundation

import Foundation

struct Constants {
    
     static let APIKey = "c863d199a29adcc41dc9efe9ed3ed348"
    
    struct ServerApi {
        //All the micro service APIs can be kept at one place.
        static let baseUrl = "https://api.openweathermap.org/data/2.5/weather?"
        static let getCurrentCity = baseUrl + "q=%@&appid=\(Constants.APIKey)"
    }
}
