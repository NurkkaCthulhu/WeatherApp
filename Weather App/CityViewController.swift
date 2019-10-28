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
    var currentCity : String!
    var startCity : String!
    var selectedCity : String!
    
    var locationManager : CLLocationManager!
    var geocoder = CLGeocoder()
    
    // UI links
    @IBOutlet weak var cityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentCity = self.locationWeather.gpsCity
        locationsArray = ["\(self.locationWeather.gpsCity)", "Tampere"]
        
        self.cityTableView.dataSource = self
        self.cityTableView.delegate = self
        
        self.determineMyCurrentLocation()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.startCity = self.locationWeather.city
        self.selectedCity = self.locationWeather.city
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("katotaa updaten tarve")
        if self.startCity != self.selectedCity {
            print("pls update")
            self.locationWeather.dataNeedsUpdate = true
            
        }
    }
    
    // Determine what happens when a cell is clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(locationsArray[indexPath.row])
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
        //print("cell text: \(self.currentCity) and locationweathercity: \(self.locationWeather.city)")
        if cell.textLabel?.text == self.locationWeather.city {
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
    
    // vv LOCATION RELATED FUNCTIONS vv
    func determineMyCurrentLocation() -> Void {
        print("location fetch?")
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.last
        
        //self.meetingCostModel.latitude = (userLocation?.coordinate.latitude)!
        //self.meetingCostModel.longitude = (userLocation?.coordinate.longitude)!
        //print("locationmanager functio \(String(describing: userLocation?.coordinate.latitude))!")
        //print("locationmanager functio \(String(describing: userLocation?.coordinate.longitude))!")
        
        locationWeather.lat = (userLocation?.coordinate.latitude)!
        locationWeather.lon = (userLocation?.coordinate.longitude)!
        
        findCityFromCoordinates()
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func findCityFromCoordinates() {
        let location = CLLocation(latitude: locationWeather.lat, longitude: locationWeather.lon)
        //let location = CLLocation(latitude: 0, longitude: 0)
        // Start reversing the location lat/long into a city
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                NSLog("Unable to Reverse Geocode Location (\(error))")
            } else {
                if let placemarks = placemarks, let placemark = placemarks.first {
                    if placemark.locality != nil {
                        print("pistetää gpsCity")
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

