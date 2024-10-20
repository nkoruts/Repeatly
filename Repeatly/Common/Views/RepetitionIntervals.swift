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
        let state: RepetitionIntervalState = (intervals.firstIndex(of: interval) ?? 0 > currentIntervalIndex) ? .next : .repeated
        
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

struct IntervalViewModel {
    let number: String
    let state: RepetitionIntervalState
    let interval: String
    let date: String
    let remove: Action
}

struct IntervalView: View {
    @State private var showPanel = false
    let viewModel: IntervalViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            circleStatusView
                .padding(.trailing, 2)
            
            HStack {
                Text(viewModel.interval)
                    .font(FontBook.regular3)
                    .foregroundColor(.mainText)
                Text("(\(viewModel.date))")
                    .font(FontBook.regular3)
                    .foregroundColor(.grayText)
                
                Spacer()
                
                Button(action: {
                    viewModel.remove()
                    showPanel.toggle()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.grayText)
                })
            }
            .opacity(viewModel.state == .repeated ? 0.5 : 1)
        }
    }
    
    @ViewBuilder
    private var circleStatusView: some View {
        if viewModel.state == .repeated {
            Image(systemName: "checkmark.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.button)
                .frame(width: 18, height: 30)
        } else {
            Text(viewModel.number)
                .font(.gilroyRegular(size: 10))
                .foregroundColor(.mainText)
                .padding(6)
                .background {
                    Circle()
                        .strokeBorder(ColorSystem.button.color, lineWidth: 1)
                        .background(Circle().fill(.lightButton))
                }
        }
    }
}
