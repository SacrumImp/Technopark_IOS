//
//  MapViewModel.swift
//  pin-note
//
//  Created by Владислав Алпеев on 23.11.2020.
//

protocol MapViewModelProtocol: class{
    
    func getLocation() -> Location
    
}

class MapViewModel: MapViewModelProtocol{
    
    var currentLocation: Location
    
    var GEOService: GeolocationService!
    
    init() {
        self.currentLocation = Location(latitude: 55.75, longitude: 37.62)
    }
    
    func getLocation() -> Location {
        return self.currentLocation
    }
    
}

extension MapViewModel: GeolocationServiceDelegate{
    
    func didFetchCurrentLocation(_ location: Location) {
        self.currentLocation = location
        print("Location")
    }
    
    func fetchCurrentLocationFailed(error: Error) {
        return //TODO: реализовать обработку ошибки
    }
    
}
