//
//  WeatherResponse.swift
//  weatherApp
//
//  Created by Thedla's on 8/12/24.
//

import Foundation

// Root model representing the entire response
struct WeatherResponse: Decodable {
    let coord: Coordinates
    let weather: [WeatherCondition]
    let base: String
    let main: MainWeather
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: SystemInfo
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

// Model representing the coordinates
struct Coordinates: Decodable {
    let lon: Double
    let lat: Double
}

// Model representing the weather condition
struct WeatherCondition: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// Model representing the main weather information
struct MainWeather: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
    let sea_level: Int?
    let grnd_level: Int?
}

// Model representing the wind information
struct Wind: Decodable {
    let speed: Double
    let deg: Int
}

// Model representing the cloud information
struct Clouds: Decodable {
    let all: Int
}

// Model representing system information like country, sunrise, and sunset
struct SystemInfo: Decodable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}

