//
//  ForecastViewController.swift
//  Weather App
//
//  Created by Anu Malm on 11/10/2019.
//  Copyright © 2019 Anu Malm. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {

    var locationWeather : LocationWeatherModel!
    
    // UI links
    @IBOutlet weak var forecastTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

