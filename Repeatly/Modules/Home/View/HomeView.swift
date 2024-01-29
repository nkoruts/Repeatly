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
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
            category: "Работа",
            color: Color(hex: 0xffbe98)),
        CardModel(
            id: 1,
            title: "Заголовок 2",
            description: "Lorem ipsum dolor sit amet, consectetur",
            category: "Учёба",
            color: Color(hex: 0x6667ab)),
        CardModel(
            id: 2,
            title: "Заголовок 3",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adip",
            category: "Финансы",
            color: Color(hex: 0xbb2649)),
        CardModel(
            id: 3,
            title: "Заголовок 3",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adip",
            category: "Финансы",
            color: Color(hex: 0x939597)),
        CardModel(
            id: 4,
            title: "Заголовок 3",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adip",
            category: "Финансы",
            color: Color(hex: 0xf5df4d))
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
