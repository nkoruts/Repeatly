//
//  RepeatlyApp.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

@main
struct RepeatlyApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            HomeScreenView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
        }
    }
}
