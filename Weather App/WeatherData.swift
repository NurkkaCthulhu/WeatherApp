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
    //var coor : Coordinates
}

struct Coordinates : Codable {
    var lat : Double
    var lon : Double
}

struct TemperatureList : Codable {
    var main : Temperature
}

struct Temperature : Codable {
    var temp : Double
}
