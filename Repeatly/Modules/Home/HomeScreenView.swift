//
//  HomeView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

struct HomeScreenView: View {
    
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var viewContext
    
    @SectionedFetchRequest(
        sectionIdentifier: \.nextRepetitionDate,
        sortDescriptors: [.init(keyPath: \Note.repetition.nextDate, ascending: true)],
        predicate: .init(format: "isArchived == false"),
        animation: .spring())
    private var noteSections: SectionedFetchResults<String, Note>
    
    @State private var searchModeEnabled = false
    @State private var searchedNote = ""
    @State private var showNoteCreation = false
    
    // MARK: - UI
    var body: some View {
        NavigationStack {
            VStack(spacing: Constants.cardsSpacing) {
                navigationView
                    .padding([.horizontal, .top])
                notesList
                    .overlay(emptyView)
            }
            .background(.background)
            .navigationDestination(isPresented: $showNoteCreation) {
                CreateNoteScreenView()
            }
            .navigationDestination(for: Note.self) { note in
                NoteDetailsScreenView()
                    .environmentObject(note)
            }
        }
    }
    
    private var navigationView: some View {
        VStack {
            HStack(alignment: .firstTextBaseline,
                   spacing: Constants.navigationPanelSpacing) {
                Text(Constants.appName)
                    .foregroundColor(.mainText)
                    .font(FontBook.semibold)
                Spacer()
                Button(action: {
                    withAnimation {
                        searchModeEnabled.toggle()
                    }
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .font(Constants.searchIconFont)
                        .foregroundColor(.icon)
                })
                .isHidden(noteSections.isEmpty)
                Button(action: {
                    showNoteCreation = true
                }, label: {
                    Image(systemName: Constants.addIconSystemName)
                        .font(Constants.addIconFont)
                        .foregroundColor(.button)
                })
            }
            
            
            if searchModeEnabled {
                TextField(Constants.searchPlaceholder, text: $searchedNote)
                    .textLimit(Constants.searchedTextLength, $searchedNote)
                    .textFieldStyle(BorderedTextFieldStyle())
    //                .focused($focusedField, equals: .title)
                    .submitLabel(.search)
    //                .onSubmit {
    //                    focusedField = .details
    //                }
            }
        }
    }
    
    private var notesList: some View {
        ScrollView {
            LazyVStack(spacing: Constants.cardsSpacing) {
                ForEach(noteSections) { section in
                    Section(content: {
                        ForEach(section) { note in
                            NavigationLink(value: note) {
                                CardView(
                                    note: note,
                                    repeatAction: { repeatNote(note) },
                                    removeAction: { deleteNote(note) })
                            }
                            .buttonStyle(.plain)
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
    private func repeatNote(_ note: Note) {
        do {
            try note.updateRepetition()
            note.repetition.managedObjectContext?.refresh(note, mergeChanges: true)
        } catch {
            log(error)
        }
    }
    
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

private extension HomeScreenView {
     enum Constants {
        static let appName = "Repeatly"
        static let addIconSystemName = "plus.app.fill"
        
        static let searchIconFont: Font = .system(size: 28)
        static let addIconFont: Font = .system(size: 34)
        static let navigationPanelSpacing: CGFloat = 12
        static let cardsSpacing: CGFloat = 16
        
        static let searchPlaceholder = "Note name"
        static let searchedTextLength = 20
        
        static let emptyViewTitle = "Your notes is empty"
        static let emptyViewDescription = "Create a new Note to get started on spaced repetition"
    }
}

// MARK: - Preview
#Preview {
    HomeScreenView()
}
