//
//  HomeView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [], animation: .spring())
    private var notes: FetchedResults<Note>
    
    @State private var willMoveToNoteCreation = false
    
    // MARK: - UI
    var body: some View {
        VStack(spacing: Constants.cardsSpacing) {
            HStack(alignment: .firstTextBaseline,
                   spacing: Constants.navigationPanelSpacing) {
                Text(Constants.appName)
                    .foregroundColor(ColorSystem.mainText.color)
                    .font(FontBook.semibold)
                Spacer()
                // TODO: Show search button
                if false {
                    Button(action: {
                        print(notes)
                        // TODO: - Search notes
                    }, label: {
                        Image(systemName: Constants.findIconSystemName)
                            .font(.system(size: 24))
                            .foregroundColor(ColorSystem.button.color)
                    })
                }
                Button(action: {
                    willMoveToNoteCreation = true
                }, label: {
                    Image(systemName: Constants.addIconSystemName)
                        .font(Constants.addIconFont)
                        .foregroundColor(ColorSystem.button.color)
                })
            }
            .padding([.horizontal, .top])
            
            ScrollView {
                LazyVStack(spacing: Constants.cardsSpacing) {
                    Section(content: {
                        ForEach(notes) { note in
                            let cardViewModel = CardViewModel(
                                note: note,
                                category: nil,
                                removeAction: { deleteNote(note) }
                            )
                            CardView(viewModel: cardViewModel)
                        }
                    }, header: {
                        EmptyView()
//                        SectionHeaderView(title: "===== TODO ======")
                    })
                    .padding(.horizontal)
                }
            }
            .overlay(
                Group {
                    if notes.isEmpty {
                        ListEmptyView(
                            title: Constants.emptyViewTitle,
                            description: Constants.emptyViewDescription)
                    }
                }
            )
        }
        .background(ColorSystem.background.color)
        .navigate(to: CreateNoteView(), when: $willMoveToNoteCreation)
    }
    
    private func deleteNote(_ note: Note) {
        do {
            try note.delete()
        } catch {
            viewContext.rollback()
            log(error)
        }
    }
}

extension HomeView {
    private enum Constants {
        static let appName = "Repeatly"
        static let findIconSystemName = "magnifyingglass"
        static let addIconSystemName = "plus.app.fill"
        
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
    }
}
