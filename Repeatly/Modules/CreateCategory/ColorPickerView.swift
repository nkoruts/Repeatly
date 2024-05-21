//
//  ColorPickerView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 21.05.2024.
//

import SwiftUI

struct ColorPickerView: View {
    
    let colors: [Color]
    private let columns: [GridItem] = [.init(.adaptive(minimum: 40))]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(colors, id: \.self) { color in
                color
                    .frame(width: 40, height: 40)
                    .cornerRadius(DesignSystem.smallCornerRadius)
            }
        }
    }
}
