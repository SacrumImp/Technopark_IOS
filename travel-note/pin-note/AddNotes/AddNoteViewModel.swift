//
//  AddNoteViewModel.swift
//  pin-note
//
//  Created by Владислав Алпеев on 28.12.2020.
//

import Foundation

protocol AddNoteViewModelProtocol {
    
    var currentLocation: Location {get}
    func addNewNote(title: String, info: String, latitude: Double, longitude: Double, media: Data)
    
}

class AddNoteViewModel: AddNoteViewModelProtocol{
    
    private let dataManager = DataManager.shared
    
    var currentLocation: Location
    private var GEOService: GeolocationService!
    
    init() {
        self.currentLocation = Location(latitude: 55.75, longitude: 37.62)
        self.GEOService = GeolocationService(delegate: self)
    }
    
    func addNewNote(title: String, info: String, latitude: Double, longitude: Double, media: Data) {
        dataManager.saveNote(configBlock: { obj in
            guard let obj = obj as? Notes else {
                return
            }
            obj.title = title
            obj.info = info
            obj.latitude = latitude
            obj.longitude = longitude
            obj.media = media
        })
    }
    
}

extension AddNoteViewModel: GeolocationServiceDelegate{
    
    func didFetchCurrentLocation(_ location: Location) {
        self.currentLocation = location
        print("Location")
    }
    
    func fetchCurrentLocationFailed(error: Error) {
        return //TODO: реализовать обработку ошибки
    }
}
