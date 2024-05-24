//
//  View+Ext.swift
//  Repeatly
//
//  Created by Nikita Koruts on 31.01.2024.
//

import SwiftUI

extension View {
    // TODO: - Update navigation
    func navigate<AnyView: View>(to view: AnyView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                NavigationLink(
                    destination: view.navigationBarHidden(true),
                    isActive: binding) {
                    EmptyView()
                }
            }
            
            .navigationBarBackButtonHidden(true)
        }
    }
}

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
