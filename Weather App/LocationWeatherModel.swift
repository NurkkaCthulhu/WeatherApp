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
        lat = 61.4978
        lon = 23.7610
        lastFetch = Date()
    }
}

class WeatherObject {
    var temperature : Double
    var time : String
    var icon : String
    
    init() {
        temperature = 0.0
        time = "1900-01-01 00:00:00"
        icon = ""
    }
}
