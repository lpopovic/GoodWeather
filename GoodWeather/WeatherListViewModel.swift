//
//  WeatherListViewModel.swift
//  GoodWeather
//
//  Created by MacBook Air on 6/14/19.
//  Copyright © 2019 Riitech. All rights reserved.
//

import Foundation

struct WeatherListViewModel {
    
    private var weatherViewModels: [WeatherViewModel]
}

extension WeatherListViewModel {
    
    init() {

        self.weatherViewModels = []
    }
    
    
    mutating func addWeatherViewModel(_ vm: WeatherViewModel) {
        
        self.weatherViewModels.append(vm)
    }
    func numberOfRows(_ section: Int) -> Int {
        return self.weatherViewModels.count
    }
    func modelAt(_ index: Int) -> WeatherViewModel {
        return self.weatherViewModels[index]
    }
    
    mutating func updateUnit(to unit: Unit) {
     
            switch unit {
            case .celsius:
                self.toCelsius()
            case . fahrenheit:
                self.toFahrenheit()
            }

    }
    
   mutating private func toCelsius() {
    
       weatherViewModels = weatherViewModels.map { vm in
            var weatherModel = vm
            weatherModel.currentTemperature.temperature = (weatherModel.currentTemperature.temperature - 32) * 5/9
            return weatherModel
        }
    }
    
    mutating private func toFahrenheit() {
        weatherViewModels = weatherViewModels.map { vm in
            var weatherModel = vm
            weatherModel.currentTemperature.temperature = (weatherModel.currentTemperature.temperature * 5/9) + 32 
            return weatherModel
        }
    }
    
}

struct WeatherViewModel: Codable {
    
    let name: String
    var currentTemperature: TemperatureViewModel
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case currentTemperature = "main"
      
    }
}

struct TemperatureViewModel: Codable {
    var temperature: Double
    let temperatureMin: Double
    let temperatureMax: Double
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
}
