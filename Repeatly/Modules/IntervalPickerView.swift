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
    
    let dateFrom: Date
    @Binding var selectedDate: Date
    
    // MARK: - UI
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ModalNavigationView(title: "Next repetition date") {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Save")
                            .font(FontBook.medium2)
                    })
                }
                
                ScrollView {
                    DatePicker(
                        "",
                        selection: $selectedDate,
                        in: dateFrom...,
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
    IntervalPickerView(
        dateFrom: Date(),
        selectedDate: Binding(
            get: { Date() },
            set: {_ in }))
}
