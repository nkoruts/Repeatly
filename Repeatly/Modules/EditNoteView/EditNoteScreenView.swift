//
//  EditNoteView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 17.06.2024.
//

import SwiftUI

struct EditNoteScreenView: View {
    
    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss
    @State var showCategories = false
    @State var showDatePicker = false
    
    @EnvironmentObject var note: Note
    
    @State private var title: String = ""
    @State private var details = ""
    @State private var selectedCategory: Category?
    @State private var intervals: [Int] = []
    
    @FetchRequest(sortDescriptors: [], animation: .spring)
    private var categories: FetchedResults<Category>
    
    @FocusState private var focusedField: FocusedField?
    private enum FocusedField: Hashable {
        case title
        case details
    }
    
    
    // MARK: - UI
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: .zero) {
                
                ModalNavigationView(title: Constants.screenTitle) {
                    Button(action: {
                        focusedField = nil
                        saveNote()
                    }, label: {
                        Text("Save")
                            .font(FontBook.medium2)
                    })
                    .disabled(title.isEmpty)
                }
                .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 8) {
                        Section(content: {
                            CategoriesListView(
                                categories: categories,
                                selectedCategory: $selectedCategory) {
                                    showCategories.toggle()
                                }
                        }, header: {
                            SectionHeaderView(title: Constants.categoryTitle)
                                .font(FontBook.regular2)
                                .padding(.horizontal)
                        })
                        
                        Section(content: {
                            TextField(Constants.notePlaceholder, text: $title)
                                .textLimit(Constants.titleTextLength, $title)
                                .textFieldStyle(BorderedTextFieldStyle())
                                .focused($focusedField, equals: .title)
                                .submitLabel(.next)
                                .onSubmit {
                                    focusedField = .details
                                }
                        }, header: {
                            SectionHeaderView(title: Constants.noteTitle)
                                .font(FontBook.regular2)
                        })
                        .padding(.horizontal)
                        
                        Section(content: {
                            TextField(
                                Constants.detailsPlaceholder,
                                text: $details,
                                axis: .vertical)
                            .lineLimit(5, reservesSpace: true)
                            .textFieldStyle(BorderedTextFieldStyle())
                            .focused($focusedField, equals: .details)
                            .submitLabel(.continue)
                            .onSubmit {
                                focusedField = title.isEmpty ? .title : nil
                            }
                        }, header: {
                            SectionHeaderView(title: Constants.detailsTitle)
                                .font(FontBook.regular2)
                        })
                        .padding(.horizontal)
                        
                        Section(content: {
                            RepetitionIntervalsView(
                                intervals: $intervals,
                                startDate: Date(),
                                currentIntervalIndex: Int(note.repetition.currentIntervalIndex))
                        }, header: {
                            HStack(alignment: .lastTextBaseline) {
                                SectionHeaderView(title: Constants.repetitionTitle)
                                    .font(FontBook.regular2)
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        showDatePicker.toggle()
                                    }, label: {
                                        HStack(spacing: 4) {
                                            Image(systemName: "plus")
                                            Text("Add interval")
                                        }
                                        .font(FontBook.regular3)
                                        .foregroundColor(.button)
                                    })
                                }
                            }
                            
                        })
                        .padding(.horizontal)
                    }
                }
            }
            .background(.background)
        }
        .sheet(isPresented: $showCategories) {
            CategoriesScreenView()
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(DesignSystem.cornerRadius)
        }
        .sheet(isPresented: $showDatePicker) {
            IntervalPickerView { selectedDate in
                let newInterval = Calendar.current.dateComponents([.day], from: Date().startOfDay, to: selectedDate).day ?? 0
                intervals.append(newInterval)
                intervals.sort()
            }
            .presentationDetents([.medium])
            .presentationDragIndicator(.hidden)
            .presentationCornerRadius(DesignSystem.cornerRadius)
        }
        .onAppear {
            title = note.title
            details = note.details ?? ""
            selectedCategory = note.category
            intervals = note.repetition.dayIntervals.map { Int($0) }
        }
    }
    
    // MARK: - Private Methods
    private func saveNote() {
        note.title = title
        note.details = details
        note.details = !details.isEmpty ? details : nil
        note.category = selectedCategory
        
        do {
            try note.save()
            dismiss()
        } catch {
            log(error)
        }
    }
}

// MARK: - Constants
extension EditNoteScreenView {
    private enum Constants {
        static let screenTitle = "Edit Note"
        
        static let categoryTitle = "Category"
        static let noteTitle = "Note title"
        static let titleTextLength = 40
        static let notePlaceholder = "Example: Study"
        static let noteFieldPadding: CGFloat = 12
        
        static let detailsTitle = "Details"
        static let detailsPlaceholder = "Example: Creating a learning space"
        
        static let repetitionTitle = "Repetition intervals"
        
        static let saveButtonTitle = "Save"
    }
}
