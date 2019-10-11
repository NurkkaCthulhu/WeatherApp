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
    
    let apiUrl : String = "https://api.openweathermap.org/data/2.5/forecast?q=Tampere,fi&APPID=65fee87105e0a7f8e4ad98ebda49d0e4"
    var currentCity : String = ""
    var currentTemperature : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        fetchUrl(url: apiUrl);
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
            let weather = try decoder.decode(WeatherData.self, from: data!)
            print("print whole Weather object:")
            print(weather)
            print("test printing something small from the object:")
            print(weather.city.name)

            currentCity = weather.city.name
            currentTemperature = weather.list[0].main.temp
            currentTemperature = currentTemperature - 273.15
            
        } catch {
            print("error trying to convert data to JSON")
            print(error)
        }
        
        // Execute stuff in UI thread
        DispatchQueue.main.async(execute: {() in
            self.cityLabel.text = self.currentCity
            self.temperatureLabel.text = "\(String(format:"%.01f", self.currentTemperature)) °C"
            
            // PLACEHOLDER: change img to Gates after load is done
            self.weatherImg.image = UIImage(named: "gates")
        })
        
    }

}

