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

    @NSManaged public var title: String?
    @NSManaged public var latitude: Int64
    @NSManaged public var longitude: Int64
    @NSManaged public var info: String?
    @NSManaged public var media: Data?

}

extension Notes : Identifiable {

}
