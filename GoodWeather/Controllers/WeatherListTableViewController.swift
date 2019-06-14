//
//  WeatherListTableViewController.swift
//  GoodWeather
//
//  Created by MacBook Air on 6/13/19.
//  Copyright © 2019 Riitech. All rights reserved.
//

import Foundation
import UIKit

class WeatherListTableViewController: UITableViewController {
    
    private var weatherListViewModel = WeatherListViewModel()
    private var currentTemperatureUnit: Unit!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let value = UserDefaults.standard.value(forKey: "unit") as? String {
            self.currentTemperatureUnit = Unit(rawValue: value)!
        }else {
            self.currentTemperatureUnit = .fahrenheit
        }
        self.navigationController?.navigationBar.prefersLargeTitles = true
     
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "AddWeatherCityViewController":
            self.prepareSegueForAddWeatherCityViewController(segue: segue)
        case "SettingsTableViewController":
            self.prepareSegueForSettingsTableViewController(segue: segue)
        default:
            break
        }
        
    }
    
    private func prepareSegueForAddWeatherCityViewController(segue: UIStoryboardSegue) {
        if let nvc = segue.destination as? UINavigationController, let addWeatherVC = nvc.viewControllers.first as? AddWeatherCityViewController {
            addWeatherVC.delegate = self
        }
    }
     private func prepareSegueForSettingsTableViewController(segue: UIStoryboardSegue) {
        if let nvc = segue.destination as? UINavigationController, let settingVC = nvc.viewControllers.first as? SettingsTableViewController {
            settingVC.delegate = self
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherListViewModel.numberOfRows(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        
        let weathVM = self.weatherListViewModel.modelAt(indexPath.row)
        
        cell.configure(weathVM)
        
        return cell
    }
}

extension WeatherListTableViewController: AddWeatherDelegate {
    func addWeatherDidSave(vm: WeatherViewModel) {
        
        self.weatherListViewModel.addWeatherViewModel(vm)
        self.tableView.reloadData()
    }

}

extension WeatherListTableViewController: SettingsDelegate {
  
    func settingsDone(vm: SettingViewModel) {
        if self.currentTemperatureUnit.rawValue != vm.selectedUnit.rawValue {
            self.weatherListViewModel.updateUnit(to: vm.selectedUnit)
            self.tableView.reloadData()
            self.currentTemperatureUnit = Unit(rawValue: vm.selectedUnit.rawValue)
        }
    }
    
    
}
