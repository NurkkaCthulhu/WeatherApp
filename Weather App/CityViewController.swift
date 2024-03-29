//
//  CityViewController.swift
//  Weather App
//
//  Created by Anu Malm on 11/10/2019.
//  Copyright © 2019 Anu Malm. All rights reserved.
//

import UIKit
import CoreLocation

class CityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    var locationWeather : LocationWeatherModel!
    var locationsArray : [String]!
    var startCity : String!
    var selectedCity : String!
    
    var locationManager : CLLocationManager!
    var geocoder = CLGeocoder()
    
    // UI links
    @IBOutlet weak var cityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationsArray = ["Loading your location...", "Tampere", "Helsinki", "Turku", "Tokyo", "London"]
        
        self.cityTableView.dataSource = self
        self.cityTableView.delegate = self
        
        self.determineMyCurrentLocation()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.startCity = self.locationWeather.city
        self.selectedCity = self.locationWeather.city
    }
    
    // Determine what happens when a cell is clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.locationWeather.city = locationsArray[indexPath.row]
        self.selectedCity = locationsArray[indexPath.row]
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
        if cell.textLabel?.text == self.locationWeather.city {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }

    // vv LOCATION RELATED FUNCTIONS vv
    func determineMyCurrentLocation() -> Void {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        
        locationWeather.lat = (userLocation?.coordinate.latitude)!
        locationWeather.lon = (userLocation?.coordinate.longitude)!
        
        findCityFromCoordinates()
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func findCityFromCoordinates() {
        let location = CLLocation(latitude: locationWeather.lat, longitude: locationWeather.lon)

        // Start reversing the location lat/long into a city
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                NSLog("Unable to Reverse Geocode Location (\(error))")
            } else {
                if let placemarks = placemarks, let placemark = placemarks.first {
                    if placemark.locality != nil {
                        self.locationWeather.gpsCity = placemark.locality!
                        self.locationsArray[0] = self.locationWeather.gpsCity
                        self.cityTableView.reloadData()
                    } else {
                        // Add Earth to gpsCity and city if no locality was found
                        self.locationWeather.gpsCity = "Earth"
                        self.locationWeather.city = "Earth"
                        self.locationsArray[0] = self.locationWeather.gpsCity
                    }
                } else {
                    NSLog("Oh no, an error occurred")
                }
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        NSLog("Error \(error)")
    }

}

