//
//  ListEmptyView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 05.02.2024.
//

import SwiftUI

struct ListEmptyView: View {
    var title: String
    var description: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "tray")
                .font(.system(size: 64))
                .foregroundColor(.icon)
            VStack(spacing: 4) {
                Text(title)
                    .font(FontBook.semibold2)
                    .foregroundColor(.mainText)
                .lineLimit(1)
                Text(description)
                    .font(FontBook.regular3)
                    .foregroundColor(.mainText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
        }
        .padding(.bottom, 160)
    }
}

struct ListEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        ListEmptyView(
            title: "Your notes is empty",
            description: "Create a new Note to get started on spaced repetition")
    }
}
