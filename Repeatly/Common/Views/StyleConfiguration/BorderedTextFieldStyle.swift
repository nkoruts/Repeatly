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
            .foregroundColor(.mainText)
            .disableAutocorrection(true)
            .padding(Constants.padding)
            .overlay(
                RoundedRectangle(cornerRadius: DesignSystem.mediumCornerRadius)
                    .stroke(.lightGray)
            )
    }
}

// MARK: - Constants
extension BorderedTextFieldStyle {
    private enum Constants {
        static let padding: CGFloat = 12
    }
}
