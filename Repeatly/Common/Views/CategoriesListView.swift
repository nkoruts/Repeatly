//
//  CategoriesListView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 02.02.2024.
//

import SwiftUI

struct CategoriesListView: View {
    var categories: [Category]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(categories) { caterory in
                    CategoryView(
                        title: caterory.name,
                        color: Color(hex: caterory.color)) {
                    }
                }
                
                Button(action: {
    //                willMoveToNoteCreation = true
                }, label: {
                    Image(systemName: "plus.app.fill")
//                        .font(.system(size: 34))
                        .font(.gilroyRegular(size: 14))
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(ColorSystem.blueButton)
                        )
                })
            }
        }
    }
}

struct CategoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesListView(categories: categories)
    }
}

