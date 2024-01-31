//
//  MultilineTextView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 31.01.2024.
//

import SwiftUI

struct MultilineTextView: View {
    var placeholder: LocalizedStringKey = ""
    @Binding var text: String
    
    var body: some View {
        ZStack {
            TextEditor(text: $text)
                .font(.gilroyRegular(size: 16))
                .colorMultiply(.clear)
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(Color.lightGray)
                )
            if text.isEmpty {
                HStack {
                    VStack {
                        Text(placeholder)
                            .font(.gilroyRegular(size: 16))
                            .foregroundColor(.gray.opacity(0.6))
                            .padding(.vertical, 16)
                            .padding(.horizontal, 12)
                        Spacer()
                    }
                    Spacer()
                }
            }

        }
    }
}
