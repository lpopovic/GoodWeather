//
//  WeatherCell.swift
//  GoodWeather
//
//  Created by MacBook Air on 6/13/19.
//  Copyright © 2019 Riitech. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperaturaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
extension WeatherCell {
    
    func configure(_ vm: WeatherViewModel, _ currentTemperauteUnit: Unit) {
        self.cityNameLabel.text = vm.name.value
        self.temperaturaLabel.text = "\(vm.returnTemperature(currentTemperatureUnit: currentTemperauteUnit).formatAsDegree)"
    }
    
}
