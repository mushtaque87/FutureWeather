//
//  FirstViewController.swift
//  FutureWeather
//
//  Created by Mushtaque Ahmed on 15/06/2020.
//  Copyright © 2020 Mushtaque Ahmed. All rights reserved.
//

import UIKit

protocol WeatherForecastVCDelegate : class {
    func reloadTableView()
}


class CurrentCityViewController: UIViewController , WeatherForecastVCDelegate {
    @IBOutlet weak var weatherForecastTableView: UITableView!

     var viewModel = CurrentCityViewModel(networkManager:NetworkManager(with:HttpClient(session: URLSession(configuration: URLSessionConfiguration.default))))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weatherForecastTableView?.register(UINib(nibName: "WeatherForecastTableViewCell", bundle: nil), forCellReuseIdentifier: "weatherCell")
        self.weatherForecastTableView.delegate = self
        self.weatherForecastTableView.dataSource = self
        viewModel.delegate = self
        // Do any additional setup after loading the view.ss
    }

    func reloadTableView() {
        self.weatherForecastTableView.reloadData()
      }
}

extension CurrentCityViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.forecastList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherForecastTableViewCell
        let weather = self.viewModel.forecastList[indexPath.row]
        cell.main.text = weather.weather?[0].main
        cell.desc.text =  weather.weather?[0].description
        cell.temp.text = String(format:"%.1f",weather.main?.temp as! CVarArg)
        cell.icon.image = cell.setImage(for: (weather.weather?[0].main)!)
        cell.dt_txt.text = Helper.covertDateToString(date: weather.dt!)
        cell.name.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
    
