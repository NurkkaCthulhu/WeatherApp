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
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    
    // Animation images
    var load0 : UIImage!
    var load1 : UIImage!
    var load2 : UIImage!
    var load3 : UIImage!
    var load4 : UIImage!
    var load5 : UIImage!
    var loadingImages : [UIImage]!
    var animatedImg : UIImage!
    
    let apiUrl : String = "https://api.openweathermap.org/data/2.5/forecast?q=Tampere,fi&APPID=65fee87105e0a7f8e4ad98ebda49d0e4"
    var currentCity : String = ""
    var currentTemperature : Double = 0.0
    var currentWeatherIcon : String = ""
    var weather : WeatherData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLoadingAnimation()

        cityLabel.text = "Loading..."
        temperatureLabel.isHidden = true
        
        fetchUrl(url: apiUrl);
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
            weather = try decoder.decode(WeatherData.self, from: data!)
            print("print whole Weather object:")
            print(weather)
            print("test printing something small from the object:")
            print(weather.city.name)

            currentCity = weather.city.name
            currentTemperature = weather.list[0].main.temp
            currentTemperature = currentTemperature - 273.15
            currentWeatherIcon = weather.list[0].weather[0].icon
            
        } catch {
            print("Error trying to convert data to JSON")
            print(error)
        }
        
        // Execute stuff in UI thread
        DispatchQueue.main.async(execute: {() in
            
            self.cityLabel.text = self.currentCity
            self.temperatureLabel.text = "\(String(format:"%.01f", self.currentTemperature)) °C"
            
            // Unhide labels
            self.cityLabel.isHidden = false
            self.temperatureLabel.isHidden = false
            
            // Update weather icon
            self.weatherImg.image = UIImage(named: self.currentWeatherIcon)
        })
        
    }

}

