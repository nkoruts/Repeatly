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
            Spacer()
            
            Image(systemName: "tray")
                .font(.system(size: 64))
                .foregroundColor(ColorSystem.icon.color)
            VStack(spacing: 4) {
                Text(title)
                    .font(.gilroySemiBold(size: 24))
                    .foregroundColor(ColorSystem.mainText.color)
                .lineLimit(1)
                Text(description)
                    .font(.gilroyRegular(size: 14))
                    .foregroundColor(ColorSystem.mainText.color)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
            }
            
            Spacer()
        }
    }
}

struct ListEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        ListEmptyView(
            title: "Your notes is empty",
            description: "Create a new Note to get started on spaced repetition")
    }
}
