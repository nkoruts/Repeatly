//
//  Note+CoreDataProperties.swift
//  Repeatly
//
//  Created by Nikita Koruts on 01.02.2024.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject, Identifiable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var details: String?
    @NSManaged public var color: String
    @NSManaged public var categoryId: UUID?
    
    // TODO: Add repetition logic
    @NSManaged public var repetition: RepetitionListModel?
}
