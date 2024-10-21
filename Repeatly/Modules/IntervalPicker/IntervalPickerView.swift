//
//  IntervalPickerView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 18.10.2024.
//

import SwiftUI

struct IntervalPickerView: View {
    
    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedDate: Date = Date()
    @State private var day: Int = .zero
    
    let onSelection: (Date) -> Void
    
    // MARK: - UI
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                ModalNavigationView(title: "Next repetition date") {
                    Button(action: {
                        onSelection(selectedDate)
                        dismiss()
                    }, label: {
                        Text("Save")
                            .font(FontBook.medium2)
                    })
                }
                
                Text("Day: \(day)")
                    .foregroundColor(.mainText)
                    .font(FontBook.regular2)
                
                ScrollView {
                    DatePicker(
                        "",
                        selection: Binding(
                            get: { selectedDate },
                            set: { newDate in
                                let calendar = Calendar.current
                                day = calendar.dateComponents([.day], from: Date().startOfDay, to: newDate).day ?? .zero
                                selectedDate = newDate
                            }),
                        in: Date()...,
                        displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .labelsHidden()
                }
            }
            .padding(.horizontal)
            .background(.background)
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    IntervalPickerView(onSelection: { _ in })
}
