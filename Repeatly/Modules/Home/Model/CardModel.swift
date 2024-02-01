//
//  ListItem.swift
//  Repeatly
//
//  Created by Nikita Koruts on 27.01.2024.
//

import SwiftUI

struct CardModel: Identifiable {
    let id: Int
    let title: String
    let details: String?
    let category: CardCategory
}

struct CardCategory {
    let name: String?
    let color: Color
}
