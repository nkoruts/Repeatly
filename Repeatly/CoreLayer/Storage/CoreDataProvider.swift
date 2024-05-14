//
//  StorageManager.swift
//  Repeatly
//
//  Created by Nikita Koruts on 01.02.2024.
//

import Foundation
import SwiftUI
import CoreData

class CoreDataProvider: ObservableObject {
    static let shared = CoreDataProvider()
    private let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Repeatly")
        persistentContainer.loadPersistentStores { _, error in
            if let error {
                log(error)
            }
        }
    }
}

