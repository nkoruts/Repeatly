//
//  RepetitionModel+CoreData.swift
//  Repeatly
//
//  Created by Nikita Koruts on 01.02.2024.
//

import Foundation
import CoreData

@objc(RepetitionModel)
public class RepetitionModel: NSManagedObject, Identifiable {

    // TODO: - Delete if needed
    @nonobjc public class func fetchRequest() -> NSFetchRequest<RepetitionModel> {
        return NSFetchRequest<RepetitionModel>(entityName: "RepetitionModel")
    }

    @NSManaged public var nextRepetition: Date
    @NSManaged public var repetitions: [Date]?
}
