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
    
    let apiUrl : String = "https://api.openweathermap.org/data/2.5/forecast?lat=35&lon=139&APPID=65fee87105e0a7f8e4ad98ebda49d0e4"
    
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
        let resstr = String(data: data!, encoding: String.Encoding.utf8)
        
        // Execute stuff in UI thread
        DispatchQueue.main.async(execute: {() in
            //print(resstr!)
        })
        
        //print(data) tulee optional
        
        
        let decoder = JSONDecoder()
        do {
            let weather = try decoder.decode(WeatherData.self, from: data!)
            print("testaan taas")
            print(weather)
            //completionHandler(user, nil)
        } catch {
            print("error trying to convert data to JSON")
            print(error)
            //completionHandler(nil, error)
        }
        
    }

}

