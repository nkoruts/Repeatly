//
//  StorageManager.swift
//  Repeatly
//
//  Created by Nikita Koruts on 01.02.2024.
//

import Foundation
import SwiftUI
import CoreData

class StorageManager: ObservableObject {
    private let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    init() {
        container = NSPersistentContainer(name: "Repeatly")
        container.loadPersistentStores { _, error in
            if let error {
                log(error)
            }
        }
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            log(error)
        }
    }
    
    func delete(_ object: NSManagedObject) {
        viewContext.delete(object)
        
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            log(error)
        }
    }
}

