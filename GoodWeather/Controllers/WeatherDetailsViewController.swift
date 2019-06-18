//
//  WeatherDetailsViewController.swift
//  GoodWeather
//
//  Created by MacBook Air on 6/18/19.
//  Copyright © 2019 Riitech. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {
    
    var weatherViewModel: WeatherViewModel?
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModelBindings()
        
        
    }
    
    func setupViewModelBindings() {
        if let weatherVM = self.weatherViewModel {
            
            weatherVM.name.bind { self.cityNameLabel.text = $0 }
            weatherVM.currentTemperature.temperature.bind { self.currentTemperatureLabel.text = $0.formatAsDegree }
            weatherVM.currentTemperature.temperatureMax.bind { self.maxTempLabel.text = $0.formatAsDegree }
            weatherVM.currentTemperature.temperatureMin.bind { self.minTempLabel.text = $0.formatAsDegree }
            
        }
        
        // promeni value
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            
            self.weatherViewModel?.name.value = "MOSA"
            self.weatherViewModel?.currentTemperature.temperature.value = 1000.0
            self.weatherViewModel?.currentTemperature.temperatureMax.value = 1000.0
            self.weatherViewModel?.currentTemperature.temperatureMin.value = 1000.0
            
            
        }
    }
}
