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
            VStack(alignment: .leading, spacing: Constants.contentTopInset) {
                NavigationTopView(
                    title: Constants.screenTitle,
                    backAction: {
                        dismiss()
                    })
                .padding(.horizontal)
                
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
                                .font(FontBook.regular3)
                                .textLimit(titleTextLength, $title)
                                .focused($focusedField, equals: .title)
                                .textFieldStyle(BorderedTextFieldStyle())
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
                            .font(FontBook.regular3)
                            .lineLimit(5, reservesSpace: true)
                            .focused($focusedField, equals: .details)
                            .onSubmit {
                                focusedField = title.isEmpty ? .title : nil
                            }
                            .textFieldStyle(BorderedTextFieldStyle())
                        }, header: {
                            SectionHeaderView(title: Constants.detailsTitle)
                        })
                        .padding(.horizontal)
                    }
                }
                
                Button(Constants.saveButtonTitle) {
                    saveNote()
                }
                .buttonStyle(MainButtonStyle())
                .disabled(title.isEmpty)
                .padding(.horizontal)
            }
            .padding(.vertical)
            .background(ColorSystem.background.color)
        }
        .preferredColorScheme(.light)
    }
    
    private func saveNote() {
        let newNote = Note(context: viewContext)
        newNote.id = UUID()
        newNote.title = title
        newNote.details = !details.isEmpty ? details : nil
        newNote.color = ColorSystem.lightBlue.rawValue // TODO: Set category color
        newNote.categoryId = nil
        // newNote.repetition = repetition
        
        // TODO: - Save async
        try? viewContext.save()
    }
}

extension CreateNoteView {
    private enum Constants {
        static let screenTitle = "Create Note"
        static let contentTopInset: CGFloat = 32
        static let contentSpacing: CGFloat = 12
        
        static let categoryTitle = "Category"
        static let noteTitle = "Note title"
        static let notePlaceholder = "Example: Study"
        static let noteFieldPadding: CGFloat = 12
        static let noteFieldCornerRadius: CGFloat = 16
        
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
