//
//  NoteCategoryView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 29.01.2024.
//

import SwiftUI

struct NoteCategoryView: View {
    let title: String
    let color: Color
    
    var body: some View {
        Text(title)
            .font(FontBook.regular4)
            .foregroundColor(color)
            .padding(.horizontal, Constants.hPadding)
            .padding(.vertical, Constants.vPadding)
            .background(
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(color.opacity(Constants.backgroundColorOpacity)))
    }
}

extension NoteCategoryView {
    private enum Constants {
        static let cornerRadius: CGFloat = 10
        static let shadowRadius: CGFloat = 8
        
        static let hPadding: CGFloat = 12
        static let vPadding: CGFloat = 4
        
        static let backgroundColorOpacity: CGFloat = 0.2
    }
}
