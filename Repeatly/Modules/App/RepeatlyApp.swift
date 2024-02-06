//
//  RepeatlyApp.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

@main
struct RepeatlyApp: App {
    @StateObject private var storageService = StorageService()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(storageService)
        }
    }
}
