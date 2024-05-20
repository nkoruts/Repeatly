//
//  CreateNoteView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 29.01.2024.
//

import SwiftUI

struct CreateNoteView: View {
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: FocusedField?
    private enum FocusedField: Hashable {
        case title
        case details
    }
    
    @State private var title: String = ""
    @State private var details = ""
    @State private var selectedCategoryId: UUID?
    @State private var categories: [Category] = []
    
    private let titleTextLength = 6
    
    // MARK: - UI
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: Constants.contentSpacing) {
                NavigationTopView(
                    title: Constants.screenTitle,
                    backAction: {
                        dismiss()
                    })
                .padding([.horizontal, .bottom])
//                .padding(.bottom, 12)
                
                ScrollView {
                    VStack(spacing: 8) {
                        Section(content: {
                            CategoriesListView(
                                categories: categories,
                                selection: $selectedCategoryId) {
                                    // TODO: Move to category creation
                                }
                        }, header: {
                            SectionHeaderView(title: Constants.categoryTitle)
                                .padding(.horizontal)
                        })
                        
                        Section(content: {
                            TextField(Constants.notePlaceholder, text: $title)
                                .textLimit(titleTextLength, $title)
                                .textFieldStyle(BorderedTextFieldStyle())
                                .focused($focusedField, equals: .title)
                                .submitLabel(.next)
                                .onSubmit {
                                    focusedField = .details
                                }
                        }, header: {
                            SectionHeaderView(title: Constants.noteTitle)
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
                        })
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
                .scrollDisabled(focusedField == nil)
                .background(focusedField == nil ? .clear : .focus)
                
                Button(Constants.saveButtonTitle) {
                    focusedField = nil
                    saveNote()
                }
                .buttonStyle(MainButtonStyle())
                .disabled(title.isEmpty)
                .padding(.horizontal)
            }
            .padding(.vertical, Constants.contentVerticalPadding)
            .background(.background)
        }
        .preferredColorScheme(.light)
    }
    
    private func saveNote() {
        let newNote = Note(context: viewContext)
        newNote.id = UUID()
        newNote.title = title
        newNote.details = !details.isEmpty ? details : nil
        newNote.category = nil
        // newNote.repetition = repetition
        
        // TODO: - Save async
        try? viewContext.save()
    }
}

extension CreateNoteView {
    private enum Constants {
        static let screenTitle = "Create Note"
        static let contentSpacing: CGFloat = 12
        static let contentVerticalPadding: CGFloat = 24
        
        static let categoryTitle = "Category"
        static let noteTitle = "Note title"
        static let notePlaceholder = "Example: Study"
        static let noteFieldPadding: CGFloat = 12
        
        static let detailsTitle = "Details"
        static let detailsPlaceholder = "Example: Creating a learning space"
        
        static let saveButtonTitle = "Save"
    }
}

struct CreateNoteView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNoteView()
    }
}
