//
//  EditCategoryView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 28.05.2024.
//

import SwiftUI

struct EditCategoryScreenView: View {
    
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
        NavigationView {
            VStack(alignment: .leading, spacing: Constants.contentSpacing) {
                HStack(alignment: .lastTextBaseline) {
                    Text(Constants.screenTitle)
                        .foregroundColor(.mainText)
                        .font(FontBook.medium)
                    
                    Spacer()
                    
                    Button(action: {
                        focusedField = nil
                        saveCategory()
                    }, label: {
                        Text("Save")
                            .font(FontBook.medium2)
                    })
                    .disabled(category.name.isEmpty)
                }
                
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
            }
            .padding()
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
extension EditCategoryScreenView {
    private enum Constants {
        static let screenTitle = "Edit category"
        static let contentSpacing: CGFloat = 12
        static let colorsTitle = "Choose color"
        static let categoryNameTitle = "Category name"
        static let namePlaceholder = "Example: Study"
        static let nameTextLength = 16
        static let saveButtonTitle = "Save"
    }
}
