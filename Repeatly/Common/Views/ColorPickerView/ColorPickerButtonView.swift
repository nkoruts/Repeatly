//
//  ColorPickerButtonView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 22.05.2024.
//

import SwiftUI

struct ColorPickerButtonView: View {

    let color: Color
    @Binding var isSelected: Bool
    
    var body: some View {
        Button(action: tapAction) {
            color
                .frame(width: 40, height: 40)
                .cornerRadius(10)
        }
        .buttonStyle(.plain)
        .overlay {
            Image(systemName: "checkmark")
                .foregroundColor(.white)
                .font(.system(size: 18, weight: .semibold))
                .isHidden(!isSelected)
        }
    }
    
    func tapAction() {
        isSelected.toggle()
    }
}
