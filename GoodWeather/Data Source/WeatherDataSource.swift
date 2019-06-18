//
//  WeatherDataSource.swift
//  GoodWeather
//
//  Created by MacBook Air on 6/18/19.
//  Copyright © 2019 Riitech. All rights reserved.
//

import Foundation
import UIKit

class WeatherDataSource: NSObject, UITableViewDataSource {
    
    let cellIdentifier: String = "WeatherCell"
    private var weatherListViewModel: WeatherListViewModel
    
    init( weatherListViewModel: WeatherListViewModel ) {
        self.weatherListViewModel = weatherListViewModel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherListViewModel.weatherViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! WeatherCell
        
        let curentVM = self.weatherListViewModel.modelAt(indexPath.row)
        cell.configure(curentVM.0, curentVM.1)
        
        return cell
    }
    
    
}
