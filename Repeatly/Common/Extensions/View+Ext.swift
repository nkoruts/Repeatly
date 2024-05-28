//
//  View+Ext.swift
//  Repeatly
//
//  Created by Nikita Koruts on 31.01.2024.
//

import SwiftUI

extension View {
    func textLimit(_ limit: Int, _ text: Binding<String>) -> some View {
        self.onChange(of: text.wrappedValue) { _ in
            text.wrappedValue = String(text.wrappedValue.prefix(limit))
        }
    }
    
    @ViewBuilder func isHidden(_ hidden: Bool) -> some View {
         if hidden {
             self.hidden()
         } else {
             self
         }
     }
}
