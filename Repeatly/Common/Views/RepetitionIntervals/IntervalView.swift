//
//  IntervalView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 20.10.2024.
//

import SwiftUI

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
                .frame(width: 18, height: 23)
        } else {
            Text(viewModel.number)
                .font(.gilroyRegular(size: 10))
                .foregroundColor(.mainText)
//                .padding(6)
                .frame(width: 18, height: 23)
                .background {
                    Circle()
                        .strokeBorder(ColorSystem.button.color, lineWidth: 1)
                        .background(Circle().fill(.lightButton))
                }
        }
    }
}
