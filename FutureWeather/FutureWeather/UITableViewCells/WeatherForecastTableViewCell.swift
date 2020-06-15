//
//  WeatherForecastTableViewCell.swift
//  FutureWeather
//
//  Created by Mushtaque Ahmed on 15/06/2020.
//  Copyright © 2020 Mushtaque Ahmed. All rights reserved.
//

import UIKit


class WeatherForecastTableViewCell: UITableViewCell {
    @IBOutlet weak var main: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var dt_txt: UILabel!
    @IBOutlet weak var temp: UILabel!
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
        default:
            return  UIImage(named: "clear")!
        }
    }
}
