//
//  SettingTableViewController.swift
//  GoodWeather
//
//  Created by MacBook Air on 6/14/19.
//  Copyright © 2019 Riitech. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsDelegate {
    func settingsDone(vm: SettingViewModel)
}

class SettingsTableViewController: UITableViewController {
    
    private var settingViewModel = SettingViewModel()
    
    var delegate: SettingsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func done() {
        if let delegate = self.delegate {
            
            delegate.settingsDone(vm: self.settingViewModel)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    //MARK: TABLEVIEW DATA SOURCE
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingViewModel.units.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        
        let settingItem = self.settingViewModel.units[indexPath.row]
        
        cell.textLabel?.text = settingItem.displayName
        
        if settingItem == self.settingViewModel.selectedUnit {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    //MARK: TABLEVIEW DELEGATE
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // uncheck all cells
        tableView.visibleCells.forEach { (cell) in
            cell.accessoryType = .none
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            let unit = Unit.allCases[indexPath.row]
            self.settingViewModel.selectedUnit = unit
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
}
