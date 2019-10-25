//
//  ForecastViewController.swift
//  Weather App
//
//  Created by Anu Malm on 11/10/2019.
//  Copyright © 2019 Anu Malm. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var locationWeather : LocationWeatherModel!
    
    // UI links
    @IBOutlet weak var forecastTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.forecastTable.dataSource = self
        self.forecastTable.delegate = self
        
    }
    
    // Determine what happens when a cell is clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("moi")
    }
    
    // Determine how many cells are created
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationWeather.temperatureList.count
    }
    
    // Add cells to table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell")
        
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "forecastCell")
        }
        cell!.textLabel?.text = "moikka"
        cell!.imageView?.image = UIImage(named: locationWeather.temperatureList[indexPath.row].icon)
        // Set the cell so that the cell does not look selected even if clicked
        cell!.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell!
    }
    
    // Set selected location to show selected on table view
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.textLabel!.text == self.locationWeather.city {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
    
}

