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
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: Constants.contentSpacing) {
                NavigationTopView(title: Constants.screenTitle) {
                    dismiss()
                }
                .padding(.bottom)
                
                ForEach(categories) { category in
                    HStack(alignment: .bottom, spacing: 16) {
                        Text(category.name)
                            .font(FontBook.medium2)
                            .foregroundColor(.mainText)
                            .padding(.top)

                        Spacer()
                        
                        Button(action: {} ) {
                            Image(systemName: "square.and.pencil")
                                .font(FontBook.regular2)
                                .foregroundColor(.grayText)
                        }
                        
                        Button(action: {
                            removeCategory(category)
                        }) {
                            Image(systemName: "trash")
                                .font(FontBook.regular2)
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.trailing, 12)
                    
                    Divider()
                        .background(.cardBackground)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, Constants.contentVerticalPadding)
            .background(.background)
        }
    }
    
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
        static let contentVerticalPadding: CGFloat = 24
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
