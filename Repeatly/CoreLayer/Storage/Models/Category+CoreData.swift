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
public class Category: NSManagedObject, Identifiable {

    // TODO: - Delete if needed
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var color: Int32
    @NSManaged public var name: String?
}
