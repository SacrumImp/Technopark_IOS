//
//  ListNotesViewModel.swift
//  pin-note
//
//  Created by Владислав Алпеев on 28.12.2020.
//

import Foundation

protocol ListNotesViewModelProtocol {
    func getNotes() -> [Notes]
    func getCountOfNotes() -> Int
}

class ListNotesViewModel: ListNotesViewModelProtocol {
    
    private let dataManager: DataManager
    
    private var dataSource: [Notes]
    
    init(){
        dataSource = [Notes]()
        dataManager = DataManager.shared
    }
    
    func getNotes() -> [Notes] {
        refreshData()
        return dataSource
    }
    
    func getCountOfNotes() -> Int {
        refreshData()
        return dataSource.count
    }
    
    private func refreshData(){
        dataSource = dataManager.loadNotes()
    }
}

