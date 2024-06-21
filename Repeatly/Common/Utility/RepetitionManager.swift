//
//  RepetitionManager.swift
//  Repeatly
//
//  Created by Nikita Koruts on 21.06.2024.
//

import Foundation

struct RepetitionManager {
    static let sharing = RepetitionManager()
    private init() { }
    
    func defaultRepetitionIntervals() -> [Date] {
        let dayIntervals = [1, 3, 7, 14, 28, 56]
        return getTimestamps(for: dayIntervals)
    }
    
    private func getTimestamps(for days: [Int]) -> [Date] {
        var dateComponents = DateComponents()
        let calendar = Calendar.current
        var lastTimestamp = Date()
        
        return days.map {
            dateComponents.day = $0
            lastTimestamp = calendar.date(
                byAdding: dateComponents,
                to: lastTimestamp) ?? Date()
            return lastTimestamp
        }
    }
}
