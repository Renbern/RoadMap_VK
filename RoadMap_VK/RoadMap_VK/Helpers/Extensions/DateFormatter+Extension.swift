// DateFormatter+Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Расширение для приведения даты в подходящий вид
extension DateFormatter {
    private enum DateFormat {
        static let dateFormat = "MMM d, h:mm a"
    }

    func convert(date: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.dateFormat
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}
