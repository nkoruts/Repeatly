//
//  ColorPickerView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 21.05.2024.
//

import SwiftUI

struct ColorPickerView: View {
    
//    let colorsHex: [Int32]
    @Binding var selectedColorHex: Int32?
    
    private let columns: [GridItem] = [.init(.adaptive(minimum: 40))]
    private let colorsHex: [Int32] = [
        0xC62828,
        0xF79F36,
        0x3D51B2,
        0x673AB7,
        0x2196F3
        
        //        0x00BCD4,
        //        0x4CAF50,
        //        0xF44336,
        //        0xE91E63
                
        //        0x7C4DFF,
        //        0x03DAC5,
        //        0xFFA726,
        //        0x9C27B0,
        //        0x673AB7
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
