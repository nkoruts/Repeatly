//
//  CreateNoteView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 29.01.2024.
//

import SwiftUI

struct CreateNoteView: View {
    @State private var title = ""
    @State private var details = ""
    @State private var selectedCategoryId: UUID?
    
    @State private var categories: [Category] = []
    
    @EnvironmentObject private var storageService: StorageService
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var focusedField: FocusedField?
    enum FocusedField: Hashable {
        case title
        case details
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: Constants.contentSpacing) {
                NavigationTopView(
                    title: Constants.screenTitle,
                    backAction: {
                        dismiss()
                    })
                .padding(.horizontal)
                
                Spacer().frame(height: Constants.contentTopInset)
                
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
                        .focused($focusedField, equals: .title)
                        .onSubmit {
                            focusedField = .details
                        }
                        .textFieldStyle(BorderedTextFieldStyle())
                }, header: {
                    SectionHeaderView(title: Constants.noteTitle)
                })
                .padding(.horizontal)

                
                Section(content: {
                    MultilineTextView(
                        placeholder: Constants.detailsPlaceholder,
                        text: $details)
                    .focused($focusedField, equals: .details)
                    .frame(height: Constants.detailsHeight)
                    .onSubmit {
                        focusedField = nil
                    }
                }, header: {
                    SectionHeaderView(title: Constants.detailsTitle)
                })
                .padding(.horizontal)
                
                Spacer()
                
                Button(Constants.saveButtonTitle) {
                    saveNote()
                }
                .buttonStyle(MainButtonStyle())
                .disabled(title.isEmpty)
                .padding(.horizontal)
            }
            .padding(.vertical)
            .background(ColorSystem.background)
        }
    }
    
    private func saveNote() {
        storageService.saveNote(
            title: title,
            details: details,
            colorName: "AccentColor",
            categoryId: nil,
            repetition: nil)
//        dismiss()
    }
}

extension CreateNoteView {
    private enum Constants {
        static let screenTitle = "Create Note"
        static let contentTopInset: CGFloat = 16
        static let contentSpacing: CGFloat = 12
        
        static let categoryTitle = "Category"
        static let noteTitle = "Example: Study"
        static let notePlaceholder = "Note title"
        static let noteFieldFont: Font = .gilroyRegular(size: 16)
        static let noteFieldPadding: CGFloat = 12
        static let noteFieldCornerRadius: CGFloat = 16
        
        static let detailsTitle = "Details"
        static let detailsPlaceholder = "Example: Creating a learning space"
        static let detailsHeight: CGFloat = 100
        
        static let saveButtonTitle = "Save"
    }
}

struct CreateNoteView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNoteView()
    }
}
