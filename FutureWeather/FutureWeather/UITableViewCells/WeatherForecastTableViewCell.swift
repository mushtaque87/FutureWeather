//
//  WeatherForecastTableViewCell.swift
//  FutureWeather
//
//  Created by Mushtaque Ahmed on 15/06/2020.
//  Copyright © 2020 Mushtaque Ahmed. All rights reserved.
//

import UIKit

enum ScreenType  {
    case CurrentCity
    case SearchedCity
}

class WeatherForecastTableViewCell: UITableViewCell {
    @IBOutlet weak var main: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var dt_txt: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var mintemp: UILabel!
    @IBOutlet weak var maxtemp: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setImage(for type:String) -> UIImage {
        switch type {
        case "Rain":
            return UIImage(named: "rain")!
        case "Clear":
            return  UIImage(named: "clear")!
        case "Clouds":
            return UIImage(named: "cloud")!
        case "Haze":
            return UIImage(named: "haze")!
        case "Thunderstorm":
            return UIImage(named: "thunderstorm")!
        default:
            return  UIImage(named: "clear")!
        }
    }
    
    func setUI(screenType:ScreenType) {
        switch screenType {
        case .CurrentCity:
            self.temp.isHidden = false
            self.mintemp.isHidden = true
            self.maxtemp.isHidden = true
            self.wind.isHidden = true
            break
        case .SearchedCity:
            self.temp.isHidden = true
            self.mintemp.isHidden = false
            self.maxtemp.isHidden = false
            self.wind.isHidden = false
            break
            
        }
    }
}
