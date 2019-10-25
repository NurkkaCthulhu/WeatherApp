//
//  CityViewController.swift
//  Weather App
//
//  Created by Anu Malm on 11/10/2019.
//  Copyright © 2019 Anu Malm. All rights reserved.
//

import UIKit


class CityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var determineMyCurrentLocation : (() -> Void)?
    var locationWeather : LocationWeatherModel!
    var locationsArray = ["Current city", "Tampere"]
    
    // UI links
    @IBOutlet weak var cityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cityTableView.dataSource = self
        self.cityTableView.delegate = self
        
        self.determineMyCurrentLocation!()
        
    }
    
    // Determine what happens when a cell is clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(locationsArray[indexPath.row])
    }
    
    // Determine how many cells are created
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locationsArray.count
    }
    
    // Add cells to table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cityName")
    
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cityName")
        }
        cell!.textLabel?.text = self.locationsArray[indexPath.row]
        cell!.imageView?.image = UIImage(named: "city")
        
        return cell!
    }
    
    // Set selected location to show selected on table view
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.textLabel?.text == "Current city" {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
    
    // vv ALERT FUNCTION vv
    func showAlert(userInput : String) {
        // Create alert with options
        let alertController = UIAlertController(title: "City not found", message: "Could not find city for \(userInput)!", preferredStyle: .alert)
        
        // Make the user accept that they made a mistake
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        alertController.addAction(OKAction)
        
        // Show the alert
        self.present(alertController, animated: true) {
            print("showing alert")
        }
    }
    
    
}

