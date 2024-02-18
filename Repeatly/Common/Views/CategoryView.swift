//
//  CategoryView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 02.02.2024.
//

import SwiftUI

struct CategoryView: View {
    var title: String
    var color: Color
    @Binding var isSelected: Bool
    
    var body: some View {
        Button(action: {
            self.isSelected.toggle()
        }, label: {
            Text(title)
                .font(FontBook.medium3)
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(
                        cornerRadius: DesignSystem.cornerRadius,
                        style: .continuous)
                    .fill(isSelected ? color : color.opacity(0.5))
                )
        })
        .buttonStyle(PlainButtonStyle())
    }
}
