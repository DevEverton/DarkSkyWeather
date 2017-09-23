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
        
        updateWeatherForLocation(location: "Rio de Janeiro")
        
        
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let locationString = searchBar.text, !locationString.isEmpty {
            updateWeatherForLocation(location: locationString)
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


    override func numberOfSections(in tableView: UITableView) -> Int {
        return forecastData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = Calendar.current.date(byAdding: .day, value: section, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        return dateFormatter.string(from: date!)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let weatherObject = forecastData[indexPath.section]
        
        cell.textLabel?.text = weatherObject.summary
        cell.detailTextLabel?.text = fahrenheitToCelsius(temperatureF: weatherObject.temperature)
        cell.imageView?.image = UIImage(named: weatherObject.icon)
        
        return cell
        
    }
    
    // Converting from fahrenheit to celsius, Celsius = ((Tf - 32)*5)/9
    func fahrenheitToCelsius(temperatureF: Double) -> String {
        var celsius = Double()
        let symbol = "ºC"
        celsius = ((temperatureF - 32)*5)/9
        return String.localizedStringWithFormat("%.f %@", celsius, symbol)
    }



}
