// DateFormatter_Extension.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

extension DateFormatter {
    func changeDateFormat(date: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}
