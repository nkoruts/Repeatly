//
//  CreateNoteView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 29.01.2024.
//

import SwiftUI

struct CreateNoteView: View {
    @State var title = ""
    @State var details = ""
    @State var selectedCategoryId: UUID?
    
    @State var categories: [Category] = []
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 12) {
                NavigationTopView(
                    title: "Create Note",
                    backAction: {
                        dismiss()
                    })
                .padding(.horizontal)
                
                Spacer().frame(height: 16)
                
                Section(content: {
                    CategoriesListView(
                        categories: categories,
                        selection: $selectedCategoryId)
                }, header: {
                    SectionHeaderView(title: "Category")
                        .padding(.horizontal)
                })
                
                Section(content: {
                    TextField("Example: Study", text: $title)
                        .font(.gilroyRegular(size: 16))
                        .padding(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .stroke(Color.lightGray)
                        )
                }, header: {
                    SectionHeaderView(title: "Note title")
                })
                .padding(.horizontal)

                
                Section(content: {
                    MultilineTextView(placeholder: "Example: ...", text: $details)
                        .frame(height: 100)
                }, header: {
                    SectionHeaderView(title: "Details")
                })
                .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    // TODO: - Save note
                    dismiss()
                }, label: {
                    Text("Save")
                        .font(.gilroyMedium(size: 20))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 45)
                        .background(ColorSystem.button)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                        )
                    
                })
                .padding(.horizontal)
            }
            .padding(.vertical)
            .background(ColorSystem.background)
        }
    }
}

struct CreateNoteView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNoteView()
    }
}
