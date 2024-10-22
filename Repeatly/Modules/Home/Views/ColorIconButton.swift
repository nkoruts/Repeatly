//
//  ColorIconButton.swift
//  Repeatly
//
//  Created by Nikita Koruts on 03.06.2024.
//

import SwiftUI

struct ColorIconButton: View {
    let iconName: String
    let color: Color
    let action: Action
    
    var body: some View {
        Button(action: action) {
            Circle()
                .fill(color.opacity(0.15))
                .frame(width: 40, height: 40)
                .overlay {
                    Image(systemName: iconName)
                        .font(.system(size: 16))
                        .foregroundColor(color)
                }
                .background {
                    Circle()
                        .strokeBorder(color, lineWidth: 0.5)
                }

        }
    }
}
