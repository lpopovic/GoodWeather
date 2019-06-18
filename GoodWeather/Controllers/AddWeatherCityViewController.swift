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
    
    private var addCityViewModel = AddCityViewModel()
    
    @IBOutlet weak var progressView: UIActivityIndicatorView! {
        didSet {
            self.progressView.isHidden = true
        }
    }
    
    @IBOutlet weak var cityNameTextField: BindingTextField! {
        didSet {
            cityNameTextField.bind {
                self.addCityViewModel.city = $0
            }
        }
    }
    
    @IBOutlet weak var stateNameTextField: BindingTextField! {
        didSet {
            stateNameTextField.bind {
                self.addCityViewModel.state = $0
            }
        }
    }
    @IBOutlet weak var zipCodeNameTextField: BindingTextField! {
        didSet {
            zipCodeNameTextField.bind {
                self.addCityViewModel.zipCode = $0
            }
        }
    }
    
    var delegate: AddWeatherDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityNameTextField.becomeFirstResponder()
    }
    
    @IBAction func saveCityButtonPressed() {
        
        if let city = cityNameTextField.text {
            self.progressView.isHidden = false
            self.progressView.startAnimating()
            self.setUserInteractionSubViews(false, self.view)
            
            let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=2c2565d5d855a85a3f2ffe59315a3d8e&units=imperial")!
            
            let weatherResource = Resource<WeatherViewModel>(url: weatherURL) { (data)in
                
                let weatherVM = try? JSONDecoder().decode(WeatherViewModel.self, from: data)
                return weatherVM
            }
         
            WebService().load(resource: weatherResource) { [weak self] result in
                if let vm = result {
                    self?.progressView.stopAnimating()
                    self?.progressView.isHidden = true
                    self?.setUserInteractionSubViews(true, self!.view)

                    if let delegate = self?.delegate {
                        delegate.addWeatherDidSave(vm: vm)
                        self?.dismiss(animated: true, completion: nil)
                    }
                } else {
                  
                    self?.progressView.stopAnimating()
                    self?.progressView.isHidden = true
                    self?.setUserInteractionSubViews(true, self!.view)
                    
                    
                }
            }
        }
    }
    
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUserInteractionSubViews(_ enabled: Bool, _ view: UIView) {
        for view in view.subviews {
            view.isUserInteractionEnabled = enabled
        }
        
    }
}
