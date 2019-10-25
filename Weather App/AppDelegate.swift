//
//  AppDelegate.swift
//  Weather App
//
//  Created by Anu Malm on 08/10/2019.
//  Copyright © 2019 Anu Malm. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window : UIWindow?
    
    var locationManager : CLLocationManager!
    var geocoder = CLGeocoder()
    
    var locationWeather : LocationWeatherModel!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        locationWeather = LocationWeatherModel()
        
        let tabController = self.window!.rootViewController as! UITabBarController
        let myViewController = tabController.viewControllers![0] as! ViewController
        myViewController.locationWeather = self.locationWeather
        
        let myForecastViewController = tabController.viewControllers![1] as! ForecastViewController
        myForecastViewController.locationWeather = self.locationWeather
        
        let myCityViewController = tabController.viewControllers![2] as! CityViewController
        myCityViewController.locationWeather = self.locationWeather
        myCityViewController.determineMyCurrentLocation = self.determineMyCurrentLocation
        
        determineMyCurrentLocation()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
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
                print("Unable to Reverse Geocode Location (\(error))")
            } else {
                if let placemarks = placemarks, let placemark = placemarks.first {
                    if placemark.locality != nil {
                        self.locationWeather.city = placemark.locality!
                    } else {
                        self.locationWeather.city = "Tampere"
                        self.locationWeather.lat = 61.4978
                        self.locationWeather.lon = 23.7610
                    }
                } else {
                    NSLog("Oh no, an error occurred")
                }
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }


}

