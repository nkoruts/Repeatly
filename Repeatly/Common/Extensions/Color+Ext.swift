//
//  Color+Ext.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

enum ColorSystem {
    static let accent = Color("AccentColor")
    static let lightGray = Color("LightGrayColor")
    static let pink = Color("PinkColor")
    static let lightBlue = Color("LightBlueColor")
    static let yellow = Color("YellowColor")
    static let green = Color("GreenColor")
    
    static let button = Color("ButtonColor")
    static let lightButton = Color("LightButtonColor")
    static let icon = Color("IconColor")
    
    static let grayText = Color("GrayTextColor")
    static let mainText = Color("MainTextColor")
    
    static let background = Color("BackgroundColor")
    static let cardBackground = Color("CardBackgroundColor")
    static let tabbarBackground = Color("TabbarBackgroundColor")
    
    static let shadow = Color("ShadowColor")
    
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
