//
//  AddWeatherCityViewController.swift
//  GoodWeather
//
//  Created by MacBook Air on 6/13/19.
//  Copyright © 2019 Riitech. All rights reserved.
//

import Foundation
import UIKit

protocol AddWeatherDelegate  {
    func addWeatherDidSave(vm: WeatherViewModel)
}


class AddWeatherCityViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    
    var delegate: AddWeatherDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityNameTextField.becomeFirstResponder()
    }
    
    @IBAction func saveCityButtonPressed() {
        
        if let city = cityNameTextField.text {
            
            // get the default settings for temperature
            let userDefaults = UserDefaults.standard
            var unit = "imperial"
            if let value = userDefaults.value(forKey: "unit") as? String {
                unit = value
            }
            let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=2c2565d5d855a85a3f2ffe59315a3d8e&units=\(unit)")!
            
            let weatherResource = Resource<WeatherViewModel>(url: weatherURL) { (data)in
                
                let weatherVM = try? JSONDecoder().decode(WeatherViewModel.self, from: data)
                return weatherVM
            }
         
            WebService().load(resource: weatherResource) { [weak self] result in
                if let vm = result {
                    if let delegate = self?.delegate {
                        delegate.addWeatherDidSave(vm: vm)
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
