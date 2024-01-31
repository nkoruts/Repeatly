//
//  ListItemView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

struct CardView: View {
    var item: CardModel
    
    var body: some View {
        HStack(spacing: 12) {
            Capsule()
                .fill(item.color)
                .frame(width: 4)
                .padding(.leading, 12)
                .padding(.vertical, 16)
            
            VStack(alignment: .leading, spacing: 4) {
                if let category = item.category {
                    CategoryRoundView(
                        title: category,
                        color: item.color)
                    .padding(.bottom, 4)
                }
                
                Text(item.title)
                    .font(.gilroyMedium(size: 18))
                    .foregroundColor(ColorSystem.mainText)
                
                if let description = item.description {
                    Text(description)
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

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ColorSystem.background
            
            CardView(
                item: CardModel(
                    id: 0,
                    title: "Заголовок",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                    category: "Работа",
                    color: .accent)
            )
            .padding()
        }
    }
}
