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
    let description: String?
    let category: String?
    let color: Color
}
