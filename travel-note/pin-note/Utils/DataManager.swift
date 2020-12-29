//
//  AddNoteModel.swift
//  pin-note
//
//  Created by Владислав Алпеев on 28.12.2020.
//

import Foundation
import CoreData

class DataManager {
    
    private let container: NSPersistentContainer
    
    static let shared = DataManager()
    
    var mainQueueContext: NSManagedObjectContext {
        container.viewContext
    }
    
    private init(){
        self.container = NSPersistentContainer(name: "PinNoteModel")
        initializeStack()
    }
    
    private func initializeStack(){
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func saveNote<T: NSManagedObject>(configBlock: ((T) -> Void)?) {
        container.performBackgroundTask { (localContext) in
            guard let obj = NSEntityDescription.insertNewObject(forEntityName: "Notes",
                                                                into: localContext) as? T else {
                return
            }
            configBlock?(obj)
            do {
                try localContext.save()
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func loadNotes() -> [Notes]{
        let fetchRequest: NSFetchRequest<Notes> = NSFetchRequest(entityName: "Notes")
        return (try? container.viewContext.fetch(fetchRequest)) ?? []
    }
    
}
