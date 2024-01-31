//
//  View+Ext.swift
//  Repeatly
//
//  Created by Nikita Koruts on 31.01.2024.
//

import SwiftUI

extension View {
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
