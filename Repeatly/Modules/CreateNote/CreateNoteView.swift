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
    @State private var showModal: Bool = false
    
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
        NavigationView {
            VStack(alignment: .leading, spacing: Constants.contentSpacing) {
                NavigationTopView(
                    title: Constants.screenTitle,
                    backAction: {
                        dismiss()
                    })
                .padding([.horizontal, .bottom])
                
                ScrollView {
                    VStack(spacing: 8) {
                        Section(content: {
                            CategoriesListView(
                                categories: categories,
                                selectedCategory: $selectedCategory) {
                                    showModal.toggle()
                                }
                        }, header: {
                            SectionHeaderView(title: Constants.categoryTitle)
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
        .sheet(isPresented: $showModal) {
            if #available(iOS 16.4, *) {
                CreateCategoryView()
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.hidden)
                    .presentationCornerRadius(DesignSystem.cornerRadius)
            } else {
                CreateCategoryView()
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.hidden)
            }
        }
    }
    
    private func saveNote() {
        let newNote = Note(context: viewContext)
        newNote.id = UUID()
        newNote.title = title
        newNote.details = !details.isEmpty ? details : nil

        newNote.category = selectedCategory
        // newNote.repetition = repetition

        do {
            try newNote.save()
            dismiss()
        } catch {
            log(error)
        }
    }
}

// MARK: - Constants
extension CreateNoteView {
    private enum Constants {
        static let titleTextLength = 20
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

// MARK: - Preview
struct CreateNoteView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNoteView()
    }
}
