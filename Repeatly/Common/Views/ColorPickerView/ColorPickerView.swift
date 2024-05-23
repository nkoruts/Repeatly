//
//  ColorPickerView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 21.05.2024.
//

import SwiftUI

struct ColorPickerView: View {
    
    let colorsHex: [Int32]
    @Binding var selectedColorHex: Int32?
    
    private let columns: [GridItem] = [.init(.adaptive(minimum: 40))]
    
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
