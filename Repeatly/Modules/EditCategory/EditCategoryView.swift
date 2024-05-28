//
//  EditCategoryView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 28.05.2024.
//

import SwiftUI

struct EditCategoryView: View {
    
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var viewContenxt
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var focusedField: FocusedField?
    private enum FocusedField: Hashable {
        case name
    }
    
    @State private var name: String = ""
    @State private var selectedColorHex: Int32?
    
    let category: Category
    
    // MARK: - UI
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: Constants.contentSpacing) {
                NavigationTopView(title: "Edit category") {
                    dismiss()
                }
                .padding(.bottom)
                
                Section(content: {
                    TextField(Constants.namePlaceholder, text: $name)
                        .textLimit(Constants.nameTextLength, $name)
                        .textFieldStyle(BorderedTextFieldStyle())
                        .submitLabel(.next)
                        .onSubmit {
                            focusedField = nil
                        }
                }, header: {
                    SectionHeaderView(title: Constants.categoryNameTitle)
                        .font(FontBook.regular2)
                })
                
                Section(content: {
                    ColorPickerView(selectedColorHex: $selectedColorHex)
                }, header: {
                    SectionHeaderView(title: Constants.colorsTitle)
                        .font(FontBook.regular2)
                })
                
                Spacer()
                
                Button(Constants.saveButtonTitle) {
                    focusedField = nil
                    saveCategory()
                }
                .buttonStyle(MainButtonStyle())
                .disabled(category.name.isEmpty)
            }
            .padding(.horizontal)
            .padding(.vertical, Constants.contentVerticalPadding)
            .background(.background)
        }
        .onAppear {
            name = category.name
            selectedColorHex = category.colorHex
        }
        .navigationBarBackButtonHidden()
    }
    
    // MARK: - Private Methods
    private func saveCategory() {
        category.name = name
        category.colorHex = selectedColorHex ?? ColorSystem.icon.hex
        
        do {
            try category.save()
            dismiss()
        } catch {
            log(error)
        }
    }
}

// MARK: - Constants
extension EditCategoryView {
    private enum Constants {
        static let contentSpacing: CGFloat = 12
        static let contentVerticalPadding: CGFloat = 24
        static let colorsTitle = "Choose color"
        static let categoryNameTitle = "Category name"
        static let namePlaceholder = "Example: Study"
        static let nameTextLength = 16
        static let saveButtonTitle = "Save"
    }
}
