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
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
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
        
        let weatherItemViewModel = self.weatherListViewModel.modelAt(indexPath.row)
        
        cell.configure(weatherItemViewModel.0, weatherItemViewModel.1)
        
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
        self.weatherListViewModel.updateUnit(to: vm.selectedUnit)
        self.tableView.reloadData()
        
    }
    
    
}
