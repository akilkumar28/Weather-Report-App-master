//
//  date.swift
//  Weather-Report
//
//  Copyright © 2016 AKIL KUMAR THOTA. All rights reserved.
//

import Foundation
import UIKit


extension Date {
    func dayoftheweek() -> String {
        let dateformateer = DateFormatter()
        dateformateer.dateFormat = "EEEE"
        return dateformateer.string(from: self)
        }
}
