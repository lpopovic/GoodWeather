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
    private var dataSource: TableViewDataSource<WeatherCell, WeatherViewModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        dataSource = TableViewDataSource(cellIdentifier: "WeatherCell", items: self.weatherListViewModel.weatherViewModels, configureCell: { (weatherCell, weatherVM) in
            weatherCell.configure(weatherVM, self.weatherListViewModel.currentTemperatureUnit)
        })
        tableView.dataSource = dataSource
     
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "AddWeatherCityViewController":
            self.prepareSegueForAddWeatherCityViewController(segue: segue)
        case "SettingsTableViewController":
            self.prepareSegueForSettingsTableViewController(segue: segue)
        case "WeatherDetailsViewController":
            self.prepareSegueForWeatherDetailViewController(segue: segue)
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
    
    private func prepareSegueForWeatherDetailViewController(segue: UIStoryboardSegue) {
        if let weatherDetailVC = segue.destination as? WeatherDetailsViewController, let indexPath = tableView.indexPathForSelectedRow{
            let weatherVM = self.weatherListViewModel.modelAt(indexPath.row)
            
            weatherDetailVC.weatherViewModel = weatherVM.0
        }
    }
  
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension WeatherListTableViewController: AddWeatherDelegate {
    func addWeatherDidSave(vm: WeatherViewModel) {
        
        self.weatherListViewModel.addWeatherViewModel(vm)
        self.dataSource?.updateItems(self.weatherListViewModel.weatherViewModels)
        self.tableView.reloadData()
    }

}

extension WeatherListTableViewController: SettingsDelegate {
  
    func settingsDone(vm: SettingViewModel) {
        self.weatherListViewModel.updateUnit(to: vm.selectedUnit)
        self.tableView.reloadData()
        
    }
    
    
}
