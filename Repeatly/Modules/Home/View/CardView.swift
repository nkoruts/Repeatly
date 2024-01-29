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
        HStack(spacing: .zero) {
            Rectangle()
                .fill(item.color)
                .frame(width: 8)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(item.title)
                        .font(.gilroyMedium(size: 24))
                        .foregroundColor(.white)
                    if let category = item.category {
                        Spacer()
                        CategoryRoundView(
                            title: category,
                            color: item.color)
                    }
                }
                
                if let description = item.description {
                    Text(description)
                        .font(.gilroyRegular(size: 17))
                        .foregroundColor(.white)
                        .lineLimit(3)
                }
            }
            .padding(16)
        }
        .background(Color.secondaryColor)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 18,
                style: .continuous)
        )
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
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                    category: "Работа",
                    color: .customGreen)
            )
            .padding()
        }
    }
}
