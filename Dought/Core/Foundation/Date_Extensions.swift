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
    var weekdayName: String {
        let period = Absolute<Day>(region: .current, date: value)
        return period.format(weekday: .fullName)
    }
    
    var time: String {
        let period = Absolute<Minute>(region: .current, date: value)
        return period.format(hour: .twoDigits, minute: .twoDigits)
    }
}
