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
    var isSelected: Bool = false
    var action: Action
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.gilroyRegular(size: 14))
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(isSelected ? color : color.opacity(0.5))
                )
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(
            title: "Programming",
            color: ColorSystem.blueButton,
            isSelected: true) {
                print("selected")
        }
    }
}
