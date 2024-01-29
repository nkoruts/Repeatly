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

let items = [
    CardModel(
        id: 0,
        title: "Заголовок 1",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
        category: "Работа",
        color: ColorSystem.pink),
    CardModel(
        id: 1,
        title: "Заголовок 2",
        description: "Lorem ipsum dolor sit amet, consectetur",
        category: "Учёба",
        color: ColorSystem.lightBlue),
    CardModel(
        id: 2,
        title: "Заголовок 3",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adip",
        category: "Финансы",
        color: ColorSystem.yellow),
    CardModel(
        id: 3,
        title: "Заголовок 3",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adip",
        category: "Финансы",
        color: ColorSystem.green),
    CardModel(
        id: 4,
        title: "Заголовок 3",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adip",
        category: "Финансы",
        color: .accent)
]
