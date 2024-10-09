//
//  AppDelegate.swift
//  Repeatly
//
//  Created by Nikita Koruts on 09.10.2024.
//

import UIKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            print(granted ? "Notification authorization granted" : "Notification authorization denied")
        }
        return true
    }
}
