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
        newNote.details = details
        newNote.color = colorName
        newNote.categoryId = categoryId
        newNote.repetition = repetition
        
        do {
            try storageManager.viewContext.save()
        } catch {
            storageManager.viewContext.rollback()
            print("=== DEBUG: Failed to save note: \(error)")
        }
    }
    
    func getNotes() -> [Note] {
        let context = storageManager.viewContext
        let repetitionDate = Date()
        
        let note1 = Note(context: context)
        note1.id = UUID()
        note1.title = "note1"
        note1.details = nil
        note1.color = "AccentColor"
        note1.categoryId = nil
        note1.repetition = RepetitionListModel(context: context)
        note1.repetition?.nextRepetition.id = UUID()
        note1.repetition?.nextRepetition.date = repetitionDate
        note1.repetition?.repetitions = []
        
        let note2 = Note(context: context)
        note1.id = UUID()
        note1.title = "note2"
        note1.details = "details"
        note1.color = "AccentColor"
        note1.categoryId = nil
        note1.repetition = RepetitionListModel(context: context)
        note1.repetition?.nextRepetition.id = UUID()
        note1.repetition?.nextRepetition.date = repetitionDate
        note1.repetition?.repetitions = []
        
        return [note1, note2]
        
        //        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        //
        //        do {
        //            try storageManager.viewContext.fetch(fetchRequest)
        //        } catch {
        //            print("=== DEBUG: Failed to fetch notes: \(error)")
        //            return []
        //        }
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
        storageManager.viewContext.delete(note)
        
        do {
            try storageManager.viewContext.save()
        } catch {
            storageManager.viewContext.rollback()
            print("Failed to save context: \(error)")
        }
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
}

