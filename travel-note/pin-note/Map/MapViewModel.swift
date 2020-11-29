//
//  MapViewModel.swift
//  pin-note
//
//  Created by Владислав Алпеев on 23.11.2020.
//

protocol MapViewModelProtocol: class{
    
    var currentLocation: Location {get}
    var currentLocationDidChange: ((Location) -> ())? { get set }
    
}

class MapViewModel: MapViewModelProtocol{
        
    var currentLocation: Location {
        willSet {
            self.currentLocationDidChange?(newValue)
        }
    }
    var currentLocationDidChange: ((Location) -> ())?
    
    private var GEOService: GeolocationService!
    
    init() {
        self.currentLocation = Location(latitude: 55.75, longitude: 37.62)
        self.GEOService = GeolocationService(delegate: self)
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
