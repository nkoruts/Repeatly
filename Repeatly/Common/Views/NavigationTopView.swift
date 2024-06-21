//
//  NavigationTopView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 31.01.2024.
//

import SwiftUI

struct NavigationTopView: View {
    var title: String
    var backAction: Action
    
    var body: some View {
        ZStack {
            BackButton(action: backAction)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            Text(title)
                .foregroundColor(.mainText)
                .font(FontBook.medium)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.vertical)
    }
}

struct NavigationTopView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTopView(title: "Main Screen", backAction: { })
    }
}
