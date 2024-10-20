//
//  SearchView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 07.10.2024.
//

import SwiftUI

struct SearchTextView: View {
    @Binding var searchText: String
    let placeholder: String
    let textLength = 10
    let cancelAction: Action
    
    var body: some View {
        HStack {
            TextField(placeholder, text: $searchText)
                .textLimit(textLength, $searchText)
                .textFieldStyle(BorderedTextFieldStyle())
                .submitLabel(.search)
            Button(action: {
                cancelAction()
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .foregroundColor(.icon)
            })
            .buttonStyle(.plain)
        }
    }
}
