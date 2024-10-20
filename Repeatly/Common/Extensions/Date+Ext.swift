//
//  Date+Ext.swift
//  Repeatly
//
//  Created by Nikita Koruts on 20.10.2024.
//

import Foundation

extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
    
}
