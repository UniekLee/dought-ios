//
//  TimeCalculator.swift
//  Dought
//
//  Created by Lee Watkins on 05/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import Foundation

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
        formatter.dateFormat = "EEE HH:mm"
        return formatter
    }()
}

enum TimeCalculator {
    static func add(_ durations: [Minutes], to startTime: Date) -> Date {
        let totalDuration = durations.reduce(0, { $0 + $1 })
        return TimeCalculator.add(totalDuration, to: startTime)
    }
    
    static func add(_ minutes: Minutes, to startTime: Date) -> Date {
        return startTime + minutes.asTimeInterval
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
    
    static func todayAtNine() -> Date {
        let today = Date()
        return Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: today) ?? today
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
