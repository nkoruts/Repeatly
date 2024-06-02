//
//  CreateCategoryView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 20.05.2024.
//

import SwiftUI

struct CreateCategoryView: View {
    
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var viewContenxt
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var selectedColorHex: Int32?
    
    @FocusState private var focusedField: FocusedField?
    private enum FocusedField: Hashable {
        case name
    }
    
    // MARK: - UI
    var body: some View {
        NavigationView {
            VStack(spacing: Constants.contentSpacing) {
                
                HStack(alignment: .lastTextBaseline) {
                    Text("New category")
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
                    .disabled(name.isEmpty)
                }
                .padding(.top)
                
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
            .padding(.horizontal)
            .background(.background)
        }
    }
    
    private func saveCategory() {
        let category = Category(context: viewContenxt)
        category.id = UUID()
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
extension CreateCategoryView {
    private enum Constants {
        static let contentSpacing: CGFloat = 12
        static let colorsTitle = "Choose color"
        static let categoryNameTitle = "Category name"
        static let namePlaceholder = "Example: Study"
        static let nameTextLength = 16
        static let saveButtonTitle = "Save"
    }
}

// MARK: - Preview
#Preview {
    CreateCategoryView()
}
