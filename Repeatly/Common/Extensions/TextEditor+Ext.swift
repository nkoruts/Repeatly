//
//  TextEditor+Ext.swift
//  Repeatly
//
//  Created by Nikita Koruts on 10.02.2024.
//

import SwiftUI

extension View {
    func textEditorBackground(_ content: Color) -> some View {
        if #available(iOS 16.0, *) {
            return self.scrollContentBackground(.hidden)
//                .background(content)
        } else {
            UITextView.appearance().backgroundColor = .clear
            return self.background(content)
        }
    }
}
