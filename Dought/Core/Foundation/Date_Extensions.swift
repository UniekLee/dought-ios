//
//  Date_Extensions.swift
//  Dought
//
//  Created by Lee Watkins on 05/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import Foundation
import Time

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

    static var today: Date {
        return Clock.system.today().firstInstant.date
    }
    
    static var tomorrow: Date {
        return Clock.system.tomorrow().firstInstant.date
    }
}
