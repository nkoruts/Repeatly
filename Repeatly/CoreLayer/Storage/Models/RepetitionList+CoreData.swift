//
//  RepetitionModel+CoreData.swift
//  Repeatly
//
//  Created by Nikita Koruts on 01.02.2024.
//

import Foundation
import CoreData

@objc(RepetitionModel)
public class RepetitionListModel: NSManagedObject, Identifiable {

    // TODO: - Delete if needed
    @nonobjc public class func fetchRequest() -> NSFetchRequest<RepetitionListModel> {
        return NSFetchRequest<RepetitionListModel>(entityName: "RepetitionListModel")
    }

    @NSManaged public var nextRepetition: RepetitionModel
    @NSManaged public var repetitions: [RepetitionModel]
}

@objc(RepetitionModel)
public class RepetitionModel: NSManagedObject, Identifiable {
    
    // TODO: - Delete if needed
    @nonobjc public class func fetchRequest() -> NSFetchRequest<RepetitionModel> {
        return NSFetchRequest<RepetitionModel>(entityName: "RepetitionModel")
    }

    @NSManaged public var id: UUID
    @NSManaged public var date: Date
}
