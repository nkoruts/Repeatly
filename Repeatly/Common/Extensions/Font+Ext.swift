//
//  Font+Ext.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

struct FontBook {
    /// Gilroy-SemiBold, size: 32
    static let semibold: Font = .gilroySemiBold(size: 32)
    /// Gilroy-SemiBold, size: 24
    static let semibold2: Font = .gilroySemiBold(size: 24)
    
    /// Gilroy-Medium, size: 26
    static let medium: Font = .gilroyMedium(size: 26)
    /// Gilroy-Medium, size: 20
    static let medium2: Font = .gilroyMedium(size: 20)
    /// Gilroy-Medium, size: 18
    static let medium3: Font = .gilroyMedium(size: 18)
    /// Gilroy-Medium, size: 14
    static let medium4: Font = .gilroyMedium(size: 14)
    /// Gilroy-Medium, size: 12
    static let medium5: Font = .gilroyMedium(size: 12)
    
    /// Gilroy-Regular, size: 24
    static let regular: Font = .gilroyRegular(size: 24)
    /// Gilroy-Regular, size: 21
    static let regular2: Font = .gilroyRegular(size: 21)
    /// Gilroy-Regular, size: 16
    static let regular3: Font = .gilroyRegular(size: 16)
    /// Gilroy-Regular, size: 14
    static let regular4: Font = .gilroyRegular(size: 14)
    
    /// semibold 24
}

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
    
    static func gilroyBold(size: CGFloat) -> Font {
        return Font.custom("Gilroy-Bold", size: size)
    }
}
