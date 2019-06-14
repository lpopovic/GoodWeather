//
//  Double+Extensions.swift
//  GoodWeather
//
//  Created by MacBook Air on 6/14/19.
//  Copyright © 2019 Riitech. All rights reserved.
//

import Foundation

extension Double {
    var formatAsDegree: String {
        return String(format: "%.0f°", self)
    }
}
