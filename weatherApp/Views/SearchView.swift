//
//  SearchView.swift
//  weatherApp
//
//  Created by Thedla's on 8/12/24.
//
import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if viewModel.isLoading {
                    ProgressView(Strings.SearchView.loadingMessage)
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(1.5)
                        .padding(.top, 50)
                } else {
                    VStack(alignment: .leading, spacing: 20) {
                        TextField(Strings.SearchView.enterCityPlaceholder, text: $viewModel.city)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .padding([.leading, .trailing], 20)

                        Button(action: {
                            viewModel.fetchWeather(for: viewModel.city)
                        }) {
                            Text(Strings.SearchView.getWeatherButton)
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding([.leading, .trailing], 20)
                        }
                    }
                    .padding(.top, 50)

                    Spacer()

                    if let weather = viewModel.weather {
                        WeatherView(weather: weather)
                            .padding(.bottom, 50)
                    }
                }
            }
            .navigationTitle(Strings.SearchView.navigationTitle)
            .background(Color(.systemGroupedBackground))
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
