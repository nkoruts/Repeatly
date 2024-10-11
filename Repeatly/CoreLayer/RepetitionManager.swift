//
//  RepetitionManager.swift
//  Repeatly
//
//  Created by Nikita Koruts on 21.06.2024.
//

import Foundation

struct RepetitionModel {
    var nextDate: Date
    var dayIntervals: [Int16]
}

struct RepetitionManager {
    static var defaultRepetition: RepetitionModel {
        let nextDate = Date()
        let repetitionIntervals: [Int16] = [1, 3, 7, 14, 28, 56]
        return RepetitionModel(nextDate: nextDate, dayIntervals: repetitionIntervals)
    }
}
