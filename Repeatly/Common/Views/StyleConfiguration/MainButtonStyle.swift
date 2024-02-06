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
            .font(.gilroyMedium(size: 20))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: 45)
            .background(isEnabled ? ColorSystem.button : ColorSystem.lightButton)
            .clipShape(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
            )
    }
}
