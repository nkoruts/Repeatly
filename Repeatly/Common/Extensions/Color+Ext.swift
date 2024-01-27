//
//  Color+Ext.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

extension Color {
    init(hex: Int, opacity: Double = 1) {
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
    static var main: Color {
        Color(hex: 0x121416)
//        Color(hex: 0x282739)
    }
    
    static var secondaryColor: Color {
        Color(hex: 0x252628)
//        Color(hex: 0x47455B)
    }
    
    static var customGreen: Color {
        Color(hex: 0x60BF75)
//        Color(hex: 0x8ED8B0)
    }
}
