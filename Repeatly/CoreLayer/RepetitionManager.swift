//
//  RepetitionManager.swift
//  Repeatly
//
//  Created by Nikita Koruts on 21.06.2024.
//

import Foundation

struct RepetitionModel {
    var nextDate: Date
    var dayIntervals: [UInt16]
}

struct RepetitionManager {
    static var defaultRepetition: RepetitionModel {
        let nextDate = Date()
        let repetitionIntervals: [UInt16] = [1, 3, 7, 14, 28, 56]
        return RepetitionModel(nextDate: nextDate, dayIntervals: repetitionIntervals)
    }
}
