//
//  CategoryRoundView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 29.01.2024.
//

import SwiftUI

struct CategoryRoundView: View {
    let title: String
    let color: Color
    
    var body: some View {
        Text(title)
            .font(.gilroyMedium(size: 12))
            .lineLimit(1)
            .foregroundColor(color)
            .padding(.horizontal, 12)
            .padding(.vertical, 3)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(color.opacity(0.2))
            )
    }
}
