//
//  MultilineTextView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 31.01.2024.
//

import SwiftUI

struct MultilineTextView: View {
    var placeholder: String = ""
    @Binding var text: String
    
    var body: some View {
        ZStack {
            TextEditor(text: $text)
                .font(.gilroyRegular(size: 16))
                .foregroundColor(ColorSystem.mainText.color)
                .textEditorBackground(.clear)
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(ColorSystem.lightGray.color)
                )
            if text.isEmpty, !placeholder.isEmpty {
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
                .allowsHitTesting(false)
            }

        }
    }
}

struct MultilineTextView_Previews: PreviewProvider {
    static var previews: some View {
        @State var text = ""
        
        ZStack {
            Color.gray
            MultilineTextView(placeholder: "placeholder", text: $text)
                .frame(width: 340, height: 120)
        }

    }
}
