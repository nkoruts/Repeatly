//
//  MainView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 29.01.2024.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            HomeScreenView()
                .tabItem {
                    Label("Tasks", systemImage: "list.dash")
                }
            
            SettingsScreenView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}
