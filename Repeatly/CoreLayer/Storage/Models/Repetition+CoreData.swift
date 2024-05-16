//
//  Repetition+CoreData.swift
//  Repeatly
//
//  Created by Nikita Koruts on 01.02.2024.
//

import Foundation
import CoreData

@objc(Repetition)
public class Repetition: NSManagedObject, Identifiable, Model {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Repetition> {
        return NSFetchRequest<Repetition>(entityName: "Repetition")
    }
    
    @NSManaged public var nextDate: Date
    @NSManaged public var allDates: [Date]
}
