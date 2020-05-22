//
//  Date_Extensions.swift
//  Dought
//
//  Created by Lee Watkins on 05/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import Foundation
import Time

// MARK: - Convenience

extension Date {
    private var timeless: Absolute<Day> {
        return Absolute<Day>(region: .current, date: self)
    }

    static var today: Date {
        return Clock.system.today().firstInstant.date
    }
    
    static var tomorrow: Date {
        return Clock.system.tomorrow().firstInstant.date
    }
    
    var formatter: Formatter<Date> {
        return Formatter(value: self)
    }
    
    var weekAhead: [Date] {
        let today = Absolute<Day>(region: .current, date: self)
        let inAWeek = today.adding(days: 6)
        
        let week = today...inAWeek
        let daysThisWeek = AbsoluteTimePeriodSequence<Day>(range: week, stride: .days(1))
        
        return daysThisWeek.map({ $0.firstInstant.date })
    }
}

// MARK: - Calculations

extension Date {
    func differenceInDays(to other: Date) -> Int {
        let timelessSelf = self.timeless
        let timelessOther = other.timeless
        
        return timelessSelf.differenceInDays(to: timelessOther).days
    }
    
    func adding(days: Int) -> Date {
        let timePeriod = Absolute<Minute>(region: .current, date: self)
        return timePeriod.adding(days: days).firstInstant.date
    }
}

// MARK: - Formatters

extension Formatter where T == Date {
    var weekdayTagName: String {
        let period = Absolute<Day>(region: .current, date: value)
        
        return shortWeekdayName + ", " + period.format(month: .abbreviatedName, day: .full)
    }
    
    var weekdayName: String {
        let period = Absolute<Day>(region: .current, date: value)
        
        return weekdayRelativeName ?? period.format(weekday: .fullName)
    }
    
    private var shortWeekdayName: String {
        let period = Absolute<Day>(region: .current, date: value)
        
        return weekdayRelativeName ?? period.format(weekday: .abbreviatedName)
    }
    
    private var weekdayRelativeName: String? {
        let period = Absolute<Day>(region: .current, date: value)
        
        if period.differenceInDays(to: Clock.system.today()).days == 0 {
            return "Today"
        } else if period.differenceInDays(to: Clock.system.tomorrow()).days == 0 {
            return "Tomorrow"
        } else {
            return nil
        }
    }
    
    var time: String {
        let period = Absolute<Minute>(region: .current, date: value)
        return period.format(hour: .twoDigits, minute: .twoDigits)
    }
    
    var dateTime: String {
        let period = Absolute<Minute>(region: .current, date: value)
        
        return period.format(year: .full,
                             month: .abbreviatedName,
                             day: .twoDigits,
                             hour: .twoDigits,
                             minute: .twoDigits)
    }
}
