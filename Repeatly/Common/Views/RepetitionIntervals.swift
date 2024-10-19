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
    let startDate: Date
    @Binding var intervals: [Int]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(0..<intervals.count, id: \.self) { index in
                let intervalModel = getRepetitionInterval(intervals[index])
                IntervalView(number: "\(index + 1)", model: intervalModel)
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
        let calendar = Calendar.current
        let intervalDate = calendar.date(byAdding: .day, value: interval, to: startDate) ?? Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        let dateString = dateFormatter.string(from: intervalDate)
        
        let intervalString = interval.description + (interval > 1 ? " days" : " day")
        
        return RepetitionInterval(
            interval: intervalString,
            date: dateString)
    }
}

struct IntervalView: View {
    let number: String
    let model: RepetitionInterval
    
    var body: some View {
        HStack {
            HStack {
                circleStatusView
                
                Text(model.interval)
                    .font(FontBook.regular3)
                
                    .foregroundColor(.mainText)
                Text("(\(model.date))")
                    .font(FontBook.regular3)
                    .foregroundColor(.grayText)
            }
            .opacity(model.state == .repeated ? 0.5 : 1)
            
            Spacer()
            
            Button(action: {
//                showAddCategoryScreen.toggle()
            }, label: {
                Image(systemName: "square.and.pencil")
                    .font(.system(size: 14))
                    .foregroundColor(.button)
            })
        }
    }
    
    @ViewBuilder
    private var circleStatusView: some View {
        if model.state == .repeated {
            Image(systemName: "checkmark.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.button)
                .frame(width: 23, height: 30)
        } else {
            Text(number)
                .font(FontBook.regular4)
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
