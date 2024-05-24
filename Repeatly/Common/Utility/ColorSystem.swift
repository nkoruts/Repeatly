//
//  ColorSystem.swift
//  Repeatly
//
//  Created by Nikita Koruts on 18.02.2024.
//

import SwiftUI

enum ColorSystem: Int32 {
    case lightGray = 0xD3D3D3
    case pink = 0xFD6686
    case lightBlue = 0x33C6F8
    case yellow = 0xFFC12C
    case green = 0x34D183
    
    case button = 0x3E69FF
    case lightButton = 0xDBE2FB
    case icon = 0xC3C8CE
    
    case grayText = 0x949DA9
    case mainText = 0x232E3F
    
    case background = 0xF5F7FA
    case cardBackground = 0xFCFCFD
    case shadow = 0xEEF0F4
    case focus = 0xF0F2F4
    
    var hex: Int32 {
        self.rawValue
    }
    
    var color: Color {
        Color(hex: self.rawValue)
    }
}

// MARK: - Extensions
extension View {
  func foregroundColor(_ color: ColorSystem) -> some View {
      self.foregroundColor(Color(hex: color.hex))
  }
    
  func background(_ color: ColorSystem) -> some View {
      self.background(Color(hex: color.hex))
  }
}

extension Shape {
  func fill(_ color: ColorSystem) -> some View {
      self.fill(Color(hex: color.hex))
  }
    
  func stroke(_ color: ColorSystem) -> some View {
      self.stroke(Color(hex: color.hex))
  }
}
