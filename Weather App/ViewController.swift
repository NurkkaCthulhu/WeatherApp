//
//  ViewController.swift
//  Weather App
//
//  Created by Anu Malm on 08/10/2019.
//  Copyright © 2019 Anu Malm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // UI links
    @IBOutlet weak var cityLabel : UILabel!
    @IBOutlet weak var temperatureLabel : UILabel!
    @IBOutlet weak var weatherImg : UIImageView!
    
    // Animation images
    var load0 : UIImage!
    var load1 : UIImage!
    var load2 : UIImage!
    var load3 : UIImage!
    var load4 : UIImage!
    var load5 : UIImage!
    var loadingImages : [UIImage]!
    var animatedImg : UIImage!
    
    var locationWeather: LocationWeatherModel!
    var secretKeys : SecretKeys = SecretKeys()
    var apiUrl : String!
    var weatherData : WeatherData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.apiUrl = "https://api.openweathermap.org/data/2.5/forecast?lat=\(self.locationWeather.lat)&lon=\(self.locationWeather.lon)&APPID=\(self.secretKeys.api)"
        print(self.locationWeather)
        
        addLoadingAnimation()

        cityLabel.text = "Loading..."
        temperatureLabel.isHidden = true
        
        // Check if data was fetched over 5 minutes ago, if yes then fetch again
        if fetchNewData() {
            fetchUrl(url: apiUrl)
        }
    }
    
    func fetchNewData() -> Bool {
        let currentDate = Date()
        let seconds = currentDate.timeIntervalSince(locationWeather.lastFetch)
        let minutes = seconds/60
        print(locationWeather.lastFetch)
        
        if minutes >= 5 {
            print("over 5min")
            locationWeather.lastFetch = currentDate
            print(locationWeather.lastFetch)
            return true
        } else {
            print("not even 5min")
            return false
        }
    }
    
    func addLoadingAnimation() {
        self.load0 = UIImage(named: "load0")
        self.load1 = UIImage(named: "load1")
        self.load2 = UIImage(named: "load2")
        self.load3 = UIImage(named: "load3")
        self.load4 = UIImage(named: "load4")
        self.load5 = UIImage(named: "load5")
        
        self.loadingImages = [load0, load1, load2, load3, load4, load5]
        
        self.animatedImg = UIImage.animatedImage(with: loadingImages, duration: 0.8)
        self.weatherImg.image = animatedImg
    }

    func fetchUrl(url : String) {
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        let url : URL? = URL(string: url)
        
        let task = session.dataTask(with: url!, completionHandler: doneFetching);
        // Starts the task, spawns a new thread and calls the callback function
        task.resume();
    }
    
    func doneFetching(data: Data?, response: URLResponse?, error: Error?) {
        //let resstr = String(data: data!, encoding: String.Encoding.utf8)
        
        let decoder = JSONDecoder()
        do {
            self.weatherData = try decoder.decode(WeatherData.self, from: data!)
            //print("print whole Weather object:")
            //print(weather)
            //print("test printing something small from the object:")
            //print(weather.city.name)

            var currentTemperature = weatherData.list[0].main.temp
            currentTemperature = currentTemperature - 273.15
            
            print(weatherData.list[0].dt_txt)

            let currentWeatherIcon = weatherData.list[0].weather[0].icon
            print(weatherData.list.count)
            locationWeather.temperatureList.append(WeatherObject(temperature: currentTemperature, time: weatherData.list[0].dt_txt, icon: currentWeatherIcon))
            
        } catch {
            print("Error trying to convert data to JSON")
            print(error)
        }
        
        // Execute stuff in UI thread
        DispatchQueue.main.async(execute: {() in
            
            print("update UI")
            
            self.cityLabel.text = self.locationWeather.city
            self.temperatureLabel.text = "\(String(format:"%.01f", self.locationWeather.temperatureList[0].temperature)) °C"
            
            // Unhide labels
            self.cityLabel.isHidden = false
            self.temperatureLabel.isHidden = false
            
            // Update weather icon
            self.weatherImg.image = UIImage(named: self.locationWeather.temperatureList[0].icon)
        })
        
    }

}

