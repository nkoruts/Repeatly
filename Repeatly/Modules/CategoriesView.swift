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
                    HStack {
                        Text(category.name)
                            .font(FontBook.medium2)
                            .foregroundColor(Color(hex: category.colorHex))
                            .padding(.top)

                        Spacer()
                        
                        Button(action: {} ) {
                            Image(systemName: "trash")
                                .font(FontBook.regular3)
                                .foregroundColor(.red)
                                .padding()
                                .background(
                                    Circle()
                                        .fill(.red.opacity(0.15))
                                )
                        }
                    }
                    Divider()
                        .background(.lightGray)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, Constants.contentVerticalPadding)
            .background(.background)
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
