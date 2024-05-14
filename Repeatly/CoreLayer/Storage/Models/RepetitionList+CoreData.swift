//
//  RepetitionModel+CoreData.swift
//  Repeatly
//
//  Created by Nikita Koruts on 01.02.2024.
//

import Foundation
import CoreData

@objc(RepetitionListModel)
public class RepetitionListModel: NSManagedObject, Identifiable, Model {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RepetitionListModel> {
        return NSFetchRequest<RepetitionListModel>(entityName: "RepetitionListModel")
    }

    @NSManaged public var nextRepetition: Repetition
    @NSManaged public var repetitions: [Repetition]
}

@objc(Repetition)
public class Repetition: NSManagedObject, Identifiable, Model {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Repetition> {
        return NSFetchRequest<Repetition>(entityName: "Repetition")
    }

    @NSManaged public var id: UUID
    @NSManaged public var date: Date
}
