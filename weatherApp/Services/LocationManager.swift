//
//  LocationManager.swift
//  weatherApp
//
//  Created by Thedla's on 8/12/24.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var hasLocationAccess = false
    
    var onLocationUpdate: ((String) -> Void)?
    private var locationUpdateCount = 0
    
   

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10 // meters
        checkAuthorizationStatus()
    }
    
    private func checkAuthorizationStatus() {
        let status = locationManager.authorizationStatus
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if status == .authorizedWhenInUse || status == .authorizedAlways {
            hasLocationAccess = true
        } else {
            hasLocationAccess = false
        }
    }
    
    func requestLocation() {
        if hasLocationAccess && CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorizationStatus()
        if hasLocationAccess {
            requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        let locationAge = location.timestamp.timeIntervalSinceNow
        guard locationAge < 15 else { return }
        guard location.horizontalAccuracy < 100 else { return }

        locationUpdateCount += 1
        
        if locationUpdateCount > 1 {
            fetchCityName(from: location)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error)")
    }
    
    private func fetchCityName(from location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                DispatchQueue.main.async {
                    if let city = placemark.locality {
                        self.onLocationUpdate?(city)
                    }
                }
            }
        }
    }
}
