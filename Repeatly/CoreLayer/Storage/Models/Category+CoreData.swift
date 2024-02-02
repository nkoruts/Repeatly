//
//  Category+CoreDataProperties.swift
//  Repeatly
//
//  Created by Nikita Koruts on 01.02.2024.
//
//

import Foundation
import CoreData

//@objc(Category)
//public class Category: NSManagedObject, Identifiable {
//
//    // TODO: - Remove mock init
//    convenience init(color: Int32, name: String) {
//        super.init()
//        self.color = color
//        self.name = name
//    }
//
//    // TODO: - Delete if needed
//    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
//        return NSFetchRequest<Category>(entityName: "Category")
//    }
//
//    @NSManaged public var color: Int32
//    @NSManaged public var name: String?
//}

public class Category: Identifiable {
    
    // TODO: - Remove mock init
    init(color: Int32, name: String) {
        self.color = color
        self.name = name
    }

    public var color: Int32
    public var name: String
}
