//
//  ModalNavigationView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 03.07.2024.
//

import SwiftUI

struct ModalNavigationView<T: View>: View {
    let title: String
    let label: () -> T
    
    init(title: String,
         @ViewBuilder label: @escaping () -> T) {
        self.title = title
        self.label = label
    }
    
    var body: some View {
        HStack(alignment: .lastTextBaseline) {
            Text(title)
                .foregroundColor(.mainText)
                .font(FontBook.medium)
            
            Spacer()
            
            label()
        }
        .padding(.top)
        .padding(.bottom, 8)
    }
}
