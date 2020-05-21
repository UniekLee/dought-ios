//
//  Bake.swift
//  Dought
//
//  Created by Lee Watkins on 21/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import Foundation
import SwiftDate

struct Bake {
    let schedule: Schedule
    let start: Date
}

extension Bake {
    // TODO: Move this into a VM
    func date(of stage: Schedule.Stage) -> String {
        return DateInRegion((start + day(of: stage).days)).weekdayName(.default)
    }
    
    private func day(of stage: Schedule.Stage) -> Int {
        guard
            let givenStep = stage.steps.first
            else { return 0 }
        
        let daysDuration = TimeCalculator.numberOfDays(from: start, secondDate: givenStep.startTime)
        
        return daysDuration
    }
}
