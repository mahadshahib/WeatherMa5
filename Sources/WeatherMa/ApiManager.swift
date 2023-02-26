//
//  ApiManager.swift
//  WeatherMaster
//
//  Created by Mohammad on 2/25/23.
//

import Foundation
import CoreLocation
class APIManager {
    
    static let shared = APIManager()
    public func getCurrentLocationWeather(lon: CLLocationDegrees , lat: CLLocationDegrees ,completion: @escaping (Weather) -> Void) {
        
        var semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(lat)&longitude=\(lon)&current_weather=true&hourly=temperature_2m,relativehumidity_2m,windspeed_10m")!,timeoutInterval: Double.infinity)
        print(request.url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
            semaphore.signal()
            return
          }
            let weather = try? JSONDecoder().decode(Weather.self, from: data)
            guard let weather = weather else {
                semaphore.signal()
                return
            }
            completion(weather)
            semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        

    }
}
