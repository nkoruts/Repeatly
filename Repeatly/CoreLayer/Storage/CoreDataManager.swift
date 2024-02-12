//
//  StorageManager.swift
//  Repeatly
//
//  Created by Nikita Koruts on 01.02.2024.
//

import Foundation
import SwiftUI
import CoreData

class StorageService: ObservableObject {
    private let storageManager: CoreDataManager
    
    static let instance = StorageService()
    private init() {
        self.storageManager = CoreDataManager()
    }
    
    func saveNote(title: String, details: String, colorName: String, categoryId: UUID?, repetition: RepetitionListModel?) {
        let newNote = Note(context: storageManager.viewContext)
        newNote.id = UUID()
        newNote.title = title
        newNote.details = !details.isEmpty ? details : nil
        newNote.color = colorName
        newNote.categoryId = categoryId
//        newNote.repetition = repetition
        
        // TODO: - Save async
        storageManager.save()
    }
    
    func getNotes() -> [Note] {
//        let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
//        let categories = try context.fetch(categoryFetchRequest)
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        do {
            return try storageManager.viewContext.fetch(fetchRequest)
        } catch {
            print("=== DEBUG: Failed to fetch notes: \(error)")
            return []
        }
    }
    
    func updateNote(_ note: Note) {
        do {
          try storageManager.viewContext.save()
        } catch {
          storageManager.viewContext.rollback()
          print("Failed to save context: \(error)")
        }
    }
    
    func deleteNote(_ note: Note) {
        storageManager.delete(note)
    }
}

private class CoreDataManager: ObservableObject {
    private let container: NSPersistentContainer
    let viewContext: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "Repeatly")
        self.viewContext = container.viewContext
        container.loadPersistentStores { _, error in
            if let error {
                print("=== Error: \(error.localizedDescription)")
            }
        }
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print("=== DEBUG: Failed to save note: \(error)")
        }
    }
    
    func delete(_ object: NSManagedObject) {
        viewContext.delete(object)
        
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print("Failed to save context: \(error)")
        }
    }
}

