//
//  ListItemView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

struct CardView: View {
    var note: Note
    
    var body: some View {
        HStack(spacing: 12) {
            Capsule()
                .fill(Color(hex: note.category.color))
                .frame(width: 4)
                .padding(.leading, 12)
                .padding(.vertical, 16)
            
            VStack(alignment: .leading, spacing: 4) {
                if let categoryName = note.category.name {
                    CategoryRoundView(
                        title: categoryName,
                        color: note.category.color)
                    .padding(.bottom, 4)
                }
                
                Text(note.title)
                    .font(.gilroyMedium(size: 18))
                    .foregroundColor(ColorSystem.mainText)
                
                if let details = note.details {
                    Text(details)
                        .font(.gilroyRegular(size: 14))
                        .foregroundColor(ColorSystem.grayText)
                        .lineLimit(2)
                }
            }
            .padding([.vertical, .trailing], 16)
            
            Spacer()
            
            Image(systemName: "chevron.forward")
                .foregroundColor(ColorSystem.icons)
                .padding(.trailing, 16)
        }
        .background(ColorSystem.cardBackground)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 18,
                style: .continuous)
        )
        .shadow(color: ColorSystem.shadow, radius: 8)
        
    }
}
