//
//  ResponsiveSearchView.swift
//  weatherApp
//
//  Created by Thedla's on 8/12/24.
//

import SwiftUI

struct ResponsiveSearchView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                    } else {
                        TextField("Enter city name", text: $viewModel.city)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .frame(maxWidth: geometry.size.width * (horizontalSizeClass == .compact ? 0.8 : 0.6))

                        Button(action: {
                            viewModel.fetchWeather(for: viewModel.city)
                        }) {
                            Text("Get Weather")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: geometry.size.width * (horizontalSizeClass == .compact ? 0.6 : 0.4))
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding()

                        if let weather = viewModel.weather {
                            WeatherView(weather: weather)
                                .frame(maxWidth: geometry.size.width * (horizontalSizeClass == .compact ? 0.9 : 0.8))
                        }
                    }
                }
                .navigationTitle("Weather App")
                .padding()
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

