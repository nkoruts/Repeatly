//
//  NavigationTopView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 31.01.2024.
//

import SwiftUI

struct TitledButtonAction {
    let title: String
    let action: Action
}

struct NavigationTopView: View {
    var title: String
    var action: TitledButtonAction?
    var backAction: Action
    
    var body: some View {
        HStack(alignment: .center) {
            BackButton {
                backAction()
            }
            .frame(maxWidth: 75, alignment: .leading)
            
            Text(title)
                .foregroundColor(.mainText)
                .font(FontBook.medium)
                .frame(maxWidth: .infinity, alignment: .center)
            
            HStack {
                if let buttonModel = action {
                    Button(action: {
                        buttonModel.action()
                    }, label: {
                        Text(buttonModel.title)
                            .font(FontBook.regular2)
                    })
                }
            }
            .frame(maxWidth: 75, alignment: .trailing)
        }
    }
}

struct NavigationTopView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTopView(title: "Main Screen", backAction: { })
    }
}
