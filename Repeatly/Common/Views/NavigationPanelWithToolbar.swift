//
//  NavigationPanelWithToolbar.swift
//  Repeatly
//
//  Created by Nikita Koruts on 21.06.2024.
//

import SwiftUI

struct NavigationPanelWithToolbar<Toolbar: View>: View {
    let title: String
    let dismiss: DismissAction
    let toolbar: () -> Toolbar
    
    init(title: String, 
         dismiss: DismissAction,
         @ViewBuilder toolbar: @escaping () -> Toolbar) {
        self.title = title
        self.dismiss = dismiss
        self.toolbar = toolbar
    }
    
    var body: some View {
        ZStack {
            Text(title)
                .foregroundColor(.mainText)
                .font(FontBook.medium)
                .frame(maxWidth: .infinity, alignment: .center)
            
            HStack {
                BackButton {
                    dismiss()
                }
                
                Spacer()
                
                toolbar()
            }
        }
        .padding(.vertical)
    }
}
