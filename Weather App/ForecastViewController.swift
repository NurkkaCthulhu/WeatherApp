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
    
    override func viewDidAppear(_ animated: Bool) {
        self.forecastTable.reloadData()
    }
    
    // Determine how many cells are created
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locationWeather.temperatureList.count
    }
    
    // Add cells to table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell")
        
        if (cell == nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "forecastCell")
        }
        cell!.textLabel?.text = "\(self.locationWeather.city) \(String(format:"%.01f", self.locationWeather.temperatureList[indexPath.row].temperature)) °C"
        cell!.detailTextLabel?.text = self.locationWeather.temperatureList[indexPath.row].time
        cell!.imageView?.image = UIImage(named: self.locationWeather.temperatureList[indexPath.row].icon)
        
        // Set the cell selectionStyle so that the cell does not look selected even if clicked
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

