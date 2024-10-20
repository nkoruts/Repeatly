//
//  RepetitionIntervals.swift
//  Repeatly
//
//  Created by Nikita Koruts on 14.10.2024.
//

import SwiftUI

enum RepetitionIntervalState {
    case repeated
    case next
}

struct RepetitionInterval: Identifiable {
    let id: String
    let state: RepetitionIntervalState
    let interval: String
    let date: String
    
    init(interval: String, date: String, state: RepetitionIntervalState = .next) {
        self.id = UUID().uuidString
        self.interval = interval
        self.date = date
        self.state = state
    }
}

struct RepetitionIntervalsView: View {
    @Binding var intervals: [Int]
    let startDate: Date
    var currentIntervalIndex: Int = .zero
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(0..<intervals.count, id: \.self) { index in
                let intervalModel = getRepetitionInterval(intervals[index])
                IntervalView(viewModel: .init(
                    number: "\(index + 1)",
                    state: intervalModel.state,
                    interval: intervalModel.interval,
                    date: intervalModel.date,
                    remove: {
                        intervals.remove(at: index)
                    }))
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background {
            RoundedRectangle(cornerRadius: DesignSystem.mediumCornerRadius)
                .stroke(.lightGray)
        }
    }
    
    private func getRepetitionInterval(_ interval: Int) -> RepetitionInterval {
        let intervalDate = Calendar.current.date(byAdding: .day, value: interval, to: startDate) ?? Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        let dateString = dateFormatter.string(from: intervalDate)
        
        let intervalString = "\(interval.description) day"
        let state: RepetitionIntervalState = (intervals.firstIndex(of: interval) ?? 0 >= currentIntervalIndex) ? .next : .repeated
        
        return RepetitionInterval(
            interval: intervalString,
            date: dateString,
            state: state)
    }
}


#Preview {
    RepetitionIntervalsView(
        intervals: Binding(
            get: {
                [1, 3, 5, 7, 14]
            },
            set: { _ in }),
        startDate: Date())
}
