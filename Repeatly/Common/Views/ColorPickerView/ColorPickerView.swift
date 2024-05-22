//
//  ColorPickerView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 21.05.2024.
//

import SwiftUI

struct ColorPickerView: View {
    
    let colors: [Color]
    @Binding var selectedColor: Color?
    
    private let columns: [GridItem] = [.init(.adaptive(minimum: 40))]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(colors, id: \.self) { color in
                ColorPickerButtonView(
                    color: color,
                    isSelected: Binding(
                        get: { self.selectedColor == color },
                        set: { _ in self.selectedColor = color }
                    ))
            }
        }
    }
}
