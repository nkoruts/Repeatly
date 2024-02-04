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
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack() {
                Button(action: {
//                    willMoveToNoteCreation = true
                }, label: {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(ColorSystem.button)
                        .padding(14)
                        .background(
                            Circle()
                                .fill(ColorSystem.lightButton)
                        )
                })
                
                ForEach(categories) { caterory in
                    CategoryView(
                        title: caterory.name,
                        color: Color(hex: caterory.color),
                        isSelected: Binding(
                            get: {
                                self.selection == caterory.id
                            },
                            set: { _ in
                                self.handleSelection(caterory.id)
                            })
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

