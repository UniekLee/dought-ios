//
//  Bake.swift
//  Dought
//
//  Created by Lee Watkins on 13/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import Foundation

class Bake {
    @Published var startTime: Date = Date(timeIntervalSince1970: TimeInterval(1588669200))
    @Published var steps: [BakeStep] = []
    @Published var finalStepDuration: Minutes = 120
    @Published var endTime: Date = Date()
        
    init() {
        self.endTime = TimeCalculator.add(bakeDuration, to: startTime)
    }
    
    func setEndTime(_ endTime: Date) {
        let negativeBakeDuration = -1 * bakeDuration
        if let newTime = Calendar.current.date(byAdding: .minute,
                                               value: negativeBakeDuration,
                                               to: endTime) {
            self.startTime = newTime
        }
    }
    
    private var bakeDuration: Minutes {
        let durations = steps.map({ $0.duration }) + [finalStepDuration]
        return durations.reduce(0) { $0 + $1 }
    }
}
