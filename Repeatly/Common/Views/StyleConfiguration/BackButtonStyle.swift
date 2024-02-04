//
//  BackButtonStyle.swift
//  Repeatly
//
//  Created by Nikita Koruts on 31.01.2024.
//

import SwiftUI

struct BackButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration)
    -> some View {
        configuration.label
            .background(
                Image(systemName: "arrow.backward")
                    .foregroundColor(ColorSystem.button)
                    .frame(width: 40, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(ColorSystem.lightButton)
                    )
            )
    }
}

struct MainButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration)
    -> some View {
        configuration.label
            .font(.gilroyMedium(size: 20))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: 45)
            .background(ColorSystem.button)
            .clipShape(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
            )
    }
}
