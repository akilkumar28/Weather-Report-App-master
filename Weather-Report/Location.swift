//
//  Location.swift
//  Weather-Report
//
//  Copyright © 2016 AKIL KUMAR THOTA. All rights reserved.
//

import CoreLocation


class Location {
    static var sharedInstance = Location()
    private init(){}
    
    var latitude: Double!
    var longitude: Double!
}
