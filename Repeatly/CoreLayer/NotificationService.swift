//
//  NotificationService.swift
//  Repeatly
//
//  Created by Nikita Koruts on 11.10.2024.
//

import Foundation
import UserNotifications

class NotificationService {
    func createNotification(withIdentifier identifier: String, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Repeat your knowledge"
        content.sound = .default
        
        var triggerComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        triggerComponents.hour = 12
        triggerComponents.minute = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully")
            }
        }
    }
    
    func removeNotification(withIdentifier identifier: String) {
        UNUserNotificationCenter
            .current()
            .removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}
