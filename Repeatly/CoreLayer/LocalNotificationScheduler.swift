//
//  NotificationSheduler.swift
//  Repeatly
//
//  Created by Nikita Koruts on 09.10.2024.
//

import Foundation
import UserNotifications

// Создаём нотификацию только для nextDate заметки
// У нас есть список [Date: [Note]]

/// Public Methods:
///     - schedule(note: Note, )
///     - removeNotification()
///     - updateNotification()
///
///

struct LocalNotificationContent {
    let title: String
    let date: Date
}

class LocalNotificationScheduler {
    static let instance = LocalNotificationScheduler()
    
    private init() {
//        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
//            scheduledDays = notifications.compactMap {
//                $0.trigger
//            }
//        }
    }
    
    private var scheduledDays: Set<Date> = []
    
    func schedule(_ notification: LocalNotificationContent) {
        let truncatedDate = Calendar.current.startOfDay(for: notification.date)

        guard !scheduledDays.contains(truncatedDate) else { return }
        scheduledDays.insert(truncatedDate)
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = notification.title
        notificationContent.sound = .default
        
        var triggerComponents = Calendar.current.dateComponents([.year, .month, .day], from: notification.date)
        triggerComponents.hour = 12
        triggerComponents.minute = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: false)
        createNotificationRequest(content: notificationContent, trigger: trigger)
    }
    
    private func createNotificationRequest(content: UNNotificationContent, trigger: UNNotificationTrigger) {
        let request = UNNotificationRequest(identifier: "reminderNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
}
