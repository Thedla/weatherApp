//
//  WeatherService.swift
//  weatherApp
//
//  Created by Thedla's on 8/12/24.
//

import Foundation

class WeatherService {
    private let apiKey = "be50d1c8e6ae420208aec44977d4b608"
    
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let formattedCity = city.replacingOccurrences(of: " ", with: "%20")
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(formattedCity)&appid=\(apiKey)&units=metric"

        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }

            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(weatherResponse))
                // Save the last searched city
                UserDefaults.standard.setValue(city, forKey: "LastCity")
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func loadLastSearchedCity(completion: @escaping (String?) -> Void) {
        let lastCity = UserDefaults.standard.string(forKey: "LastCity")
        completion(lastCity)
    }
}
