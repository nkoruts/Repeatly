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
        VStack(alignment: .leading) {
            HStack {
                Text(item.title)
                    .font(.gilroyMedium(size: 24))
                    .foregroundColor(.white)
                if let category = item.category {
                    Spacer()
                    CategoryRoundView(title: category, color: item.color)
                }
            }
            .padding([.horizontal, .top], 16)
            
            if let description = item.description {
                Text(description)
                    .font(.gilroyRegular(size: 17))
                    .foregroundColor(.white)
                    .lineLimit(3)
                    .padding([.horizontal, .bottom], 16)
            }
            
        }
        .background(
            Color.secondaryColor
                .padding(.leading, 8)
                .background(item.color)
        )
//        .clipShape(
//            RoundedRectangle(cornerRadius: 18, style: .continuous)
//        )
        .cornerRadius(18)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.main
            
            CardView(
                item: CardModel(
                    id: 0,
                    title: "Заголовок",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adip",
                    category: "Работа",
                    color: .customGreen)
            )
            .padding()
        }
    }
}
