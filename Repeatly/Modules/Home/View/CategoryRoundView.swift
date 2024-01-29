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
            .font(.gilroyRegular(size: 14))
            .lineLimit(1)
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background(
                //                RoundedRectangle(cornerRadius: 8)
                Capsule()
                    .fill(color)
            )
    }
}
