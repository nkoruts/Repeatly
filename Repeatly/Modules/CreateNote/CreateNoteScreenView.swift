//
//  CreateNoteView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 29.01.2024.
//

import SwiftUI

struct CreateNoteScreenView: View {
    
    // MARK: - Properties
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @State private var showCategories = false
    @State private var showAddCategories = false
    @State private var showDatePicker = false
    
    @State private var title = ""
    @State private var details = ""
    @State private var selectedCategory: Category?
    
    @State private var intervals: [Int] = []
    @State private var selectedIntervalDate = Date()
    
    @FetchRequest(sortDescriptors: [], animation: .spring())
    private var categories: FetchedResults<Category>
    
    @FocusState private var focusedField: FocusedField?
    private enum FocusedField: Hashable {
        case title
        case details
    }
    
    // MARK: - UI
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: Constants.contentSpacing) {
                NavigationTopView(title: Constants.screenTitle) {
                    dismiss()
                }
                .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 8) {
                        Section(content: {
                            CategoriesListView(
                                categories: categories,
                                selectedCategory: $selectedCategory) {
                                    categories.isEmpty ? showAddCategories.toggle() : showCategories.toggle()
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
                            RepetitionIntervalsView(startDate: Date(), intervals: $intervals)
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
                    .padding(.bottom)
                }
                
                Button(Constants.saveButtonTitle) {
                    focusedField = nil
                    saveNote()
                }
                .buttonStyle(MainButtonStyle())
                .disabled(title.isEmpty)
                .padding([.horizontal, .bottom])
            }
            .background(.background)
        }
        .onAppear {
            intervals = getIntervals(forDays: 6)
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $showAddCategories) {
            CreateCategoryScreenView()
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(DesignSystem.cornerRadius)
        }
        .sheet(isPresented: $showCategories) {
            CategoriesScreenView()
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(DesignSystem.cornerRadius)
        }
        .sheet(isPresented: $showDatePicker) {
            let lastInterval = intervals.last ?? 1
            let dateFrom = Calendar.current.date(byAdding: .day, value: lastInterval, to: Date()) ?? Date()
            IntervalPickerView(dateFrom: dateFrom, selectedDate: $selectedIntervalDate)
                .presentationDetents([.medium])
                .presentationDragIndicator(.hidden)
                .presentationCornerRadius(DesignSystem.cornerRadius)
        }
//        .onChange(of: selectedIntervalDate) { date in
//            intervals.append(date)
//        }
    }
    
    // MARK: - Private Methods
    private func saveNote() {
        let newNote = Note(context: viewContext)
        let noteId = UUID()
        newNote.id = noteId
        newNote.title = title
        newNote.details = !details.isEmpty ? details : nil
        newNote.isArchived = false

        // TODO: - Async task
        newNote.category = selectedCategory
        let repetition = createRepetition()
        newNote.repetition = repetition
        RepetitionScheduler.instance.schedule(
            noteId: noteId.uuidString,
            repetitionDate: repetition.nextDate)
        
        do {
            try newNote.save()
            dismiss()
        } catch {
            log(error)
        }
    }
        
    private func createRepetition() -> Repetition {
        let repetition = Repetition(context: viewContext)
        let repetitionConfiguration = RepetitionManager.defaultRepetition
        repetition.startDate = Date()
        repetition.nextDate = repetitionConfiguration.nextDate
        repetition.dayIntervals = repetitionConfiguration.dayIntervals
        return repetition
    }
    
    private func getIntervals(forDays count: Int) -> [Int] {
        var currentInterval: Double = 0
        return (1...count).map { _ in
            currentInterval = 2.5 * currentInterval + 1
            return Int(currentInterval)
        }
    }
}

// MARK: - Constants
extension CreateNoteScreenView {
    private enum Constants {
        static let screenTitle = "Create Note"
        static let contentSpacing: CGFloat = 12
        
        static let categoryTitle = "Category"
        static let noteTitle = "Note title"
        static let repetitionTitle = "Repetition intervals"
        static let titleTextLength = 40
        static let notePlaceholder = "Example: Study"
        static let noteFieldPadding: CGFloat = 12
        
        static let detailsTitle = "Details"
        static let detailsPlaceholder = "Example: Creating a learning space"
        
        static let saveButtonTitle = "Save"
    }
}

// MARK: - Preview
#Preview {
    CreateNoteScreenView()
}
