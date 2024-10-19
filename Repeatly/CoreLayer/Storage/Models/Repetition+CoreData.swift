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
    
    @NSManaged public var startDate: Date
    @NSManaged public var nextDate: Date
    @NSManaged public var currentIntervalIndex: Int16
    @NSManaged public var dayIntervals: [Int16]
    
    public var isLastInterval: Bool {
        currentIntervalIndex + 1 == dayIntervals.count
    }
}
