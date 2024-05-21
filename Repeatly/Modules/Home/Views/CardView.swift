//
//  ListItemView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

struct CardViewModel {
    var note: Note
    var removeAction: () -> Void
    
    var color: Color {
        if let hexColor = note.category?.colorHex {
            return Color(hex: hexColor)
        }
        return Color(hex: ColorSystem.lightGray.hex)
    }
}

struct CardView: View {
    var viewModel: CardViewModel
    
    @State var cardOffset: CGFloat = 0
    @State var isSwipped: Bool = false
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                
                Button(action: viewModel.removeAction) {
                    Image(systemName: "trash")
                        .font(.title3)
                        .foregroundColor(.red)
                        .padding()
                        .background(
                            Circle()
                                .fill(.red.opacity(0.15))
                        )
                        .scaleEffect(min(1, max(0.001, abs(cardOffset / 90))))
                }
            }
            
            HStack(spacing: Constants.mainStackSpacing) {
                Capsule()
                    .fill(viewModel.color)
                    .frame(width: Constants.dividerWidth)
                    .padding(.leading, Constants.dividerLeadingPadding)
                    .padding(.vertical, Constants.dividerVerticalPadding)
                
                VStack(alignment: .leading, spacing: Constants.infoSpacing) {
                    if let category = viewModel.note.category {
                        NoteCategoryView(
                            title: category.name,
                            color: Color(hex: category.colorHex))
                        .padding(.bottom, Constants.infoSpacing)
                    }
                    
                    Text(viewModel.note.title)
                        .font(FontBook.medium2)
                        .foregroundColor(.mainText)
                    
                    if let details = viewModel.note.details {
                        Text(details)
                            .font(FontBook.regular3)
                            .foregroundColor(.grayText)
                            .lineLimit(Constants.detailsLineLimit)
                    }
                }
                .padding([.vertical, .trailing], Constants.defaultPadding)
                
                Spacer()
                
                Image(systemName: Constants.arrowIconName)
                    .foregroundColor(.icon)
                    .padding(.trailing, Constants.defaultPadding)
            }
            .background(
                RoundedRectangle(
                    cornerRadius: DesignSystem.cornerRadius,
                    style: .continuous)
                .fill(.cardBackground))
            .shadow(
                color: Color(hex: ColorSystem.shadow.hex),
                radius: Constants.shadowRadius)
            .offset(x: cardOffset)
            .gesture(
                DragGesture()
                    .onChanged(dragOnChange(_:))
                    .onEnded(dragOnEnd(_:)))
        }
    }
    
    private func dragOnChange(_ value: DragGesture.Value) {
        let offset = value.translation.width
        
        if offset < .zero {
            cardOffset = isSwipped ? offset - 90 : offset
        } else {
            cardOffset = isSwipped ? min(0, offset - 90) : .zero
        }
    }
    
    private func dragOnEnd(_ value: DragGesture.Value) {
        let offset = value.translation.width
        withAnimation(.easeInOut) {
            let isSwipeGestureLong = offset < -60
            cardOffset = isSwipeGestureLong ? -90 : .zero
            isSwipped = isSwipeGestureLong
        }
    }
}

extension CardView {
    private enum Constants {
        static let mainStackSpacing: CGFloat = 12
        static let defaultPadding: CGFloat = 16
        static let shadowRadius: CGFloat = 8
        
        static let dividerWidth: CGFloat = 4
        static let dividerLeadingPadding: CGFloat = 12
        static let dividerVerticalPadding: CGFloat = 16
        static let infoSpacing: CGFloat = 4
        static let detailsLineLimit = 2
        
        static let arrowIconName = "chevron.forward"
    }
}
