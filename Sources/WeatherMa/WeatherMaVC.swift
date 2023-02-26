//
//  WeatherMaVC.swift
//  WeatherMaster
//
//  Created by Mohammad on 2/25/23.
//

import UIKit
import CoreLocation


public class WeatherMaVC: UIViewController , CLLocationManagerDelegate {

    @IBOutlet weak var locationTitle: UIButton!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var windTitle: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    public static let storyboardVC = UIStoryboard(name: "WeatherMaVC", bundle: Bundle.module).instantiateInitialViewController()!


    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        containerView.layer.cornerRadius = 16
        LocationManager.shared.locationManager.delegate = self
        LocationManager.shared.locationManager.requestAlwaysAuthorization()
  
    }
    
    @IBAction func locationBtnTapped(_ sender: Any) {
            // do stuff
            LocationManager.shared.getCurrentLocationData { [weak self] location , cllocation in
                guard let self else {return}
                let geoCoder = CLGeocoder()

                geoCoder.reverseGeocodeLocation(cllocation, completionHandler: { (placemarks, _) -> Void in

                    
                    placemarks?.forEach { (placemark) in

                        if let city = placemark.locality {
                            print(city)
                            self.locationTitle.setTitle(city, for: .normal)
                        }
                    }
                })
                APIManager.shared.getCurrentLocationWeather(lon: location.lon, lat: location.lat, completion: { [weak self] weather in
                    guard let self else {return}
                    DispatchQueue.main.async { [weak self] in
                        guard let self else {return}
                                                        
                        
                        self.tempLabel.text = "\(Int(weather.currentWeather?.temperature ?? 0) ?? 0)°"
                        guard let temp = weather.currentWeather?.temperature else {
                            self.backgroundImage.image = UIImage(named: "-3")
                            return}
                        switch temp {
                        case (-100)...(-3) :
                            self.backgroundImage.image = UIImage(named: "-3")
                            
                        case (-3)...(-1) :
                            self.backgroundImage.image = UIImage(named: "-1")

                        case (-1)...0:
                            self.backgroundImage.image = UIImage(named: "0")

                        case 0...2:
                            self.backgroundImage.image = UIImage(named: "2")

                        case 2...9:
                            self.backgroundImage.image = UIImage(named: "9")

                        case 9...12:
                            self.backgroundImage.image = UIImage(named: "12")

                        case 12...16:
                            self.backgroundImage.image = UIImage(named: "16")

                        case 16...18:
                            self.backgroundImage.image = UIImage(named: "18")

                        case 18...22:
                            self.backgroundImage.image = UIImage(named: "22")

                        default :
                            self.backgroundImage.image = UIImage(named: "22")

                        }
                        
                        // get the current date and time
                        let currentDateTime = Date()

                        // initialize the date formatter and set the style
                        let formatter = DateFormatter()
                        formatter.timeStyle = .medium
                        formatter.dateStyle = .long

                        // get the date time String from the date object
                        formatter.string(from: currentDateTime) // October 8, 2016 at 10:48:53 PM
                        
                        self.dateLabel.text = formatter.string(from: currentDateTime)
                        self.windTitle.text = "\(weather.currentWeather?.windspeed ?? 0) km/h"
                        self.humidityLabel.text = "\(weather.currentWeather?.winddirection ?? 0)"
                    }
                })
            }
            }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
                    LocationManager.shared.getCurrentLocationData { [weak self] location , cllocation in
                        guard let self else {return}
                        let geoCoder = CLGeocoder()

                        geoCoder.reverseGeocodeLocation(cllocation, completionHandler: { (placemarks, _) -> Void in

                            
                            placemarks?.forEach { (placemark) in

                                if let city = placemark.locality {
                                    print(city)
                                    self.locationTitle.setTitle(city, for: .normal)
                                }
                            }
                        })
                        APIManager.shared.getCurrentLocationWeather(lon: location.lon, lat: location.lat, completion: { [weak self] weather in
                            guard let self else {return}
                            DispatchQueue.main.async { [weak self] in
                                guard let self else {return}
                                                                
                                
                                self.tempLabel.text = "\(Int(weather.currentWeather?.temperature ?? 0) ?? 0)°"
                                guard let temp = weather.currentWeather?.temperature else {
                                    self.backgroundImage.image = UIImage(named: "-3")
                                    return}
                                switch temp {
                                case (-100)...(-3) :
                                    self.backgroundImage.image = UIImage(named: "-3")
                                    
                                case (-3)...(-1) :
                                    self.backgroundImage.image = UIImage(named: "-1")

                                case (-1)...0:
                                    self.backgroundImage.image = UIImage(named: "0")

                                case 0...2:
                                    self.backgroundImage.image = UIImage(named: "2")

                                case 2...9:
                                    self.backgroundImage.image = UIImage(named: "9")

                                case 9...12:
                                    self.backgroundImage.image = UIImage(named: "12")

                                case 12...16:
                                    self.backgroundImage.image = UIImage(named: "16")

                                case 16...18:
                                    self.backgroundImage.image = UIImage(named: "18")

                                case 18...22:
                                    self.backgroundImage.image = UIImage(named: "22")

                                default :
                                    self.backgroundImage.image = UIImage(named: "22")

                                }
                                
                                // get the current date and time
                                let currentDateTime = Date()

                                // initialize the date formatter and set the style
                                let formatter = DateFormatter()
                                formatter.timeStyle = .medium
                                formatter.dateStyle = .long

                                // get the date time String from the date object
                                formatter.string(from: currentDateTime) // October 8, 2016 at 10:48:53 PM
                                
                                self.dateLabel.text = formatter.string(from: currentDateTime)
                                self.windTitle.text = "\(weather.currentWeather?.windspeed ?? 0) km/h"
                                self.humidityLabel.text = "\(weather.currentWeather?.winddirection ?? 0)"
                            }
                        })
                    }
                }
            }
        }
    }
}

