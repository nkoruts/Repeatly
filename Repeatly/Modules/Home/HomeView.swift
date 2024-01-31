//
//  HomeView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

struct ColorSystem {
    static let pink = Color(hex: 0xFD6686)
    static let lightBlue = Color(hex: 0x33C6F8)
    static let yellow = Color(hex: 0xFFC12C)
    static let green = Color(hex: 0x34D183)
    
    static let blueButton = Color(hex: 0x3E69FF)
    static let icons = Color(hex: 0xC3C8CE)
    
    static let grayText = Color(hex: 0x949DA9)
    static let mainText = Color(hex: 0x232E3F)
    
    static let background = Color(hex: 0xF5F7FA)
    static let cardBackground = Color(hex: 0xFCFCFD)
    static let tabbarBackground = Color(hex: 0xFDFDFD)
    
    static let shadow = Color(hex: 0xEEF0F4)
}

struct HomeView: View {
    @State private var willMoveToNoteCreation = false
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .firstTextBaseline, spacing: 12) {
                Text("Repetly")
                    .foregroundColor(ColorSystem.mainText)
                    .font(.gilroySemiBold(size: 32))
                Spacer()
                Button(action: {
                    print("Search")
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(ColorSystem.blueButton)
                })
                Button(action: {
                    willMoveToNoteCreation = true
                }, label: {
                    HStack {
                        Image(systemName: "plus.app.fill")
                            .font(.system(size: 34))
                            .foregroundColor(ColorSystem.blueButton)
                    }
                })
            }
            .padding(.horizontal)
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    Section(content: {
                        ForEach(items) { item in
                            CardView(item: item)
                        }
                    }, header: {
                        SectionHeaderView(title: "Today")
                    })
                    .padding(.horizontal)
                }
            }
        }
        .background(ColorSystem.background)
        .navigate(to: CreateNoteView(), when: $willMoveToNoteCreation)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
