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
    
    @SectionedFetchRequest(
        sectionIdentifier: \.nextRepetitionDate,
        sortDescriptors: [.init(keyPath: \Note.repetition.nextDate, ascending: true)],
        animation: .spring())
    private var noteSections: SectionedFetchResults<String, Note>
    
    @FetchRequest(sortDescriptors: [], animation: .spring())
    private var categories: FetchedResults<Category>
    
    @State private var selectedCategory: Category?
    
    @State private var showModal: Bool = false
    @State private var willMoveToNoteCreation = false
    
    // MARK: - UI
    var body: some View {
        VStack(spacing: Constants.cardsSpacing) {
            navigationView
                .padding([.horizontal, .top])
            
            if categories.count > 1, !noteSections.isEmpty {
                categoriesView
            }
            
            notesList
                .overlay(emptyView)
        }
        .background(.background)
        .navigate(to: CreateNoteView(), when: $willMoveToNoteCreation)
        .navigate(to: CategoriesView(), when: $showModal)
    }
    
    private var navigationView: some View {
        VStack {
            HStack(alignment: .firstTextBaseline,
                   spacing: Constants.navigationPanelSpacing) {
                Text(Constants.appName)
                    .foregroundColor(.mainText)
                    .font(FontBook.semibold)
                Spacer()
                // TODO: Show search button
    //                Button(action: {
    //                    print(notes)
    //                    // TODO: - Search notes
    //                }, label: {
    //                    Image(systemName: Constants.findIconSystemName)
    //                        .font(.system(size: 24))
    //                        .foregroundColor(.button)
    //                })
                Button(action: {
                    willMoveToNoteCreation = true
                }, label: {
                    Image(systemName: Constants.addIconSystemName)
                        .font(Constants.addIconFont)
                        .foregroundColor(.button)
                })
            }
        }
    }
    
    private var categoriesView: some View {
        CategoriesListView(
            categories: categories,
            selectedCategory: $selectedCategory) {
                showModal.toggle()
            }
    }
    
    private var notesList: some View {
        ScrollView {
            LazyVStack(spacing: Constants.cardsSpacing) {
                ForEach(noteSections) { section in
                    Section(content: {
                        ForEach(section) { note in
                            let cardViewModel = CardViewModel(
                                note: note,
                                removeAction: { deleteNote(note) })
                            CardView(viewModel: cardViewModel)
                        }
                    }, header: {
                        SectionHeaderView(title: section.id)
                            .font(FontBook.medium2)
                    })
                    .padding(.horizontal)
                }
            }
        }
    }
    
    private var emptyView: some View {
        ListEmptyView(
            title: Constants.emptyViewTitle,
            description: Constants.emptyViewDescription)
        .isHidden(!noteSections.isEmpty)
    }
    
    // MARK: - Private Methods
    private func deleteNote(_ note: Note) {
        do {
            try note.delete()
        } catch {
            viewContext.rollback()
            log(error)
        }
    }
    
    private func getSectionTitle(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: date)
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
