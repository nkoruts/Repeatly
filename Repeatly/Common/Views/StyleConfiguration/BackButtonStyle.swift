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
                    .foregroundColor(ColorSystem.blueButton)
                    .frame(width: 40, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(ColorSystem.blueButton.opacity(0.15))
                    )
            )
    }
}
