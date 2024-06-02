//
//  Note+CoreDataProperties.swift
//  Repeatly
//
//  Created by Nikita Koruts on 01.02.2024.
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject, Identifiable, Model {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var details: String?
    @NSManaged public var category: Category?
    @NSManaged public var repetition: Repetition?
    
    @objc var nextRepetitionDate: String? {
        guard let repetition = repetition else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: repetition.nextDate)
    }
    
    func updateRepetition() throws {
        guard let repetition = repetition else { return }
        let allDates = repetition.allDates
        guard let nextDateIndex = allDates.firstIndex(of: repetition.nextDate) else { return }
        
        if nextDateIndex < allDates.count - 1 {
            repetition.nextDate = allDates[nextDateIndex + 1]
        } else {
            self.repetition = nil
        }
        try save()
    }
}
