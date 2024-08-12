//
//  AppStrings.swift
//  weatherApp
//
//  Created by Thedla's on 8/12/24.
//

import Foundation

struct InfoPlistReader {
    static func string(forKey key: String) -> String {
        guard let infoDict = Bundle.main.infoDictionary,
              let customStrings = infoDict["CustomStrings"] as? [String: String],
              let value = customStrings[key] else {
            fatalError("String for key \(key) not found in Info.plist")
        }
        return value
    }
}

struct Strings {
    struct SearchView {
        static let enterCityPlaceholder = InfoPlistReader.string(forKey: "EnterCityPlaceholder")
        static let getWeatherButton = InfoPlistReader.string(forKey: "GetWeatherButton")
        static let loadingMessage = InfoPlistReader.string(forKey: "LoadingMessage")
        static let navigationTitle = InfoPlistReader.string(forKey: "NavigationTitle")
    }
    
    struct WeatherView {
        static let locationLabel = InfoPlistReader.string(forKey: "LocationLabel")
        static let temperatureLabel = InfoPlistReader.string(forKey: "TemperatureLabel")
        static let descriptionLabel = InfoPlistReader.string(forKey: "DescriptionLabel")
    }
}
