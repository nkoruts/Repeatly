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
    
    static let instance = StorageService()
    private init() {
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
        //        let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        //        let categories = try context.fetch(categoryFetchRequest)
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        do {
            return try storageManager.viewContext.fetch(fetchRequest)
        } catch {
            log(error)
            return []
        }
    }
    
    func updateNote(_ note: Note) {
        do {
            try storageManager.viewContext.save()
        } catch {
            storageManager.viewContext.rollback()
            log(error)
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

