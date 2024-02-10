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
    private let storageManager: StorageManager
    
    init() {
        self.storageManager = StorageManager()
        
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

class StorageManager: ObservableObject {
    private let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    init() {
        container = NSPersistentContainer(name: "Repeatly")
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

