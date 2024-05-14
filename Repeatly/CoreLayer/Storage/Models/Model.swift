//
//  Model.swift
//  Repeatly
//
//  Created by Nikita Koruts on 14.05.2024.
//

import CoreData

protocol Model {
    func save() throws
    func delete() throws
}

extension Model where Self: NSManagedObject {
    
    func save() throws {
        try CoreDataProvider.shared.viewContext.save()
    }
    
    func delete() throws {
        CoreDataProvider.shared.viewContext.delete(self)
        try save()
    }
    
    static var all: NSFetchRequest<Self> {
        let request = NSFetchRequest<Self>(entityName: String(describing: self))
        request.sortDescriptors = []
        return request
    }
}
