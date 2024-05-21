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
                    .foregroundColor(.button)
                    .frame(width: 30, height: 30)
                    .background(
                        RoundedRectangle(
                            cornerRadius: DesignSystem.smallCornerRadius,
                            style: .continuous)
                        .fill(.lightButton)
                    )
            )
    }
}
