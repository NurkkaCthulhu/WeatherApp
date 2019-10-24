//
//  CityViewController.swift
//  Weather App
//
//  Created by Anu Malm on 11/10/2019.
//  Copyright © 2019 Anu Malm. All rights reserved.
//

import UIKit


class CityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var locationWeather : LocationWeatherModel!
    
    // UI links
    @IBOutlet weak var cityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cityTableView.dataSource = self
        self.cityTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath)
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cityName")
        cell.textLabel?.text = "Current city"
        cell.imageView?.image = UIImage(named: "city")
        return cell
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

