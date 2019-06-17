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
    private var currentTemperatureUnit: Unit
}

extension WeatherListViewModel {
    
    init() {
        
        self.weatherViewModels = []
        let userDefaults = UserDefaults.standard
        if let value = userDefaults.value(forKey: "unit") as? String {
            self.currentTemperatureUnit = Unit(rawValue: value) ?? .fahrenheit
        } else {
           self.currentTemperatureUnit = .fahrenheit
        }
    }
    
    
    mutating func addWeatherViewModel(_ vm: WeatherViewModel) {
        
        self.weatherViewModels.append(vm)
    }
    func numberOfRows(_ section: Int) -> Int {
        return self.weatherViewModels.count
    }
    func modelAt(_ index: Int) -> (WeatherViewModel, Unit) {
        return (self.weatherViewModels[index],currentTemperatureUnit)
    }
    
    mutating func updateUnit(to unit: Unit) {
        
        self.currentTemperatureUnit = unit
    }
    

    
}

struct WeatherViewModel: Codable {
    
    let name: String
    var currentTemperature: TemperatureViewModel
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case currentTemperature = "main"
      
    }
    
    private func toCelsius() -> Double {
        
        return (currentTemperature.temperature - 32) * 5/9
        
    }
    
    private func toFahrenheit() -> Double  {
        return currentTemperature.temperature
    }
    
    func returnTemperature(currentTemperatureUnit: Unit) -> Double {
        
        switch currentTemperatureUnit {
        case .celsius:
            return toCelsius()
        case .fahrenheit:
            return toFahrenheit()
        }
        
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
