//
//  ColorSystem.swift
//  Repeatly
//
//  Created by Nikita Koruts on 18.02.2024.
//

import SwiftUI

enum ColorSystem: String {
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
    case shadow = "ShadowColor"
    case focus = "FocusColor"
    
    var color: Color {
        return Color(self.rawValue)
    }
}
