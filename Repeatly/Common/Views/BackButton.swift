//
//  BackButtonStyle.swift
//  Repeatly
//
//  Created by Nikita Koruts on 31.01.2024.
//

import SwiftUI

struct BackButton: View {
    var action: Action
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "arrow.backward")
                .foregroundColor(.button)
                .frame(width: 30, height: 30)
                .background(
                    RoundedRectangle(cornerRadius: DesignSystem.smallCornerRadius)
                    .fill(.lightButton)
                )
        }
    }
}
