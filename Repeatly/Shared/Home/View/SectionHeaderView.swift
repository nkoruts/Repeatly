//
//  SectionHeaderView.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

struct SectionHeaderView: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.gilroySemiBold(size: 24))
            .foregroundColor(.white)
            Spacer()
        }
        .padding(.top, 8)
    }
}

struct SectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeaderView(title: "Today")
            .background(Color.main)
    }
}
