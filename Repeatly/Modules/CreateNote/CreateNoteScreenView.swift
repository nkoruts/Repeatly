//
//  CreateNoteView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 29.01.2024.
//

import SwiftUI

struct CreateNoteScreenView: View {
    
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @State private var showCategories: Bool = false
    @State private var showAddCategories: Bool = false
    
    @FocusState private var focusedField: FocusedField?
    private enum FocusedField: Hashable {
        case title
        case details
    }
    
    @State private var title: String = ""
    @State private var details = ""
    @State private var selectedCategory: Category?
    
    @FetchRequest(sortDescriptors: [], animation: .spring())
    private var categories: FetchedResults<Category>
    
    // MARK: - UI
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: Constants.contentSpacing) {
                NavigationTopView(title: Constants.screenTitle) {
                    dismiss()
                }
                .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 8) {
                        Section(content: {
                            CategoriesListView(
                                categories: categories,
                                selectedCategory: $selectedCategory) {
                                    categories.isEmpty ? showAddCategories.toggle() : showCategories.toggle()
                                }
                        }, header: {
                            SectionHeaderView(title: Constants.categoryTitle)
                                .font(FontBook.regular2)
                                .padding(.horizontal)
                        })
                        
                        Section(content: {
                            TextField(Constants.notePlaceholder, text: $title)
                                .textLimit(Constants.titleTextLength, $title)
                                .textFieldStyle(BorderedTextFieldStyle())
                                .focused($focusedField, equals: .title)
                                .submitLabel(.next)
                                .onSubmit {
                                    focusedField = .details
                                }
                        }, header: {
                            SectionHeaderView(title: Constants.noteTitle)
                                .font(FontBook.regular2)
                        })
                        .padding(.horizontal)
                        
                        Section(content: {
                            TextField(
                                Constants.detailsPlaceholder,
                                text: $details,
                                axis: .vertical)
                            .lineLimit(5, reservesSpace: true)
                            .textFieldStyle(BorderedTextFieldStyle())
                            .focused($focusedField, equals: .details)
                            .submitLabel(.continue)
                            .onSubmit {
                                focusedField = title.isEmpty ? .title : nil
                            }
                        }, header: {
                            SectionHeaderView(title: Constants.detailsTitle)
                                .font(FontBook.regular2)
                        })
                        .padding(.horizontal)
                    }
                    .padding(.bottom)
                }
                
                Button(Constants.saveButtonTitle) {
                    focusedField = nil
                    saveNote()
                }
                .buttonStyle(MainButtonStyle())
                .disabled(title.isEmpty)
                .padding([.horizontal, .bottom])
            }
            .background(.background)
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $showAddCategories) {
            CreateCategoryScreenView()
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(DesignSystem.cornerRadius)
        }
        .sheet(isPresented: $showCategories) {
            CategoriesScreenView()
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(DesignSystem.cornerRadius)
        }
    }
    
    // MARK: - Private Methods
    private func saveNote() {
        let newNote = Note(context: viewContext)
        newNote.id = UUID()
        newNote.title = title
        newNote.details = !details.isEmpty ? details : nil
        newNote.isArchived = false

        newNote.category = selectedCategory
        newNote.repetition = createRepetition()
        
        do {
            try newNote.save()
            dismiss()
        } catch {
            log(error)
        }
    }
        
    private func createRepetition() -> Repetition {
        let repetition = Repetition(context: viewContext)
        let repetitionIntervals = RepetitionManager.sharing.defaultRepetitionIntervals()
        repetition.nextDate = repetitionIntervals[0]
        repetition.allDates = repetitionIntervals
        repetitionIntervals.forEach {
            LocalNotificationScheduler.instance.schedule(
                .init(title: "Repeat your knowledge", date: $0))
        }
        return repetition
    }
}

// MARK: - Constants
extension CreateNoteScreenView {
    private enum Constants {
        static let screenTitle = "Create Note"
        static let contentSpacing: CGFloat = 12
        
        static let categoryTitle = "Category"
        static let noteTitle = "Note title"
        static let titleTextLength = 40
        static let notePlaceholder = "Example: Study"
        static let noteFieldPadding: CGFloat = 12
        
        static let detailsTitle = "Details"
        static let detailsPlaceholder = "Example: Creating a learning space"
        
        static let saveButtonTitle = "Save"
    }
}

// MARK: - Preview
#Preview {
    CreateNoteScreenView()
}
