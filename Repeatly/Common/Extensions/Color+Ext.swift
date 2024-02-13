//
//  Color+Ext.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

enum ColorSystem: String {
    case accent = "AccentColor"
    case lightGray = "LightGrayColor"
    case pink = "PinkColor"
    case lightBlue = "LightBlueColor"
    case yellow = "YellowColor"
    case green = "GreenColor"
    
    case button = "ButtonColor"
    case lightButton = "LightButtonColor"
    case icon = "IconColor"
    
    case grayText = "GrayTextColor"
    case mainText = "MainTextColor"
    
    case background = "BackgroundColor"
    case cardBackground = "CardBackgroundColor"
    case tabbarBackground = "TabbarBackgroundColor"
    case shadow = "ShadowColor"
    
    var color: Color {
        return Color(self.rawValue)
    }
    
    //        static let background = Color("BackgroundColor")
    //        static let text = Color("TextColor")
    //        static let lightBackground = Color("LightBackgroundColor")
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
