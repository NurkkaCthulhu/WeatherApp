//
//  WeatherData.swift
//  Weather App
//
//  Created by Anu Malm on 10/10/2019.
//  Copyright © 2019 Anu Malm. All rights reserved.
//

struct WeatherData: Codable {
    var city: City
    var list : [TemperatureList]
}

struct City : Codable {
    var name : String
}

struct TemperatureList : Codable {
    var main : Temperature
    var weather: [WeatherIcon]
}

struct Temperature : Codable {
    var temp : Double
}

struct WeatherIcon: Codable {
    var icon: String
}
