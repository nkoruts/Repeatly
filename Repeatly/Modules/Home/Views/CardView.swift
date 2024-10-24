//
//  ListItemView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

struct CardView: View {
    let note: Note
    let repeatAction: Action
    let removeAction: Action
    
    @State var cardOffset: CGFloat = 0
    @State var isSwipped: Bool = false
    
    var body: some View {
        ZStack {
            dragMenu
            
            HStack(spacing: Constants.mainStackSpacing) {
                Capsule()
                    .fill(Color(hex: note.category?.colorHex ?? ColorSystem.lightGray.hex))
                    .frame(width: Constants.dividerWidth)
                    .padding(.leading, Constants.dividerLeadingPadding)
                    .padding(.vertical, Constants.dividerVerticalPadding)
                
                VStack(alignment: .leading, spacing: Constants.infoSpacing) {
                    if let category = note.category {
                        NoteCategoryView(
                            title: category.name,
                            color: Color(hex: category.colorHex))
                        .padding(.bottom, Constants.infoSpacing)
                    }
                    
                    Text(note.title)
                        .font(FontBook.medium2)
                        .foregroundColor(.mainText)
                    
                    if let details = note.details {
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
            .background {
                RoundedRectangle(cornerRadius: DesignSystem.cornerRadius)
                    .fill(.cardBackground)
            }
            .shadow(color: ColorSystem.shadow.color, radius: Constants.shadowRadius)
            .offset(x: cardOffset)
            .gesture(
                DragGesture()
                    .onChanged(dragOnChange(_:))
                    .onEnded(dragOnEnd(_:)))
        }
    }
    
    private var dragMenu: some View {
        HStack(spacing: 10) {
            Spacer()

            ColorIconButton(
                iconName: "checkmark",
                color: .green,
                action: {
                    withAnimation {
                        cardOffset = .zero
                        isSwipped = false
                    }
                    repeatAction()
                })
            .scaleEffect(safeScale(for: cardOffset))
           
            ColorIconButton(
                iconName: "trash",
                color: .red,
                action: removeAction)
            .scaleEffect(safeScale(for: cardOffset))
        }
    }
    
    // MARK: - Private Methods
    private func dragOnChange(_ value: DragGesture.Value) {
        let offset = value.translation.width
        if offset < .zero {
            cardOffset = isSwipped ? offset - Constants.dragLimit : offset
        } else {
            cardOffset = isSwipped ? min(0, offset - Constants.dragLimit) : .zero
        }
    }
    
    private func dragOnEnd(_ value: DragGesture.Value) {
        let offset = value.translation.width
        withAnimation(.easeInOut) {
            let isSwipeGestureLong = offset < -60
            cardOffset = isSwipeGestureLong ? -Constants.dragLimit : .zero
            isSwipped = isSwipeGestureLong
        }
    }
    
    private func safeScale(for offset: CGFloat) -> CGFloat {
        let scale = abs(offset / 90)
        return min(1, max(0.1, scale))
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
        
        static let dragLimit: CGFloat = 110
        
        static let arrowIconName = "chevron.forward"
    }
}

#Preview {
    let viewContent = CoreDataProvider.shared.viewContext
    let note = Note(context: viewContent)
    note.title = "Title"
    return CardView(note: note, repeatAction: {}, removeAction: {})
}
