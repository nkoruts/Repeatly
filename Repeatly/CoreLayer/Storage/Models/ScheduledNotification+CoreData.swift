//
//  ScheduledNotifications+CoreData.swift
//  Repeatly
//
//  Created by Nikita Koruts on 11.10.2024.
//

//
//  ScheduledNotification+CoreData.swift
//  Repeatly
//
//  Created by Nikita Koruts on 01.02.2024.
//

import Foundation
import CoreData

@objc(ScheduledNotification)
public class ScheduledNotification: NSManagedObject, Identifiable, Model {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ScheduledNotification> {
        return NSFetchRequest<ScheduledNotification>(entityName: "ScheduledNotification")
    }
    
    @NSManaged public var notificationId: String
    @NSManaged public var noteIds: [String]
}
