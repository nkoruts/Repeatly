//
//  NoteDetailsView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 02.06.2024.
//

import SwiftUI

struct NoteDetailsScreenView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var note: Note
    
    @State private var editNote = false
    
    // MARK: - UI
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: Constants.contentSpacing) {
                navigationView
                
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
        .sheet(isPresented: $editNote) {
            EditNoteScreenView()
                .presentationDetents([.large])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(DesignSystem.cornerRadius)
                .environmentObject(note)
        }
    }
    
    private var navigationView: some View {
        NavigationPanelWithToolbar(title: Constants.screenTitle, dismiss: dismiss) {
            Menu {
                Button {
                    editNote = true
                } label: {
                    Label("Edit Note", systemImage: "pencil")
                }
                
                Button(role: .destructive) {
                    removeNote()
                } label: {
                    Label("Delete Note", systemImage: "trash")
                }
            } label: {
                Image(systemName: "ellipsis.circle")
                    .foregroundColor(.button)
            }
        }
    }
    
    // MARK: - Private Methods
    private func updateRepetition() {
        do {
            try note.updateRepetition()
            RepetitionScheduler.instance.update(noteId: note.id.uuidString, repetitionDate: note.repetition.nextDate)
            note.repetition.managedObjectContext?.refresh(note, mergeChanges: true)
            dismiss()
        } catch {
            log(error)
        }
    }
    
    private func removeNote() {
        do {
            try note.delete()
            dismiss()
        } catch {
            log(error)
        }
    }
}

// MARK: - Constants
extension NoteDetailsScreenView {
    private enum Constants {
        static let contentSpacing: CGFloat = 8
        static let staticNavWidth: CGFloat = 75
        static let screenTitle = "Note details"
        static let editButtonTitle = "Edit"
    }
}
