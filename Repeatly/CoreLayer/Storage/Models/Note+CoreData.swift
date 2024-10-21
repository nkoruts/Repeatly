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
    @NSManaged public var repetition: Repetition
    @NSManaged public var isArchived: Bool
    
    @objc var nextRepetitionDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: repetition.nextDate)
    }
    
    func updateRepetition() throws {
        guard !repetition.isLastInterval, !repetition.dayIntervals.isEmpty else {
            isArchived = true
            repetition.currentIntervalIndex = -1
            try save()
            return
        }
        
        repetition.currentIntervalIndex += 1
        let currentInterval = repetition.dayIntervals[Int(repetition.currentIntervalIndex)]
        
        guard let nextDate = Calendar.current.date(
            byAdding: .day,
            value: Int(currentInterval),
            to: repetition.startDate) else { return }
        
        repetition.nextDate = nextDate
        try save()
    }
}
