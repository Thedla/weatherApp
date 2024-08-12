//
//  WeatherView.swift
//  weatherApp
//
//  Created by Thedla's on 8/12/24.
//

import SwiftUI

struct WeatherView: View {
    let weather: WeatherResponse

    var body: some View {
        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Text("\(Strings.WeatherView.locationLabel) \(weather.name), \(weather.sys.country)")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("\(Strings.WeatherView.temperatureLabel) \(String(format: "%.1f", weather.main.temp))°C")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("\(Strings.WeatherView.descriptionLabel) \(weather.weather.first?.description.capitalized ?? "N/A")")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 15).fill(Color.white).shadow(radius: 5))
            .padding([.leading, .trailing], 20)
            
            if let icon = weather.weather.first?.icon,
               let url = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png") {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                } placeholder: {
                    ProgressView()
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGroupedBackground))
    }
}
