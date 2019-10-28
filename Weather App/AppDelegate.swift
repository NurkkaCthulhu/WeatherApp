//
//  AppDelegate.swift
//  Weather App
//
//  Created by Anu Malm on 08/10/2019.
//  Copyright © 2019 Anu Malm. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?    
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

}

