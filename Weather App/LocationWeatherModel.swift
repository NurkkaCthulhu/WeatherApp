//
//  LocationWeatherModel.swift
//  Weather App
//
//  Created by Anu Malm on 11/10/2019.
//  Copyright © 2019 Anu Malm. All rights reserved.
//

import Foundation

class LocationWeatherModel {
    var city : String
    var gpsCity : String
    var temperatureList : [WeatherObject]
    var lat : Double
    var lon : Double
    var lastFetch : Date
    
    init() {
        city = "Tampere"
        gpsCity = "Earth"
        temperatureList = []
        // Tampere lat and lon
        lat = 61.4978
        lon = 23.7610
        // Set last fetch date to 1997-02-02 02:26:51
        lastFetch = Date(timeIntervalSinceReferenceDate: -123456789.0)
    }
}

class WeatherObject {
    var temperature : Double
    var time : String
    var icon : String
    
    init(temperature: Double, time: String, icon: String) {
        self.temperature = temperature
        self.time = time
        self.icon = icon
    }
}
