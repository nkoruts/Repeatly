//
//  Font+Ext.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

extension Font {
    static func gilroyRegular(size: CGFloat) -> Font {
        return Font.custom("Gilroy-Regular", size: size)
    }
    
    static func gilroyMedium(size: CGFloat) -> Font {
        return Font.custom("Gilroy-Medium", size: size)
    }
    
    static func gilroySemiBold(size: CGFloat) -> Font {
        return Font.custom("Gilroy-SemiBold", size: size)
    }
}
