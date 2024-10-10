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
        defer {
            do { try save() }
            catch { log(error) }
        }
        
        guard repetition.dayIntervals.count > 0 else {
            self.isArchived = true
            return
        }
        
        guard let firstInterval = repetition.dayIntervals.first,
              let nextDate = Calendar.current.date(byAdding: .day, value: Int(firstInterval), to: Date())
        else { return }
        repetition.nextDate = nextDate
    }
}
