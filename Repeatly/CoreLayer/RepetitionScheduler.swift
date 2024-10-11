//
//  NotificationSheduler.swift
//  Repeatly
//
//  Created by Nikita Koruts on 09.10.2024.
//

import Foundation
import CoreData

class RepetitionScheduler {
    static let instance = RepetitionScheduler()
    
    private let context: NSManagedObjectContext
    private var scheduledNotifications: [ScheduledNotification] = []
    
    private init() {
        self.context = CoreDataProvider.shared.viewContext
        fetchScheduledNotifications()
    }
    
    // MARK: - Public Methods
    func schedule(noteId: String, repetitionDate: Date) {
        let identifier = transformDateToIdentifier(repetitionDate)
        
        if scheduledNotifications.filter({ $0.notificationId == identifier }).isEmpty  {
            NotificationService().createNotification(withIdentifier: identifier, date: repetitionDate)
        }
        createScheduledNotification(withIdentifier: identifier, noteId: noteId)
    }
    
    func update(noteId: String, repetitionDate: Date) {
        guard let scheduledNotification = scheduledNotifications.first(where: { $0.noteId == noteId }) else { return }
        
        if scheduledNotifications.filter({ $0.notificationId == scheduledNotification.notificationId }).count <= 1 {
            NotificationService().removeNotification(withIdentifier: scheduledNotification.notificationId)
        }
        
        let identifier = transformDateToIdentifier(repetitionDate)
        if scheduledNotifications.filter({ $0.notificationId == identifier }).isEmpty {
            NotificationService().createNotification(withIdentifier: identifier, date: repetitionDate)
        }
        
        scheduledNotification.notificationId = identifier
        saveScheduledNotification(scheduledNotification)
    }

    func remove(noteId: String) {
        guard let scheduledNotification = scheduledNotifications.first(where: { $0.noteId == noteId }) else { return }
        
        if scheduledNotifications.filter({ $0.notificationId == scheduledNotification.notificationId }).count <= 1 {
            NotificationService().removeNotification(withIdentifier: scheduledNotification.notificationId)
        }
        
        deleteScheduledNotification(scheduledNotification)
    }
    
    // MARK: - Private Methods
    private func createScheduledNotification(withIdentifier identifier: String, noteId: String) {
        let scheduledNotification = ScheduledNotification(context: context)
        scheduledNotification.notificationId = identifier
        scheduledNotification.noteId = noteId
        
        saveScheduledNotification(scheduledNotification)
    }
    
    private func saveScheduledNotification(_ scheduledNotification: ScheduledNotification) {
        do {
            try scheduledNotification.save()
            fetchScheduledNotifications()
        } catch {
            log(error)
        }
    }
    
    private func deleteScheduledNotification(_ scheduledNotification: ScheduledNotification) {
        do {
            try scheduledNotification.delete()
            fetchScheduledNotifications()
        } catch {
            log(error)
        }
    }

    private func fetchScheduledNotifications() {
        let fetchRequest: NSFetchRequest<ScheduledNotification> = ScheduledNotification.fetchRequest()

        do {
            self.scheduledNotifications = try context.fetch(fetchRequest)
        } catch {
            log(error)
        }
    }
    
    private func transformDateToIdentifier(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}
