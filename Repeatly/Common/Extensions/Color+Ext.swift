//
//  Color+Ext.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

struct ColorSystem {
    static let pink = Color(hex: 0xFD6686)
    static let lightBlue = Color(hex: 0x33C6F8)
    static let yellow = Color(hex: 0xFFC12C)
    static let green = Color(hex: 0x34D183)
    
    static let button = Color(hex: 0x3E69FF)
    static let lightButton = Color(hex: 0x3E69FF, opacity: 0.15)
    static let icon = Color(hex: 0xC3C8CE)
    
    static let grayText = Color(hex: 0x949DA9)
    static let mainText = Color(hex: 0x232E3F)
    
    static let background = Color(hex: 0xF5F7FA)
    static let cardBackground = Color(hex: 0xFCFCFD)
    static let tabbarBackground = Color(hex: 0xFDFDFD)
    
    static let shadow = Color(hex: 0xEEF0F4)
}

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
