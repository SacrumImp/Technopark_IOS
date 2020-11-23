//
//  MapViewModel.swift
//  pin-note
//
//  Created by Владислав Алпеев on 23.11.2020.
//

protocol MapViewModelProtocol: class{
    
    func setLocationService(delegate: GeolocationServiceDelegate)
    
    var currentLocation: Location {get}
    var currentLocationDidChange: ((MapViewModelProtocol) -> ())? { get set }
    
}

class MapViewModel: MapViewModelProtocol{
        
    var currentLocation: Location {
        didSet {
            self.currentLocationDidChange?(self)
        }
    }
    var currentLocationDidChange: ((MapViewModelProtocol) -> ())?
    
    var GEOService: GeolocationService!
    
    init() {
        self.currentLocation = Location(latitude: 55.75, longitude: 37.62)
    }
    
    func setLocationService(delegate: GeolocationServiceDelegate) {
        self.GEOService = GeolocationService(delegate: delegate)
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
