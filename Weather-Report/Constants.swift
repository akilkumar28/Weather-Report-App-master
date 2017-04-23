//
//  Constants.swift
//  Weather-Report
//
//  Copyright © 2016 AKIL KUMAR THOTA. All rights reserved.
//

import Foundation

let Base_Url = "http://api.openweathermap.org/data/2.5/weather?"
let Latitude = "lat="
let Longtitude = "&lon="
let Api_id = "&appid="
let Api_key = "075f118b230b213f178c035895035a75"

let Full_Url = "\(Base_Url)\(Latitude)\(Location.sharedInstance.latitude!)\(Longtitude)\(Location.sharedInstance.longitude!)\(Api_id)\(Api_key)"

typealias DownloadComplete = () -> ()

let ForeCasr_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&mode=json&appid=075f118b230b213f178c035895035a75"
