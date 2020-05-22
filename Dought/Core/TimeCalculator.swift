//
//  TimeCalculator.swift
//  Dought
//
//  Created by Lee Watkins on 05/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import Foundation
import Time

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

extension Date {    
    private var timeless: Absolute<Day> {
        return Absolute<Day>(region: .current, date: self)
    }
    
    func differenceInDays(to other: Date) -> Int {
        let timelessSelf = self.timeless
        let timelessOther = other.timeless
        
        return timelessSelf.differenceInDays(to: timelessOther).days
    }
    
    func adding(days: Int) -> Date {
        let timePeriod = Absolute<Minute>(region: .current, date: self)
        return timePeriod.adding(days: days).firstInstant.date
    }
    
    var weekdayName: String {
        let period = Absolute<Day>(region: .current, date: self)
        return period.format(weekday: .fullName)
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
        return Clock.system.today().firstInstant.date
    }
    
    static var tomorrow: Date {
        return Clock.system.tomorrow().firstInstant.date
    }
}
