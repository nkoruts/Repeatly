//
//  NoteDetailsView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 02.06.2024.
//

import SwiftUI

struct NoteDetailsView: View {
    @Environment(\.dismiss) var dismiss
    let note: Note
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: Constants.contentSpacing) {
                NavigationTopView(
                    title: Constants.screenTitle,
                    action: .init(title: "Edit", action: {  })
                ) {
                    dismiss()
                }
                .padding(.bottom)
                
                if let category = note.category {
                    NoteCategoryView(
                        title: category.name,
                        color: Color(hex: category.colorHex))
                }

                Text(note.title)
                    .font(FontBook.regular)
                    .foregroundColor(.mainText)
                
                if let details = note.details {
                    Text(details)
                        .font(.gilroyRegular(size: 15))
                        .foregroundColor(.mainText)
                }
                
                Spacer()
                
                Button("Repeat") {
                    updateRepetition()
                }
                .buttonStyle(MainButtonStyle())
                .padding(.bottom)
            }
            .padding(.horizontal)
            .background(.background)
        }
        .navigationBarBackButtonHidden()
    }
    
    // MARK: - Private Methods
    private func updateRepetition() {
        do {
            try note.updateRepetition()
            note.repetition.managedObjectContext?.refresh(note, mergeChanges: true)
            dismiss()
        } catch {
            log(error)
        }
    }
}

// MARK: - Constants
extension NoteDetailsView {
    private enum Constants {
        static let contentSpacing: CGFloat = 8
        static let staticNavWidth: CGFloat = 75
        static let screenTitle = "Note details"
        static let editButtonTitle = "Edit"
    }
}

#Preview {
    let viewContext = CoreDataProvider.shared.viewContext
    let note = Note(context: viewContext)
    note.id = UUID()
    note.title = "Long title for testing"
    note.details = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc sit amet maximus risus. Maecenas feugiat dui tincidunt mi lacinia aliquet. Mauris a pretium arcu. Pellentesque laoreet ut felis interdum pretium.\n\nEtiam sed ullamcorper nisi, in ornare lorem. Mauris eleifend erat sed semper euismod. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas."
    let category = Category(context: viewContext)
    category.id = UUID()
    category.name = "Category"
    category.colorHex = 0xC62828
    note.category = category
    return NoteDetailsView(note: note)
}
