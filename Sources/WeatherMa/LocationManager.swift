//
//  LocationManager.swift
//  WeatherMaster
//
//  Created by Mohammad on 2/25/23.
//

import Foundation
import CoreLocation

class LocationManager {
    
    static let shared = LocationManager()
    var locationManager = CLLocationManager()
    
    
    public func getCurrentLocationData(competion: @escaping (Location,CLLocation) -> Void) {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        var currentLoc: CLLocation!
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() == .authorizedAlways) {
            currentLoc = locationManager.location
           
            let location = Location(lon: currentLoc.coordinate.longitude, lat: currentLoc.coordinate.latitude)
            competion(location,currentLoc)
        }
    }
}
