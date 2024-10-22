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
    @State private var repetitionIntervalsWereEdited = false
    
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
                    .disabled(title.isEmpty || intervals.isEmpty)
                }
                .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 8) {
                        categoriesSection
                        titleSection
                        detailsSection
                        repetitionIntervalsSection
                    }
                }
            }
            .background(.background)
            .onTapGesture {
                focusedField = nil
            }
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
                repetitionIntervalsWereEdited = true
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
    
    private var categoriesSection: some View {
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
    }
    
    private var titleSection: some View {
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
            SectionHeaderView(title: Constants.noteTitle, mandatory: true)
                .font(FontBook.regular2)
        })
        .padding(.horizontal)
    }
    
    private var detailsSection: some View {
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
    }
    
    private var repetitionIntervalsSection: some View {
        Section(content: {
            RepetitionIntervalsView(
                intervals: $intervals,
                startDate: Date(),
                currentIntervalIndex: Int(note.repetition.currentIntervalIndex),
                removeAction: {
                    repetitionIntervalsWereEdited = true
                })
            .isHidden(intervals.isEmpty)
        }, header: {
            HStack(alignment: .lastTextBaseline) {
                SectionHeaderView(title: Constants.repetitionTitle, mandatory: true)
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
    
    // MARK: - Private Methods
    private func saveNote() {
        note.title = title
        note.details = details
        note.details = !details.isEmpty ? details : nil
        note.category = selectedCategory
        
        if repetitionIntervalsWereEdited {
            note.repetition.dayIntervals = intervals.map { Int16($0) }
            if intervals.count < note.repetition.currentIntervalIndex + 1 {
                note.isArchived = true
                note.repetition.currentIntervalIndex = -1
            } else {
                let currentInterval = note.repetition.dayIntervals[Int(note.repetition.currentIntervalIndex)]
                let nextDate = Calendar.current.date(
                    byAdding: .day,
                    value: Int(currentInterval),
                    to: note.repetition.startDate) ?? Date()
                note.repetition.nextDate = nextDate
            }
        }
        
        do {
            try note.save()
            note.repetition.managedObjectContext?.refresh(note, mergeChanges: true)
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
