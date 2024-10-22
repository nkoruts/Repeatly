//
//  SectionHeaderView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

struct SectionHeaderView: View {
    var title: String
    var mandatory: Bool = false
    
    var body: some View {
        HStack(spacing: .zero) {
            Text(title)
                .foregroundColor(.mainText)
                .lineLimit(1)
            if mandatory {
                Text("*")
                    .foregroundColor(.red)
                    .lineLimit(1)
            }
            
            Spacer()
        }
        .padding(.top, 8)
    }
}
