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
            color: .accent),
        CardModel(
            id: 1,
            title: "Заголовок 2",
            description: "Lorem ipsum dolor sit amet, consectetur",
            category: "Учёба",
            color: .accent),
        CardModel(
            id: 2,
            title: "Заголовок 3",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adip",
            category: "Финансы",
            color: .accent),
        CardModel(
            id: 3,
            title: "Заголовок 3",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adip",
            category: "Финансы",
            color: .accent),
        CardModel(
            id: 4,
            title: "Заголовок 3",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adip",
            category: "Финансы",
            color: .accent)
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        Text("Repetly")
                            .foregroundColor(.text)
                            .font(.gilroySemiBold(size: 32))
                        Spacer()
                        Button(action: {
                            print("Search")
                        }, label: {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(.lightGray)
                        })
                        Button(action: {
                            print("Search")
                        }, label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .font(.title2)
                                .foregroundColor(.lightGray)
                        })
                    }
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            print("Search")
                        }, label: {
                            HStack {
                                Image(systemName: "plus.app.fill")
                                    .font(.title)
                                    .foregroundColor(.lightGray)
                                Text("Create")
                                    .font(.gilroyRegular(size: 16))
                                    .foregroundColor(.text)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.lightBackground)
                            )
                        })
                    }
                }
                
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
                }
            }
            .padding()
            .background(Color.background)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
