//
//  StorageManager.swift
//  Repeatly
//
//  Created by Nikita Koruts on 01.02.2024.
//

import Foundation
import CoreData

class StorageManager: ObservableObject {
    let container = NSPersistentContainer(name: "Repeatly")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error {
                print("=== Error: \(error.localizedDescription)")
            }
        }
    }
}

