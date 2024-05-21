//
//  CreateCategoryView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 20.05.2024.
//

import SwiftUI

struct CreateCategoryView: View {
    var body: some View {
        NavigationStack {
            Text("New category")
                .foregroundColor(.mainText)
                .font(FontBook.medium)
                .multilineTextAlignment(.center)
                .padding(.top, 12)
            
            Section(content: {
                colorsGrid
            }, header: {
                SectionHeaderView(title: Constants.colorsTitle)
                    .padding(.horizontal)
            })
            
            Spacer()
        }
    }
    
    private var colorsGrid: some View {
        HStack() {
            ForEach(Constants.colors, id: \.self) { color in
                color
                    .frame(width: 60, height: 60)
                    .cornerRadius(DesignSystem.cornerRadius)
            }
//            Spacer()
        }
    }
}

// MARK: - Constants
extension CreateCategoryView {
    private enum Constants {
        static let colorsTitle = "Choose color"
        static let colors: [Color] = [
            .red,
            .blue,
            .green,
            .orange
        ]
    }
}

// MARK: - Preview
struct CreateCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCategoryView()
    }
}
