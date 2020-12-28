//
//  AddNoteViewModel.swift
//  pin-note
//
//  Created by Владислав Алпеев on 28.12.2020.
//

import Foundation

protocol AddNoteViewModelProtocol {
    func addNewNote(title: String, info: String, latitude: Int64, longitude: Int64, media: NSData)
}

class AddNoteViewModel: AddNoteViewModelProtocol{
    
    private let dataManager = DataManager.shared
    
    func addNewNote(title: String, info: String, latitude: Int64, longitude: Int64, media: NSData) {
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
