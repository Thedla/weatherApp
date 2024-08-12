//
//  WeatherViewModel.swift
//  weatherApp
//
//  Created by Thedla's on 8/12/24.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var city: String = ""
    @Published var isLoading: Bool = true

    private var cancellable: AnyCancellable?
    private let locationManager = LocationManager()
    private let weatherService = WeatherService()
    
    init() {
        locationManager.onLocationUpdate = { [weak self] city in
            self?.city = city
            self?.fetchWeather(for: city)
        }
        
        loadInitialWeatherData()
    }

    func loadInitialWeatherData() {
        weatherService.loadLastSearchedCity { [weak self] lastCity in
            if let lastCity = lastCity {
                self?.city = lastCity
                self?.fetchWeather(for: lastCity)
            } else if self?.locationManager.hasLocationAccess == true {
                self?.locationManager.requestLocation()
            } else {
                self?.isLoading = false
            }
        }
    }

    func fetchWeather(for city: String) {
        isLoading = true
        weatherService.fetchWeather(for: city) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherResponse):
                    self?.weather = weatherResponse
                case .failure(let error):
                    print("Error fetching weather: \(error)")
                }
                self?.isLoading = false
            }
        }
    }
}

