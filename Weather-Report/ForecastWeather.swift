//
//  ForecastWeather.swift
//  Weather-Report
//
//  Copyright © 2016 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit
import Alamofire

class ForecastWeather {
    
    private var _date :String!
    private var _weatherType: String!
    private var _min :Double!
    private var _max: Double!
    private var _forPrssure:Double!
    private var _forHumdidty:Double!
    static var forecastsarray = [ForecastWeather]()
    
    
    var forPressure:Double{
        get{
            return _forPrssure
        }set{
            self._forPrssure = newValue
        }
    }
    var forHumidity:Double {
        get{
            return _forHumdidty
        }set{
            self._forHumdidty = newValue
        }
    }
   
    var weatherType : String {
        get {
            if self._weatherType == nil {
                self._weatherType = ""
                return self._weatherType
            }else {
                return self._weatherType
            }
        } set {
            self._weatherType = newValue
        }
    }
    
    var minTemp : Double {
        get {
            if self._min == nil {
                self._min = 0.0
                return self._min
            }else {
                return self._min
            }
        } set {
            self._min = newValue
        }
    }
    
    var maxTemp : Double {
        get {
            if self._max == nil {
                self._max = 0.0
                return self._max
            }else {
                return self._max
            }
        } set {
            self._max = newValue
        }
    }
    
    var date: String {
        get {
            if self._date == nil {
                self._date = ""
                return self._date
            } else {
                return self._date
            }
        } set {
            self._date = newValue
        }
    }
    
    
    func downloadForecast(completed: @escaping DownloadComplete) {
        let forecastURL = URL(string: ForeCasr_URL)!
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String,AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String,AnyObject>] {
                    
                    for obj in list {
                        let forecast = ForecastWeather()
                        forecast.parseData(obj: obj)
                        ForecastWeather.forecastsarray.append(forecast)
                    }
}
            }
            completed()
            
    }
}
    
    func parseData(obj: Dictionary<String, AnyObject>) {
//    init(obj: Dictionary<String, AnyObject>) {
        
        if let temp = obj["temp"] as? Dictionary<String,AnyObject> {
            if let mintemp = temp["min"] as? Double {
                let kelvin = mintemp
                var celsius = kelvin.convertToCelsius()
                celsius = round(10 * celsius) / 10
                self.minTemp = celsius
            }
            if let maxtemp = temp["max"] as? Double {
                let kelvin = maxtemp
                var celsius = kelvin.convertToCelsius()
                celsius = round(10 * celsius) / 10
                self.maxTemp = celsius
            }
            
        }
        if let pressure = obj["pressure"] as? Double {
            self.forPressure = pressure
        }
        if let humidity = obj["humidity"] as? Double {
            self.forHumidity = humidity
        }
        if let weather = obj["weather"] as? [Dictionary<String,AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self.weatherType = main
            }


        }
        if let dt = obj["dt"] as? Double {
            let unixToDate = Date(timeIntervalSince1970: dt)
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .full
            dateformatter.timeStyle = .full
            dateformatter.dateFormat = "EEEE"
            self.date = unixToDate.dayoftheweek()
        }
    }
}
