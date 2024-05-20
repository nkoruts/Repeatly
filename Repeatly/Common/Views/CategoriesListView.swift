//
//  CategoriesListView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 02.02.2024.
//

import SwiftUI

struct CategoriesListView: View {
    var categories: [Category]
    @Binding var selection: UUID?
    var action: Action
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack() {
                Button(action: action) {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.button)
                        .padding(14)
                        .background(
                            Circle()
                                .fill(.lightButton))
                }
                
                ForEach(categories) { category in
                    CategoryView(
                        title: category.name,
                        color: Color(hex: category.colorHex),
                        isSelected: Binding(
                            get: { self.selection == category.id },
                            set: { _ in self.handleSelection(category.id) }
                        )
                    )}
            }
        }
        .safeAreaInset(edge: .leading, spacing: .zero) {
            Spacer()
                .frame(width: 16, height: 0)
        }
        .safeAreaInset(edge: .trailing, spacing: .zero) {
            Spacer()
                .frame(width: 24, height: 0)
        }
    }
    
    private func handleSelection(_ categoryId: UUID) {
        selection = (selection != categoryId) ? categoryId : nil
    }
}

