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
    
    var body: some View {
        HStack(spacing: Constants.mainStackSpacing) {
            Capsule()
                .fill(Color(viewModel.note.color))
                .frame(width: Constants.dividerWidth)
                .padding(.leading, Constants.dividerLeadingPadding)
                .padding(.vertical, Constants.dividerVerticalPadding)
            
            VStack(alignment: .leading, spacing: Constants.infoSpacing) {
//                if let category = viewModel.note.category {
//                    NoteCategoryView(
//                        title: category.name,
//                        color: Color(category.color))
//                    .padding(.bottom, Constants.infoSpacing)
//                }
                
                Text(viewModel.note.title)
                    .font(Constants.titleFont)
                    .foregroundColor(ColorSystem.mainText)
                
                if let details = viewModel.note.details {
                    Text(details)
                        .font(Constants.detailsFont)
                        .foregroundColor(ColorSystem.grayText)
                        .lineLimit(Constants.detailsLineLimit)
                }
            }
            .padding([.vertical, .trailing], Constants.defaultPadding)
            
            Spacer()
            
            Image(systemName: Constants.arrowIconName)
                .foregroundColor(ColorSystem.icon)
                .padding(.trailing, Constants.defaultPadding)
        }
        .background(ColorSystem.cardBackground)
        .clipShape(
            RoundedRectangle(
                cornerRadius: Constants.cornerRadius,
                style: .continuous)
        )
        .shadow(color: ColorSystem.shadow, radius: Constants.shadowRadius)
        
    }
}

extension CardView {
    private enum Constants {
        static let mainStackSpacing: CGFloat = 12
        static let defaultPadding: CGFloat = 16
        static let cornerRadius: CGFloat = 18
        static let shadowRadius: CGFloat = 8
        
        static let dividerWidth: CGFloat = 4
        static let dividerLeadingPadding: CGFloat = 12
        static let dividerVerticalPadding: CGFloat = 16
        
        static let infoSpacing: CGFloat = 4
        
        static let titleFont: Font = .gilroyMedium(size: 18)
        static let detailsFont: Font = .gilroyRegular(size: 14)
        static let detailsLineLimit = 2
        
        static let arrowIconName = "chevron.forward"
    }
}
