//
//  WeatherListViewModel.swift
//  GoodWeather
//
//  Created by MacBook Air on 6/14/19.
//  Copyright © 2019 Riitech. All rights reserved.
//

import Foundation

class WeatherListViewModel {
    
    private(set) var weatherViewModels: [WeatherViewModel] = []
    private var currentTemperatureUnit: Unit
    
    init() {
        
        self.weatherViewModels = []
        let userDefaults = UserDefaults.standard
        if let value = userDefaults.value(forKey: "unit") as? String {
            self.currentTemperatureUnit = Unit(rawValue: value) ?? .fahrenheit
        } else {
           self.currentTemperatureUnit = .fahrenheit
        }
    }
    
    
    func addWeatherViewModel(_ vm: WeatherViewModel) {
        
        self.weatherViewModels.append(vm)
    }
    func numberOfRows(_ section: Int) -> Int {
        return self.weatherViewModels.count
        
    }
    func modelAt(_ index: Int) -> (WeatherViewModel, Unit) {
        return (self.weatherViewModels[index],currentTemperatureUnit)
        
    }
    
    func updateUnit(to unit: Unit) {
        self.currentTemperatureUnit = unit
        
    }
    

    
}

struct WeatherViewModel: Codable {
    
    let name: Dynamic<String>
    var currentTemperature: TemperatureViewModel
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = Dynamic(try container.decode(String.self, forKey: .name))
        currentTemperature = try container.decode(TemperatureViewModel.self, forKey: .currentTemperature)
    }
    
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case currentTemperature = "main"
      
    }
    
    private func toCelsius() -> Double {
        
        return (currentTemperature.temperature.value - 32) * 5/9
        
    }
    
    private func toFahrenheit() -> Double  {
        return currentTemperature.temperature.value
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
    var temperature: Dynamic<Double>
    let temperatureMin: Dynamic<Double>
    let temperatureMax: Dynamic<Double>
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temperature = Dynamic(try container.decode(Double.self, forKey: .temperature))
        temperatureMin = Dynamic(try container.decode(Double.self, forKey: .temperatureMin))
        temperatureMax = Dynamic(try container.decode(Double.self, forKey: .temperatureMax))
        
    }
}
