//
//  ListItemView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

struct CardViewModel {
    var note: Note
    var category: Category?
}

struct CardView: View {
    var viewModel: CardViewModel
    
    @State var cardOffset: CGFloat = 0
    @State var isSwipped: Bool = false
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "trash")
                        .font(.title3)
                        .foregroundColor(.red)
                        .padding()
                        .background(
                            Circle()
                                .fill(.red.opacity(0.15))
                        )
                }
            }
            
            HStack(spacing: Constants.mainStackSpacing) {
                Capsule()
                    .fill(Color(viewModel.note.color))
                    .frame(width: Constants.dividerWidth)
                    .padding(.leading, Constants.dividerLeadingPadding)
                    .padding(.vertical, Constants.dividerVerticalPadding)
                
                VStack(alignment: .leading, spacing: Constants.infoSpacing) {
                    if let category = viewModel.category {
                        NoteCategoryView(
                            title: category.name,
                            color: Color(category.color))
                        .padding(.bottom, Constants.infoSpacing)
                    }
                    
                    Text(viewModel.note.title)
                        .font(FontBook.medium2)
                        .foregroundColor(ColorSystem.mainText.color)
                    
                    if let details = viewModel.note.details {
                        Text(details)
                            .font(FontBook.regular3)
                            .foregroundColor(ColorSystem.grayText.color)
                            .lineLimit(Constants.detailsLineLimit)
                    }
                }
                .padding([.vertical, .trailing], Constants.defaultPadding)
                
                Spacer()
                
                Image(systemName: Constants.arrowIconName)
                    .foregroundColor(ColorSystem.icon.color)
                    .padding(.trailing, Constants.defaultPadding)
            }
            .background(
                RoundedRectangle(
                    cornerRadius: DesignSystem.cornerRadius,
                    style: .continuous)
                .fill(ColorSystem.cardBackground.color))
            .shadow(
                color: ColorSystem.shadow.color,
                radius: Constants.shadowRadius)
            .offset(x: cardOffset)
            .gesture(
                DragGesture()
                    .onChanged(dragOnChange(_:))
                    .onEnded(dragOnEnd(_:)))
        }
    }
    
    func dragOnChange(_ value: DragGesture.Value) {
        let offset = value.translation.width
        print(offset)
        
        if offset < .zero, offset > -90 {
            cardOffset = isSwipped ? offset - 90 : offset
        } else if offset > .zero, isSwipped {
            cardOffset = cardOffset + offset
        }
//        if offset > 0, !isSwipped {
//            return
//        } else if offset > -90 {
//            cardOffset = isSwipped ? offset - 90 : offset
//        }
    }
    
    func dragOnEnd(_ value: DragGesture.Value) {
        let offset = value.translation.width
        withAnimation(.easeInOut) {
            if offset > 0 {
                cardOffset = .zero
                isSwipped = false
            } else if cardOffset < -50 {
                cardOffset = -90
                isSwipped = true
            }
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
