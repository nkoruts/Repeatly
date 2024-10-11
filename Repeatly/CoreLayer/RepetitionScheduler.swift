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
        
        if let scheduledNotification = scheduledNotifications.first(where: { $0.notificationId == identifier }) {
            scheduledNotification.noteIds.append(noteId)
            updateScheduledNotification(scheduledNotification)
        } else {
            createScheduledNotification(withIdentifier: identifier, noteId: noteId)
            NotificationService().createNotification(withIdentifier: identifier, date: repetitionDate)
        }
    }
    
    func update(noteId: String) {
        
    }

    func remove(noteId: String, lastRepetitionDate: Date) {
        let identifier = transformDateToIdentifier(lastRepetitionDate)
        
        guard let scheduledNotification = scheduledNotifications.first(where: { $0.notificationId == identifier }) else { return }
        scheduledNotification.noteIds.removeAll(where: { $0 == noteId })
        
        if scheduledNotification.noteIds.isEmpty {
            NotificationService().removeNotification(withIdentifier: identifier)
        }
        
        updateScheduledNotification(scheduledNotification)
    }
    
    // MARK: - Private Methods
    private func createScheduledNotification(withIdentifier identifier: String, noteId: String) {
        let scheduledNotification = ScheduledNotification(context: context)
        scheduledNotification.notificationId = identifier
        scheduledNotification.noteIds = [noteId]
        
        updateScheduledNotification(scheduledNotification)
    }
    
    private func updateScheduledNotification(_ scheduledNotification: ScheduledNotification) {
        do {
            try scheduledNotification.save()
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
