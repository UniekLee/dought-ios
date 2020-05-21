//
//  TimeCalculator.swift
//  Dought
//
//  Created by Lee Watkins on 05/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import Foundation
import SwiftDate

typealias Minutes = Int

class Formatters {
    enum FormatterError: Error {
        case failed
    }
    
    static let shared: Formatters = Formatters()
    
    lazy var plusHMinFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    lazy var stepStartTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
}

enum TimeCalculator {
    static func add(_ durations: [Minutes], to startTime: Date) -> Date {
        let totalDuration = durations.reduce(0, { $0 + $1 })
        return TimeCalculator.add(totalDuration, to: startTime)
    }
    
    static func add(_ minutes: Minutes, to startTime: Date) -> Date {
        return (startTime + minutes.minutes)
    }
    
    static func formatted(duration: Minutes) throws -> String {
        let formatter = Formatters.shared.plusHMinFormatter
        let interval = duration.asTimeInterval
        
        guard let result = formatter.string(from: interval) else {
            throw Formatters.FormatterError.failed
        }
        
        return result
    }
    
    static func formatted(startTime: Date) -> String {
        let formatter = Formatters.shared.stepStartTimeFormatter
        
        return formatter.string(from: startTime)
    }
    
    static func timelessVersion(of date: Date) -> Date {
        let calendar = Calendar.current
        let timelessComponents = calendar.dateComponents([.day, .month, .year], from: date)
        guard let timeless = calendar.date(from: timelessComponents) else {
            fatalError("Failed to remove time from date")
        }
        
        return timeless
    }
    
    static func numberOfDays(from firstDate: Date, secondDate: Date) -> Int {
        let firstTimelessDate = TimeCalculator.timelessVersion(of: firstDate)
        let secondTimelessDate = TimeCalculator.timelessVersion(of: secondDate)
        
        guard let daysDuration = Calendar.current.dateComponents([.day],
                                                           from: firstTimelessDate,
                                                           to: secondTimelessDate).day
            else { fatalError("Unable to calculate the number of days between two dates") }
        
        return daysDuration
    }
}

extension Minutes {
    typealias Seconds = Int
    
    var asTimeInterval: TimeInterval {
        return TimeInterval(integerLiteral: Int64(self.asSeconds))
    }
    
    var asSeconds: Seconds {
        return self * 60
    }
}

extension Date {
    static var today: Date {
        return DateInRegion().dateAt(.startOfDay).date
    }
    
    static var tomorrow: Date {
        return DateInRegion().dateAt(.tomorrowAtStart).date
    }
}
