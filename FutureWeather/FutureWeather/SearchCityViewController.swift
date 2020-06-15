//
//  SecondViewController.swift
//  FutureWeather
//
//  Created by Mushtaque Ahmed on 15/06/2020.
//  Copyright © 2020 Mushtaque Ahmed. All rights reserved.
//

import UIKit

class SearchCityViewController: UIViewController, WeatherForecastVCDelegate {
  
    

    var viewModel = SearchCityViewModel(networkManager:NetworkManager(with:HttpClient(session: URLSession(configuration: URLSessionConfiguration.default))))
    @IBOutlet weak var searchBar : UISearchBar!
    @IBOutlet weak var cityWeatherTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // viewModel.locationManager.locationManager.startUpdatingLocation()
        self.cityWeatherTableView?.register(UINib(nibName: "WeatherForecastTableViewCell", bundle: nil), forCellReuseIdentifier: "weatherCell")
        self.cityWeatherTableView.delegate = self
        self.cityWeatherTableView.dataSource = self
         viewModel.delegate = self
        searchBar.delegate = self
    }

    func reloadTableView() {
        self.cityWeatherTableView.reloadData()
    }

    func showAlert() {
        let alert = UIAlertController(title: "Alert", message: "Please enter minimum 3 Cities and maximum 7 cities", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension SearchCityViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.cityWeathertList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherForecastTableViewCell
        let weather = self.viewModel.cityWeathertList[indexPath.row]
        cell.main.text = weather.weather?[0].main
        cell.desc.text =  weather.weather?[0].description
        cell.temp.text = String(format:"%.1f",weather.main?.temp as! CVarArg)
       // cell.humidity.isHidden = true
       // cell.humidity.text = String(format:"%d %", weather.main?.humidity as!s CVarArg)
        cell.icon.image = cell.setImage(for: (weather.weather?[0].main)!)
        cell.dt_txt.text = Helper.covertDateToString(date: weather.dt!)
        cell.name.text = weather.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
}

extension SearchCityViewController : UISearchBarDelegate {
    
    private func searchBarTextDidEndEditing(searchBar: UISearchBar) {
    }

    private func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.cityWeathertList.removeAll()
        searchBar.resignFirstResponder()
        let cities = Helper.parseCityName(from: searchBar.text!.trimmingCharacters(in: .whitespaces))
        guard cities.count > 1 else {
            self.showAlert()
            return
        }
        //  let networkQueue = OperationQueue()

        cities.forEach { (city) in
            DispatchQueue.global().async {
                self.viewModel.fetchSearchedCityWeather(with: String(city).trimmingCharacters(in: .whitespaces))
                }
            }
        }
        
}


