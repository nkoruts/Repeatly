//
//  Category+CoreDataProperties.swift
//  Repeatly
//
//  Created by Nikita Koruts on 01.02.2024.
//
//

import Foundation
import CoreData

@objc(Category)
public class Category: NSManagedObject, Identifiable, Model {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var colorHex: Int32
}
