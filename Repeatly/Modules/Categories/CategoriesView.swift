//
//  CategoriesView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 24.05.2024.
//

import SwiftUI

struct CategoriesView: View {
    @Environment(\.dismiss) private var dismiss
    
    @FetchRequest(sortDescriptors: [], animation: .spring())
    private var categories: FetchedResults<Category>
    
    @State private var editingCategory: Category?
    @State private var showAddCategoryScreen = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: Constants.contentSpacing) {
                NavigationPanelWithToolbar(
                    title: Constants.screenTitle,
                    dismiss: dismiss
                ) {
                    Button(action: {
                        showAddCategoryScreen.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
                
                ScrollView {
                    VStack(spacing: Constants.cardsSpacing) {
                        ForEach(categories) { category in
                            categoryView(category)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .background(.background)
        }
        .navigationBarBackButtonHidden()
        .sheet(item: $editingCategory) { model in
            EditCategoryView(category: model)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(DesignSystem.cornerRadius)
        }
        .sheet(isPresented: $showAddCategoryScreen) {
            CreateCategoryView()
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(DesignSystem.cornerRadius)
        }
    }
    
    private func categoryView(_ model: Category) -> some View {
        HStack(alignment: .center, spacing: Constants.cardContentSpacing) {
            Capsule()
                .fill(Color(hex: model.colorHex))
                .frame(width: Constants.dividerWidth)
            
            Text(model.name)
                .font(FontBook.medium2)
                .foregroundColor(.mainText)
            
            Spacer()
            
            HStack(spacing: Constants.cardButtonsSpacing) {
                Button(action: {
                    editingCategory = model
                }) {
                    Image(systemName: "square.and.pencil")
                        .font(FontBook.regular2)
                        .foregroundColor(.gray)
                }
                
                Button(action: {
                    removeCategory(model)
                }) {
                    Image(systemName: "trash")
                        .font(FontBook.regular2)
                        .foregroundColor(.red)
                }
            }
        }
        .padding(Constants.defaultPadding)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.mediumCornerRadius)
                .fill(.white)
        }
        .shadow(color: ColorSystem.shadow.color,
                radius: Constants.shadowRadius)
    }
    
    // MARK: - Private Methods
    private func removeCategory(_ category: Category) {
        do {
            try category.delete()
            if categories.isEmpty {
                dismiss()
            }
        } catch {
            log(error)
        }
    }
}

// MARK: - Constants
extension CategoriesView {
    private enum Constants {
        static let screenTitle = "Categories"
        static let contentSpacing: CGFloat = 12
        
        static let dividerWidth: CGFloat = 4
        static let shadowRadius: CGFloat = 8
        
        static let cardsSpacing: CGFloat = 16
        static let cardContentSpacing: CGFloat = 16
        static let cardButtonsSpacing: CGFloat = 12
        static let defaultPadding: CGFloat = 16
    }
}

// MARK: - Preview
#Preview {
    CategoriesView()
}
