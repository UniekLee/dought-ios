//
//  Bake.swift
//  Dought
//
//  Created by Lee Watkins on 21/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import Foundation

struct Bake {
    var start: Date {
        return schedule.start
    }
    
    let schedule: Schedule
    
    init(schedule: Schedule, start: Date) {
        self.schedule = schedule.adjustedTo(startDate: start)
    }
}

fileprivate extension Schedule {
    var start: Date {
        return stages.first?.steps.first?.startTime ?? Date()
    }
    
    func adjustedTo(startDate: Date) -> Schedule {
        let difference = start.differenceInDays(to: startDate)
        
        var newSchedule = self
        newSchedule.stages = stages.map { stage in
            var newStage = stage
            newStage.steps = stage.steps.map { step in
                var newStep = step
                newStep.startTime = step.startTime.adding(days: difference)
                return newStep
            }
            return newStage
        }
        return newSchedule
    }
}

extension Bake {
    // TODO: Move this into a VM
    func date(of stage: Schedule.Stage) -> String {
        return start.adding(days: day(of: stage)).formatter.weekdayName
    }
    
    private func day(of stage: Schedule.Stage) -> Int {
        guard
            let givenStep = stage.steps.first
            else { return 0 }
        
        let daysDuration = start.differenceInDays(to: givenStep.startTime)
        
        return daysDuration
    }
    
    var activeStage: Schedule.Stage {
        guard let firstStage = schedule.stages.first else {
            fatalError("Cannot start a bake with no stages")
        }
        
        return schedule.stages.first(where: {
            // first stage that contains an incomplete steps is the active stage
            $0.steps.contains(where: { !$0.isComplete })
        }) ?? firstStage
    }
}
