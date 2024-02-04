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
            HStack(alignment: .firstTextBaseline,
                   spacing: Constants.navigationPanelSpacing) {
                Text(Constants.appName)
                    .foregroundColor(ColorSystem.mainText)
                    .font(Constants.logoFont)
                Spacer()
                Button(action: {
                    // TODO: - Search notes
                }, label: {
                    Image(systemName: Constants.findIconSystemName)
                        .font(.title2)
                        .foregroundColor(ColorSystem.button)
                })
                Button(action: {
                    willMoveToNoteCreation = true
                }, label: {
                    Image(systemName: Constants.addIconSystemName)
                        .font(Constants.addIconFont)
                        .foregroundColor(ColorSystem.button)
                })
            }
            .padding(.horizontal)
            
            ScrollView {
                LazyVStack(spacing: Constants.cardsSpacing) {
                    Section(content: {
                        ForEach(notes) { note in
                            CardView(note: note)
                        }
                    }, header: {
                        SectionHeaderView(title: "===TODO===")
                    })
                    .padding(.horizontal)
                }
            }
        }
        .background(ColorSystem.background)
        .navigate(to: CreateNoteView(), when: $willMoveToNoteCreation)
    }
}

extension HomeView {
    private enum Constants {
        static let appName = "Repetly"
        static let findIconSystemName = "magnifyingglass"
        static let addIconSystemName = "plus.app.fill"
        
        static let logoFont: Font = .gilroySemiBold(size: 32)
        static let addIconFont: Font = .system(size: 34)
        
        static let navigationPanelSpacing: CGFloat = 12
        static let cardsSpacing: CGFloat = 16
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
