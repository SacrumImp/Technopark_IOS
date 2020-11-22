//
//  ViewModel.swift
//  pin-note
//
//  Created by Владислав Алпеев on 14.11.2020.
//

import MapKit
import CoreLocation

protocol GeolocationServiceDelegate: class {
    
    func didFetchCurrentLocation(_ location: Location)
    func fetchCurrentLocationFailed(error: Error)
    
}

class GeolocationService: NSObject {
    
    let locationManager = CLLocationManager()
    var delegate: GeolocationServiceDelegate

    init(delegate: GeolocationServiceDelegate) {
        self.delegate = delegate
        super.init()
        self.setupLocationManager()
    }

    private func setupLocationManager() {
        if canUseLocationManager() {
           locationManager.delegate = self
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
           locationManager.requestWhenInUseAuthorization()
           locationManager.requestLocation()
           //locationManager.startUpdatingLocation()
        }
    }

    private func canUseLocationManager() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }

    deinit {
        locationManager.stopUpdatingLocation()
    }
}

extension GeolocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let geoLocation = Location(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            delegate.didFetchCurrentLocation(geoLocation)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate.fetchCurrentLocationFailed(error: error)
    }
}
