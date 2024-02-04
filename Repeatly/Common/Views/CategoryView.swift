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
                .font(.gilroyMedium(size: 14))
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(isSelected ? color : color.opacity(0.5))
                )
        })
        .buttonStyle(PlainButtonStyle()) 
    }
}
