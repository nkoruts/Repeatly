//
//  Color+Ext.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

extension Color {
    init(hex: Int32, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}

extension Color {
    static var text = Color("TextColor")
    static var background = Color("BackgroundColor")
    static var lightBackground = Color("LightBackgroundColor")
    static var accent = Color("AccentColor")
    static var lightGray = Color("LightGrayColor")
}
