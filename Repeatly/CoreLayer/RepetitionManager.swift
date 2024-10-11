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
        let repetitionIntervals: [Int16] = [1, 3, 7, 14, 28, 56]
        let firstInterval = Int(repetitionIntervals[0])
        let nextDate = Calendar.current.date(byAdding: .day, value: firstInterval, to: Date()) ?? Date()
        let day = Calendar.current.startOfDay(for: nextDate)
        return RepetitionModel(nextDate: day, dayIntervals: repetitionIntervals)
    }
}
