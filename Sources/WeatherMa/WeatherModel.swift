//
//  WeatherModel.swift
//  WeatherMaster
//
//  Created by Mohammad on 2/25/23.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weather = try? JSONDecoder().decode(Weather.self, from: jsonData)
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weather = try? JSONDecoder().decode(Weather.self, from: jsonData)

import Foundation

// MARK: - Weather
struct Weather: Codable {
    var latitude, longitude, generationtimeMS: Double?
    var utcOffsetSeconds: Int?
    var timezone, timezoneAbbreviation: String?
    var elevation: Int?
    var currentWeather: CurrentWeather?
    var hourlyUnits: HourlyUnits?
    var hourly: Hourly?

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case currentWeather = "current_weather"
        case hourlyUnits = "hourly_units"
        case hourly
    }
}

// MARK: - CurrentWeather
struct CurrentWeather: Codable {
    var temperature, windspeed: Double?
    var winddirection, weathercode: Int?
    var time: String?
}

// MARK: - Hourly
struct Hourly: Codable {
    var time: [String]?
    var temperature2M: [Double]?
    var relativehumidity2M: [Int]?
    var windspeed10M: [Double]?

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case relativehumidity2M = "relativehumidity_2m"
        case windspeed10M = "windspeed_10m"
    }
}

// MARK: - HourlyUnits
struct HourlyUnits: Codable {
    var time, temperature2M, relativehumidity2M, windspeed10M: String?

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case relativehumidity2M = "relativehumidity_2m"
        case windspeed10M = "windspeed_10m"
    }
}
