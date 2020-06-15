//
//  FirstViewController.swift
//  FutureWeather
//
//  Created by Mushtaque Ahmed on 15/06/2020.
//  Copyright © 2020 Mushtaque Ahmed. All rights reserved.
//

import UIKit


class CurrentCityViewController: UIViewController {
   
    private var viewModel = CurrentCityViewModel(networkManager:NetworkManager(with:HttpClient(session: URLSession(configuration: URLSessionConfiguration.default))))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.ss
    }


}

