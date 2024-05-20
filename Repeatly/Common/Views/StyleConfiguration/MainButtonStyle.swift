//
//  MainButtonStyle.swift
//  Repeatly
//
//  Created by Nikita Koruts on 05.02.2024.
//

import SwiftUI

struct MainButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Self.Configuration)
    -> some View {
        configuration.label
            .font(FontBook.medium)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: 45)
            .background(isEnabled ? .button : .lightButton)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: DesignSystem.cornerRadius,
                    style: .continuous)
            )
    }
}
