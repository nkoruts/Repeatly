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
            .font(Constants.noteFieldFont)
            .padding(Constants.noteFieldPadding)
            .overlay(
                RoundedRectangle(
                    cornerRadius: Constants.noteFieldCornerRadius,
                    style: .continuous)
                .stroke(Color.lightGray)
            )
    }
}

// MARK: - Constants
extension BorderedTextFieldStyle {
    private enum Constants {
        static let noteFieldFont: Font = .gilroyRegular(size: 16)
        static let noteFieldPadding: CGFloat = 12
        static let noteFieldCornerRadius: CGFloat = 16
    }
}
