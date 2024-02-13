//
//  HomeView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [], animation: .spring())
    private var notes: FetchedResults<Note>
    
    @State private var willMoveToNoteCreation = false
    
    var body: some View {
        VStack(spacing: Constants.cardsSpacing) {
            HStack(alignment: .firstTextBaseline,
                   spacing: Constants.navigationPanelSpacing) {
                Text(Constants.appName)
                    .foregroundColor(ColorSystem.mainText)
                    .font(Constants.logoFont)
                Spacer()
                Button(action: {
                    print(notes)
                    // TODO: - Search notes
                }, label: {
                    Image(systemName: Constants.findIconSystemName)
                        .font(.system(size: 24))
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
                   .padding(.top)
            
            if !notes.isEmpty {
                ScrollView {
                    LazyVStack(spacing: Constants.cardsSpacing) {
                        Section(content: {
                            ForEach(notes) { note in
                                CardView(viewModel: CardViewModel(note: note, category: nil))
                            }
                        }, header: {
                            SectionHeaderView(title: ColorSystem.lightBlue.description)
                        })
                        .padding(.horizontal)
                    }
                }
            } else {
                ListEmptyView(
                    title: Constants.emptyViewTitle,
                    description: Constants.emptyViewDescription)
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
        
        static let emptyViewTitle = "Your notes is empty"
        static let emptyViewDescription = "Create a new Note to get started on spaced repetition"
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(StorageService.instance)
    }
}
