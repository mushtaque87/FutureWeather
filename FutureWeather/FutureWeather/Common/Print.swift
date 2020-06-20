//
//  Print.swift
//  FutureWeather
//
//  Created by Mushtaque Ahmed on 19/06/2020.
//  Copyright © 2020 Mushtaque Ahmed. All rights reserved.
//

import UIKit

class Print: NSObject {
    static func log(message:Any){
        #if DEBUG
            print(message)
        #endif
    }
}
