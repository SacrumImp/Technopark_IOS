//
//  Notes+CoreDataProperties.swift
//  pin-note
//
//  Created by Владислав Алпеев on 28.12.2020.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var info: String
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var media: Data
    @NSManaged public var title: String

}

extension Notes : Identifiable {

}
