//
//  NavigationTopView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 31.01.2024.
//

import SwiftUI

typealias Action = () -> Void

struct NavigationTopView: View {
    var title: String
    var backAction: Action
    
    var body: some View {
        HStack {
            Button("", action: backAction)
            .buttonStyle(BackButtonStyle())
            
            Spacer()
            
            Text(title)
                .foregroundColor(ColorSystem.mainText)
                .font(.gilroySemiBold(size: 24))
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct NavigationTopView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTopView(title: "Main Screen", backAction: { })
    }
}
