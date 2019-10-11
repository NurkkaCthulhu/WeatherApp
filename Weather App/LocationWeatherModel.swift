//
//  LocationWeatherModel.swift
//  Weather App
//
//  Created by Anu Malm on 11/10/2019.
//  Copyright © 2019 Anu Malm. All rights reserved.
//

import Foundation

class LocationWeatherModel {
    var temperatureList : [Double]
    var lat : Double
    var lon : Double
    var lastFetch : Date
    
    init() {
        temperatureList = []
        lat = 0
        lon = 0
        lastFetch = Date()
    }
}
