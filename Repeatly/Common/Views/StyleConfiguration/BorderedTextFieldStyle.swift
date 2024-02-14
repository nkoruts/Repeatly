//
//  BorderedTextFieldStyle.swift
//  Repeatly
//
//  Created by Nikita Koruts on 10.02.2024.
//

import SwiftUI

struct BorderedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(FontBook.regular3)
            .foregroundColor(ColorSystem.mainText.color)
            .padding(Constants.noteFieldPadding)
            .overlay(
                RoundedRectangle(
                    cornerRadius: Constants.noteFieldCornerRadius,
                    style: .continuous)
                .stroke(ColorSystem.lightGray.color)
            )
    }
}

// MARK: - Constants
extension BorderedTextFieldStyle {
    private enum Constants {
        static let noteFieldPadding: CGFloat = 12
        static let noteFieldCornerRadius: CGFloat = 16
    }
}
