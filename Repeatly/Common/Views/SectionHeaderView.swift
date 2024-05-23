//
//  SectionHeaderView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

struct SectionHeaderView: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(FontBook.regular2)
                .foregroundColor(.mainText)
                .lineLimit(1)
            Spacer()
        }
        .padding(.top, 8)
    }
}
