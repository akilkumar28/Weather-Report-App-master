//
//  WeatherCell.swift
//  Weather-Report
//
//  Copyright © 2016 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    
    @IBOutlet weak var minLbl: UILabel!
    @IBOutlet weak var maxLbl: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var weatherIcon: roundedImages!

    func updateCell(forecast: ForecastWeather) {
        minLbl.text = "\(forecast.minTemp)"+"°C"
        maxLbl.text = "\(forecast.maxTemp)"+"°C"
        weatherType.text = forecast.weatherType
        date.text = forecast.date
        weatherIcon.image = UIImage(named: forecast.weatherType)
    }
    
    

    
}
