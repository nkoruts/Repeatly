//
//  ColorPickerView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 21.05.2024.
//

import SwiftUI

struct ColorPickerView: View {
    
    @Binding var selectedColorHex: Int32?
    
    private let columns: [GridItem] = [.init(.adaptive(minimum: 40))]
    private let colorsHex: [Int32] = [
        0xC62828,
        0xE91E63,
        0xFF5722,
        0xFFA726,
        0x2196F3,
        0x00BFA5,
        0x03DAC5,
        0x388E3C,
        0x673AB7,
        0xAB47BC,
        0xFFEB3B,
        0x3D51B2,
        0xFA9BBB,
        0x795548,
        0x607D8B,
        0xE1BEE7
    ]
    
    // MARK: - UI
    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(colorsHex, id: \.self) { hex in
                ColorPickerButtonView(
                    color: Color(hex: hex),
                    isSelected: Binding(
                        get: { self.selectedColorHex == hex },
                        set: { _ in self.selectedColorHex = hex }
                    ))
            }
        }
    }
}

#Preview {
    ColorPickerView(selectedColorHex: Binding(get: { 0xC62828 }, set: { _ in }))
}
