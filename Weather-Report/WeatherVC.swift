//
//  WeatherVC.swift
//  Weather-Report
//
//  Copyright © 2016 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate,UITableViewDataSource, CLLocationManagerDelegate{
    
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var currentLowTemp: UILabel!
    @IBOutlet weak var currentHighTemp: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var currentTempLbl: UILabel!
    
    @IBOutlet weak var currentWeatherImg: UIImageView!
    
    @IBOutlet weak var locationLbl: UILabel!

    @IBOutlet weak var currentWeatherTypeLbl: UILabel!
    
    @IBOutlet weak var tableview: UITableView!
    
    var currentWeather = CurrentWeather()
    var forecastweather = ForecastWeather()
    
    let locationManager = CLLocationManager()
    var currentLocation : CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        print(UIDevice.current.name)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        locationAuthStatus()
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            currentWeather.downWeatherData {
                self.updateMainUI()
                self.forecastweather.downloadForecast {
                    self.tableview.reloadData()
                }
                
            }
            print(Location.sharedInstance.latitude, Location.sharedInstance.longitude)
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ForecastWeather.forecastsarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weathercell", for: indexPath) as? WeatherCell {
            let forecast = ForecastWeather.forecastsarray[indexPath.row]
            cell.updateCell(forecast: forecast)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       let forecast1 = ForecastWeather.forecastsarray[indexPath.row]
        performSegue(withIdentifier: "detailsVC", sender: forecast1)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? detailVC {
            if let sender = sender as? ForecastWeather {
                destination.fmaxTemp = sender.maxTemp
                destination.fminTemp = sender.minTemp
                destination.fpressure = sender.forPressure
                destination.fhumidity = sender.forHumidity
                destination.fcurrentweatherType = sender.weatherType
                destination.fdate = sender.date
            }
        }
    }
    
    func updateMainUI() {
        dateLbl.text = currentWeather.date
        currentTempLbl.text = "\(currentWeather.CurrentTemp)"+"°C"
        locationLbl.text = currentWeather.CityName
        currentWeatherTypeLbl.text = currentWeather.WeatherType
        currentWeatherImg.image = UIImage(named: currentWeather.WeatherType)
        humidityLbl.text = ":\(currentWeather.Humidity)"
        windLbl.text = ":\(currentWeather.WindSpeed)"
        var temp1 = currentWeather.currentHighTemp.convertToCelsius()
        temp1 = round(10*temp1)/10
        currentHighTemp.text = "\(temp1)"+"°C"
        var temp2 = currentWeather.currentLowtemp.convertToCelsius()
        temp2 = round(10*temp2)/10
        currentLowTemp.text = "\(temp2)"+"°C"
        
    }


}

