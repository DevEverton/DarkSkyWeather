//
//  MainTVC.swift
//  DarkSkyWeather
//
//  Created by Everton Carneiro on 23/09/17.
//  Copyright © 2017 Everton. All rights reserved.
//

import UIKit
import CoreLocation

class MainTVC: UITableViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var forecastData = [Weather]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Weather.forecast(withLocation: "37.8267,-122.4233") { (results: [Weather]) in
//            for result in results {
//                
//                print("\(result)\n\n")
//            }
//        }
        
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        if let locationString = searchBar.text, !locationString.isEmpty {
            
            
            
        }
        
    }
    
    func updateWeatherForLocation (location: String) {
        CLGeocoder().geocodeAddressString(location) { (placemarks:[CLPlacemark]?, error:Error?) in
        
            if error == nil {
                    if let location = placemarks?.first?.location {
                        
                        Weather.forecast(withLocation: location.coordinate, completion: { (results: [Weather]?) in
                            if let weatherData = results {
                                self.forecastData = weatherData
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                                
                            }
                        })
                        
                    }
                
                
                
                
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherCell
        
        let weatherObject = forecastData[indexPath.section]
        
        cell.textLabel?.text = weatherObject.summary
        cell.detailTextLabel?.text = "\(Int(weatherObject.temperature)) °F"
        cell.imageView?.image = UIImage(named: weatherObject.icon)
        
        return cell
        
    }



}
