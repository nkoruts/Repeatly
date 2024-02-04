//
//  CreateNoteView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 29.01.2024.
//

import SwiftUI

struct CreateNoteView: View {
    @State var title = ""
    @State var details = ""
    @State var selectedCategoryId: UUID?
    
    @State var categories: [Category] = []
    
    @Environment(\.dismiss) private var dismiss
    
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
                        selection: $selectedCategoryId)
                }, header: {
                    SectionHeaderView(title: Constants.categoryTitle)
                        .padding(.horizontal)
                })
                
                Section(content: {
                    TextField(Constants.notePlaceholder, text: $title)
                        .font(Constants.noteFieldFont)
                        .padding(Constants.noteFieldPadding)
                        .overlay(
                            RoundedRectangle(
                                cornerRadius: Constants.noteFieldCornerRadius,
                                style: .continuous)
                            .stroke(Color.lightGray)
                        )
                }, header: {
                    SectionHeaderView(title: Constants.noteTitle)
                })
                .padding(.horizontal)

                
                Section(content: {
                    MultilineTextView(
                        placeholder: Constants.detailsPlaceholder,
                        text: $details)
                    .frame(height: Constants.detailsHeight)
                }, header: {
                    SectionHeaderView(title: Constants.detailsTitle)
                })
                .padding(.horizontal)
                
                Spacer()
                
                
                Button(Constants.saveButtonTitle) {
                    print("save")
                }
                .buttonStyle(MainButtonStyle())
                .padding(.horizontal)
            }
            .padding(.vertical)
            .background(ColorSystem.background)
        }
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
        static let noteFieldPadding: Font = 12
        static let noteFieldCornerRadius: CGFloat = 16
        
        static let detailsTitle = "Details"
        static let detailsPlaceholder: LocalizedStringKey = "Example: Creating a learning space"
        static let detailsHeight: CGFloat = 100
        
        static let saveButtonTitle = "Save"
    }
}

struct CreateNoteView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNoteView()
    }
}
