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
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 8) {
                NavigationTopView(
                    title: "Create Note",
                    backAction: {
                        dismiss()
                    })
                
                Spacer().frame(height: 32)
                
                Section(content: {
                    TextField("Example: Study", text: $title)
                        .font(.gilroyRegular(size: 16))
                        .padding(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.lightGray)
                        )
                }, header: {
                    SectionHeaderView(title: "Note title")
                })
                
                Section(content: {
                    MultilineTextView(placeholder: "Example: ...", text: $details)
                        .frame(height: 100)
                }, header: {
                    SectionHeaderView(title: "Details")
                })
                
                Spacer()
            }
            .padding()
            .background(ColorSystem.background)
        }
    }
}

struct CreateNoteView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNoteView()
    }
}
