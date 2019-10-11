//
//  CityViewController.swift
//  Weather App
//
//  Created by Anu Malm on 11/10/2019.
//  Copyright © 2019 Anu Malm. All rights reserved.
//

import UIKit
import CoreLocation

class CityViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager : CLLocationManager!
    var geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // vv LOCATION RELATED FUNCTIONS vv
    func determineMyCurrentLocation() {
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
        
        addLocationToField()
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func addLocationToField() {
        let location = CLLocation(latitude: 2, longitude: 2)
        
        // Start reversing the location lat/long into a city
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Unable to Reverse Geocode Location (\(error))")
            } else {
                if let placemarks = placemarks, let placemark = placemarks.first {
                    //self.meetingName.text = "Meeting in \(placemark.locality!)"
                } else {
                    //self.meetingName.text = "No Matching Addresses Found"
                }
            }
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
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

