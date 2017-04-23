//
//  Double.swift
//  Weather-Report
//
//  Copyright © 2016 AKIL KUMAR THOTA. All rights reserved.
//

import Foundation
import UIKit


extension Double {
    func convertToCelsius() -> Double {
        let value = Double(self - 273.15)
        return value
    }
}
