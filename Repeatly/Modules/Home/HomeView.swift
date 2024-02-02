//
//  HomeView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

struct HomeView: View {
    @FetchRequest(sortDescriptors: []) var notes: FetchedResults<Note>
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
                    Image(systemName: "plus.app.fill")
                        .font(.system(size: 34))
                        .foregroundColor(ColorSystem.blueButton)
                })
            }
            .padding(.horizontal)
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    Section(content: {
                        ForEach(notes) { note in
                            CardView(note: note)
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
