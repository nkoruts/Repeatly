//
//  CreateCategoryView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 20.05.2024.
//

import SwiftUI

struct CreateCategoryView: View {
    
    @State private var name: String = ""
    @State private var selectedColor: Color? = Constants.colors.first
    
    var body: some View {
        NavigationView {
            VStack(spacing: Constants.contentSpacing) {
                Text("New category")
                    .foregroundColor(.mainText)
                    .font(FontBook.medium)
                    .multilineTextAlignment(.center)
                    .padding(.top, 12)
                
                Section(content: {
                    TextField(Constants.namePlaceholder, text: $name)
                        .textLimit(Constants.nameTextLength, $name)
                        .textFieldStyle(BorderedTextFieldStyle())
                        .submitLabel(.next)
                }, header: {
                    SectionHeaderView(title: Constants.categoryNameTitle)
                })
                
                Section(content: {
                    ColorPickerView(
                        colors: Constants.colors,
                        selectedColor: $selectedColor)
                }, header: {
                    SectionHeaderView(title: Constants.colorsTitle)
                })
                
                Spacer()
            }
            .padding(.horizontal)
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
        static let nameTextLength = 6
        
        static let colors: [Color] = [
            Color(hex: ColorSystem.icon.hex),
            Color(hex: ColorSystem.pink.hex),
            Color(hex: ColorSystem.lightBlue.hex),
            Color(hex: ColorSystem.yellow.hex),
            Color(hex: ColorSystem.green.hex)
        ]
    }
}

// MARK: - Preview
struct CreateCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCategoryView()
    }
}
