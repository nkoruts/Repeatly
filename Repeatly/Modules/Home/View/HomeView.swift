//
//  HomeView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

struct HomeView: View {
    let items = [
        CardModel(
            id: 0,
            title: "Заголовок 1",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adip",
            category: "Работа",
            color: .customGreen),
        CardModel(
            id: 1,
            title: "Заголовок 2",
            description: "Lorem ipsum dolor sit amet, consectetur",
            category: "Учёба",
            color: Color(hex: 0xECA768)),
        CardModel(
            id: 2,
            title: "Заголовок 3",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adip",
            category: "Финансы",
            color: Color(hex: 0xE7E498))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    Section(content: {
                        ForEach(items) { item in
                            CardView(item: item)
                        }
                    }, header: {
                        SectionHeaderView(title: "Today")
                    })
                    
                    Section(content: {
                        ForEach(items) { item in
                            CardView(item: item)
                        }
                    }, header: {
                        SectionHeaderView(title: "27 Jan")
                    })
                }
                .padding()
            }
            .background(Color.main)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
